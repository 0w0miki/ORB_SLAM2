// Auto-generated. Do not edit!

// (in-package orb_slam2.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class MapKeyPoints {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.frametime = null;
      this.mappoints = null;
      this.keypoints = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('frametime')) {
        this.frametime = initObj.frametime
      }
      else {
        this.frametime = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('mappoints')) {
        this.mappoints = initObj.mappoints
      }
      else {
        this.mappoints = [];
      }
      if (initObj.hasOwnProperty('keypoints')) {
        this.keypoints = initObj.keypoints
      }
      else {
        this.keypoints = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MapKeyPoints
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [frametime]
    bufferOffset = _serializer.time(obj.frametime, buffer, bufferOffset);
    // Serialize message field [mappoints]
    // Serialize the length for message field [mappoints]
    bufferOffset = _serializer.uint32(obj.mappoints.length, buffer, bufferOffset);
    obj.mappoints.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [keypoints]
    // Serialize the length for message field [keypoints]
    bufferOffset = _serializer.uint32(obj.keypoints.length, buffer, bufferOffset);
    obj.keypoints.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MapKeyPoints
    let len;
    let data = new MapKeyPoints(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [frametime]
    data.frametime = _deserializer.time(buffer, bufferOffset);
    // Deserialize message field [mappoints]
    // Deserialize array length for message field [mappoints]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.mappoints = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.mappoints[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [keypoints]
    // Deserialize array length for message field [keypoints]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.keypoints = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.keypoints[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 24 * object.mappoints.length;
    length += 24 * object.keypoints.length;
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'orb_slam2/MapKeyPoints';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b41fe03c1397cf4c381f01fea192e4c6';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MapKeyPoints(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.frametime !== undefined) {
      resolved.frametime = msg.frametime;
    }
    else {
      resolved.frametime = {secs: 0, nsecs: 0}
    }

    if (msg.mappoints !== undefined) {
      resolved.mappoints = new Array(msg.mappoints.length);
      for (let i = 0; i < resolved.mappoints.length; ++i) {
        resolved.mappoints[i] = geometry_msgs.msg.Point.Resolve(msg.mappoints[i]);
      }
    }
    else {
      resolved.mappoints = []
    }

    if (msg.keypoints !== undefined) {
      resolved.keypoints = new Array(msg.keypoints.length);
      for (let i = 0; i < resolved.keypoints.length; ++i) {
        resolved.keypoints[i] = geometry_msgs.msg.Point.Resolve(msg.keypoints[i]);
      }
    }
    else {
      resolved.keypoints = []
    }

    return resolved;
    }
};

module.exports = MapKeyPoints;
