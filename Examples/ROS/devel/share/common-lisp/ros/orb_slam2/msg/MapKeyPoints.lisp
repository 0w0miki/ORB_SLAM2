; Auto-generated. Do not edit!


(cl:in-package orb_slam2-msg)


;//! \htmlinclude MapKeyPoints.msg.html

(cl:defclass <MapKeyPoints> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (frametime
    :reader frametime
    :initarg :frametime
    :type cl:real
    :initform 0)
   (mappoints
    :reader mappoints
    :initarg :mappoints
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (keypoints
    :reader keypoints
    :initarg :keypoints
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point))))
)

(cl:defclass MapKeyPoints (<MapKeyPoints>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MapKeyPoints>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MapKeyPoints)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name orb_slam2-msg:<MapKeyPoints> is deprecated: use orb_slam2-msg:MapKeyPoints instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MapKeyPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader orb_slam2-msg:header-val is deprecated.  Use orb_slam2-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'frametime-val :lambda-list '(m))
(cl:defmethod frametime-val ((m <MapKeyPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader orb_slam2-msg:frametime-val is deprecated.  Use orb_slam2-msg:frametime instead.")
  (frametime m))

(cl:ensure-generic-function 'mappoints-val :lambda-list '(m))
(cl:defmethod mappoints-val ((m <MapKeyPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader orb_slam2-msg:mappoints-val is deprecated.  Use orb_slam2-msg:mappoints instead.")
  (mappoints m))

(cl:ensure-generic-function 'keypoints-val :lambda-list '(m))
(cl:defmethod keypoints-val ((m <MapKeyPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader orb_slam2-msg:keypoints-val is deprecated.  Use orb_slam2-msg:keypoints instead.")
  (keypoints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MapKeyPoints>) ostream)
  "Serializes a message object of type '<MapKeyPoints>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'frametime)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'frametime) (cl:floor (cl:slot-value msg 'frametime)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'mappoints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'mappoints))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'keypoints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'keypoints))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MapKeyPoints>) istream)
  "Deserializes a message object of type '<MapKeyPoints>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frametime) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'mappoints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'mappoints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'keypoints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'keypoints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MapKeyPoints>)))
  "Returns string type for a message object of type '<MapKeyPoints>"
  "orb_slam2/MapKeyPoints")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MapKeyPoints)))
  "Returns string type for a message object of type 'MapKeyPoints"
  "orb_slam2/MapKeyPoints")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MapKeyPoints>)))
  "Returns md5sum for a message object of type '<MapKeyPoints>"
  "b41fe03c1397cf4c381f01fea192e4c6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MapKeyPoints)))
  "Returns md5sum for a message object of type 'MapKeyPoints"
  "b41fe03c1397cf4c381f01fea192e4c6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MapKeyPoints>)))
  "Returns full string definition for message of type '<MapKeyPoints>"
  (cl:format cl:nil "Header header~%time frametime~%geometry_msgs/Point[] mappoints~%geometry_msgs/Point[] keypoints~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MapKeyPoints)))
  "Returns full string definition for message of type 'MapKeyPoints"
  (cl:format cl:nil "Header header~%time frametime~%geometry_msgs/Point[] mappoints~%geometry_msgs/Point[] keypoints~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MapKeyPoints>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'mappoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'keypoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MapKeyPoints>))
  "Converts a ROS message object to a list"
  (cl:list 'MapKeyPoints
    (cl:cons ':header (header msg))
    (cl:cons ':frametime (frametime msg))
    (cl:cons ':mappoints (mappoints msg))
    (cl:cons ':keypoints (keypoints msg))
))
