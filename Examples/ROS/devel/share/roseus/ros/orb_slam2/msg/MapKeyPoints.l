;; Auto-generated. Do not edit!


(when (boundp 'orb_slam2::MapKeyPoints)
  (if (not (find-package "ORB_SLAM2"))
    (make-package "ORB_SLAM2"))
  (shadow 'MapKeyPoints (find-package "ORB_SLAM2")))
(unless (find-package "ORB_SLAM2::MAPKEYPOINTS")
  (make-package "ORB_SLAM2::MAPKEYPOINTS"))

(in-package "ROS")
;;//! \htmlinclude MapKeyPoints.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass orb_slam2::MapKeyPoints
  :super ros::object
  :slots (_header _frametime _mappoints _keypoints ))

(defmethod orb_slam2::MapKeyPoints
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:frametime __frametime) (instance ros::time :init))
    ((:mappoints __mappoints) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    ((:keypoints __keypoints) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _frametime __frametime)
   (setq _mappoints __mappoints)
   (setq _keypoints __keypoints)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:frametime
   (&optional __frametime)
   (if __frametime (setq _frametime __frametime)) _frametime)
  (:mappoints
   (&rest __mappoints)
   (if (keywordp (car __mappoints))
       (send* _mappoints __mappoints)
     (progn
       (if __mappoints (setq _mappoints (car __mappoints)))
       _mappoints)))
  (:keypoints
   (&rest __keypoints)
   (if (keywordp (car __keypoints))
       (send* _keypoints __keypoints)
     (progn
       (if __keypoints (setq _keypoints (car __keypoints)))
       _keypoints)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; time _frametime
    8
    ;; geometry_msgs/Point[] _mappoints
    (apply #'+ (send-all _mappoints :serialization-length)) 4
    ;; geometry_msgs/Point[] _keypoints
    (apply #'+ (send-all _keypoints :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; time _frametime
       (write-long (send _frametime :sec) s) (write-long (send _frametime :nsec) s)
     ;; geometry_msgs/Point[] _mappoints
     (write-long (length _mappoints) s)
     (dolist (elem _mappoints)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Point[] _keypoints
     (write-long (length _keypoints) s)
     (dolist (elem _keypoints)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; time _frametime
     (send _frametime :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _frametime :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Point[] _mappoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _mappoints (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _mappoints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Point[] _keypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _keypoints (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _keypoints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get orb_slam2::MapKeyPoints :md5sum-) "b41fe03c1397cf4c381f01fea192e4c6")
(setf (get orb_slam2::MapKeyPoints :datatype-) "orb_slam2/MapKeyPoints")
(setf (get orb_slam2::MapKeyPoints :definition-)
      "Header header
time frametime
geometry_msgs/Point[] mappoints
geometry_msgs/Point[] keypoints
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :orb_slam2/MapKeyPoints "b41fe03c1397cf4c381f01fea192e4c6")


