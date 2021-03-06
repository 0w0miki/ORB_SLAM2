/**
* This file is part of ORB-SLAM2.
*
* Copyright (C) 2014-2016 Raúl Mur-Artal <raulmur at unizar dot es> (University of Zaragoza)
* For more information see <https://github.com/raulmur/ORB_SLAM2>
*
* ORB-SLAM2 is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* ORB-SLAM2 is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with ORB-SLAM2. If not, see <http://www.gnu.org/licenses/>.
*/


#include<iostream>
#include<algorithm>
#include<fstream>
#include<chrono>

#include<ros/ros.h>
#include <cv_bridge/cv_bridge.h>

#include <opencv2/core/core.hpp>

#include "System.h"
#include "geometry_msgs/TransformStamped.h"
#include "orb_slam2/MapKeyPoints.h"
#include <geometry_msgs/Point.h>
#include <visualization_msgs/Marker.h>
#include "tf/transform_datatypes.h"
#include <tf/transform_broadcaster.h>

using namespace std;

class ImageGrabber
{
public:
    ImageGrabber(ORB_SLAM2::System* pSLAM):mpSLAM(pSLAM){}

    void GrabImage(const sensor_msgs::ImageConstPtr& msg);

    ORB_SLAM2::System* mpSLAM;
};

ros::Publisher MP_pub;
ros::Publisher KP_pub;
ros::Publisher ORB_pub;

int main(int argc, char **argv)
{
    ros::init(argc, argv, "Mono");
    ros::start();
    
    ros::NodeHandle nodeHandler;
    ros::NodeHandle nh("~");
    std::string voc_path;
    std::string cal_path;
    std::string image;

    ros::param::get("~image",image);
    ros::param::get("~voc_path",voc_path);
    ros::param::get("~cal_path",cal_path);
    

    cout << "voc_path is " << voc_path << endl;
    cout << "cal_path is " << cal_path << endl;
    if (voc_path=="" && cal_path=="" && argc!=3)
    {
        cerr << endl << "Usage:(1) rosrun ORB_SLAM2 Mono path_to_vocabulary path_to_settings" << endl << "Usage:(2) roslaunch ORB_SLAM2 ORBSLAM.launch" << endl;
        ros::shutdown();
        return 1;
    }else if(argc == 3){
        cout << "argv[1] is " << argv[1] << endl;
        cout << "argv[2] is " << argv[2] << endl;
        voc_path = argv[1];
        cal_path = argv[2];
    }
    if (image == "")
    {
        image = "/camera/image_raw";
    }
    cout << "image topic is " << image << endl;

    // Create SLAM system. It initializes all system threads and gets ready to process frames.
    ORB_SLAM2::System SLAM(voc_path,cal_path,ORB_SLAM2::System::MONOCULAR,true);
    
    ImageGrabber igb(&SLAM);

    ros::Subscriber sub = nodeHandler.subscribe(image, 1, &ImageGrabber::GrabImage,&igb);
    MP_pub = nh.advertise<visualization_msgs::Marker>("MapPoints", 10000);
    KP_pub = nh.advertise<visualization_msgs::Marker>("KeyPoints", 10000);
    ORB_pub = nh.advertise<orb_slam2::MapKeyPoints>("MapKeyPoints", 10000);
    ros::spin();

    // Stop all threads
    SLAM.Shutdown();

    // Save camera trajectory
    SLAM.SaveKeyFrameTrajectoryTUM("KeyFrameTrajectory.txt");

    ros::shutdown();

    return 0;
}

