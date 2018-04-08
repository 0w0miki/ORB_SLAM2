
(cl:in-package :asdf)

(defsystem "ORB_SLAM2-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "MapKeyPoints" :depends-on ("_package_MapKeyPoints"))
    (:file "_package_MapKeyPoints" :depends-on ("_package"))
  ))