void ImageGrabber::GrabImage(const sensor_msgs::ImageConstPtr& msg)
{
    // Copy the ros image message to cv::Mat.
    cv_bridge::CvImageConstPtr cv_ptr;
    try
    {
        cv_ptr = cv_bridge::toCvShare(msg);
    }
    catch (cv_bridge::Exception& e)
    {
        ROS_ERROR("cv_bridge exception: %s", e.what());
        return;
    }
    ros::Time frame_time = ros::Time::now();
    // mpSLAM->TrackMonocular(cv_ptr->image,cv_ptr->header.stamp.toSec());
    cv::Mat pose = mpSLAM->TrackMonocular(cv_ptr->image,cv_ptr->header.stamp.toSec());

    orb_slam2::MapKeyPoints MKP;
    MKP.header.stamp = ros::Time::now();
    MKP.header.frame_id = "ORB";
    MKP.frametime = frame_time;

    visualization_msgs::Marker points;
    points.header.frame_id = "/world";
    points.header.stamp = ros::Time::now();
    points.ns = "MapPoints";
    points.action = visualization_msgs::Marker::ADD;
    points.pose.orientation.w = 1.0;
    points.id = 0;
    points.type = visualization_msgs::Marker::POINTS;
    // POINTS markers use x and y scale for width/height respectively  
    points.scale.x = 0.2;  
    points.scale.y = 0.2; 
    points.color.r = 1.0f;
    points.color.a = 1.0;

    visualization_msgs::Marker keypoints;
    keypoints.header.frame_id = "/world";
    keypoints.header.stamp = ros::Time::now();
    keypoints.ns = "KeyPoints";
    keypoints.action = visualization_msgs::Marker::ADD;
    keypoints.pose.orientation.w = 1.0;
    keypoints.id = 0;
    keypoints.type = visualization_msgs::Marker::POINTS;
    // POINTS markers use x and y scale for width/height respectively  
    keypoints.scale.x = 2;  
    keypoints.scale.y = 2; 
    keypoints.color.g = 1.0f;
    keypoints.color.a = 1.0;


    ORB_SLAM2::Map* mpMap = mpSLAM->GetMap();
    // publish MapPoints
    std::vector<ORB_SLAM2::MapPoint*> mpMapPoints = mpMap->GetAllMapPoints();
    if (mpMapPoints.size() > 0){
        for (size_t i = 0; i < mpMapPoints.size(); i++) {
            if (mpMapPoints[i]) {
                cv::Mat WorldPos = mpMapPoints[i]->GetWorldPos();
                if(!WorldPos.empty()){
                    geometry_msgs::Point p;
                    cv::Point3f pos = cv::Point3f(WorldPos);
                    p.x = pos.x;
                    p.y = pos.y;
                    p.z = pos.z;
                    MKP.mappoints.push_back(p);
                    points.points.push_back(p);
                    geometry_msgs::Point kp;
                    kp.x = mpMapPoints[i]->mTrackProjX;
                    kp.y = mpMapPoints[i]->mTrackProjY;
                    kp.z = 0;
                    MKP.keypoints.push_back(kp);
                    keypoints.points.push_back(kp);
                }
            }
        }
        
    }

    
    // publish KeyPoints
    
    // publish TrackedKeypoints
    // std::vector<cv::KeyPoint> TrackedKeypoints = mpSLAM->GetTrackedKeyPointsUn();
    // for(uint32_t i = 0; i<TrackedKeypoints.size();i++){
    //     geometry_msgs::Point p;
    //     p.x = TrackedKeypoints[i].pt.x;
    //     p.y = TrackedKeypoints[i].pt.y;
    //     p.z = 0;
    //     points.points.push_back(p);
    // }
    MP_pub.publish(points);
    KP_pub.publish(keypoints);
    ORB_pub.publish(MKP);
    if (pose.empty())
        return;

    /* global left handed coordinate system */
    static cv::Mat pose_prev = cv::Mat::eye(4,4, CV_32F);
    static cv::Mat world_lh = cv::Mat::eye(4,4, CV_32F);
    // matrix to flip signs of sinus in rotation matrix, not sure why we need to do that
    static const cv::Mat flipSign = (cv::Mat_<float>(4,4) <<   1,-1,-1, 1,
                                                               -1, 1,-1, 1,
                                                               -1,-1, 1, 1,
                                                                1, 1, 1, 1);

    //prev_pose * T = pose
    cv::Mat translation =  (pose * pose_prev.inv()).mul(flipSign);
    world_lh = world_lh * translation;
    pose_prev = pose.clone();


    /* transform into global right handed coordinate system, publish in ROS*/
    tf::Matrix3x3 cameraRotation_rh(  - world_lh.at<float>(0,0),   world_lh.at<float>(0,1),   world_lh.at<float>(0,2),
                                  - world_lh.at<float>(1,0),   world_lh.at<float>(1,1),   world_lh.at<float>(1,2),
                                    world_lh.at<float>(2,0), - world_lh.at<float>(2,1), - world_lh.at<float>(2,2));

    tf::Vector3 cameraTranslation_rh( world_lh.at<float>(0,3),world_lh.at<float>(1,3), - world_lh.at<float>(2,3) );

    //rotate 270deg about x and 270deg about x to get ENU: x forward, y left, z up
    const tf::Matrix3x3 rotation270degXZ(   0, 1, 0,
                                            0, 0, 1,
                                            1, 0, 0);

    static tf::TransformBroadcaster br;

    tf::Matrix3x3 globalRotation_rh = cameraRotation_rh * rotation270degXZ;
    tf::Vector3 globalTranslation_rh = cameraTranslation_rh * rotation270degXZ;
    // tf::Transform transform = tf::Transform(globalRotation_rh, globalTranslation_rh);
    // br.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "world", "camera_pose"));
}


