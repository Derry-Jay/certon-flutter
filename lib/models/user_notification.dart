import '../backend/api.dart';
import 'package:flutter/material.dart';

class UserNotification extends ChangeNotifier {
  final int notificationID,
      requestAccessID,
      requestStatus,
      accessForever,
      notificationType,
      readStatus;
  final String address,
      uuID,
      firstName,
      lastName,
      expiryDate,
      propNo,
      userName,
      message,
      content,
      createdAt,
      alert_msg,
      time;

  UserNotification(
    this.notificationID,
    this.requestAccessID,
    this.requestStatus,
    this.address,
    this.uuID,
    this.firstName,
    this.lastName,
    this.accessForever,
    this.expiryDate,
    this.readStatus,
    this.notificationType,
    this.propNo,
    this.message,
    this.userName,
    this.content,
    this.createdAt,
    this.alert_msg,
    this.time,
  );

  static UserNotification emptyNotification = UserNotification(
      -1, 0, -1, '', '', '', '', -1, '', -1, 0, '', '', '', '', '','', '');

  Map<String, dynamic> get json {
    Map<String, dynamic> map = <String, dynamic>{};
    map['notification_id'] = notificationID.toString();
    map['req_acc_id'] = requestAccessID.toString();
    map['req_status'] = requestStatus.toString();
    map['address1'] = address;
    map['uuid'] = uuID;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['access_forever'] = accessForever.toString();
    map['expire_date'] = expiryDate;
    map['read_status'] = readStatus.toString();
    map['not_type'] = notificationType.toString();
    map['prop_number'] = propNo;
    map['msg'] = message;
    map['username'] = userName;
    map['text'] = content;
    map['time'] = time;
    map['created_at'] = createdAt;
     map['alert_msg'] = alert_msg;

    return map;
  }

  Map<String, dynamic> get map {
    Map<String, dynamic> json = <String, dynamic>{};
    json['userid'] = currentUser.value.userID.toString();
    json['notificationid'] = notificationID.toString();
    return json;
  }

  Map<String, dynamic> get thd {
    Map<String, dynamic> mj = <String, dynamic>{};
    mj['notification_ids'] = [notificationID.toString()];
    return mj;
  }

  void onChange() {
    notifyListeners();
  }

  bool isIn(List<UserNotification> notifications) {
    if (notifications.isEmpty) {
      return notifications.isNotEmpty;
    } else if (notifications.length == 1) {
      return this == notifications.single;
    } else {
      bool flag = false;
      for (UserNotification p in notifications) {
        if (this == p) {
          flag = true;
          break;
        }
      }
      return flag;
    }
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is UserNotification && notificationID == other.notificationID;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => notificationID.hashCode;

  factory UserNotification.fromMap(Map<String, dynamic> json) {
    return UserNotification(
        json['notification_id'],
        json['req_acc_id'] ?? 0,
        json['req_status'] ?? 0,
        json['address1'] ?? '',
        json['uuid'] ?? '',
        json['first_name'] ?? '',
        json['last_name'] ?? '',
        json['access_forever'] ?? 0,
        json['expire_date'] ?? '',
        json['read_status'] == null
            ? 0
            : (json['read_status'] is int
                ? json['read_status']
                : (int.tryParse(json['read_status'] is String
                        ? json['read_status']
                        : json['read_status'].toString()) ??
                    0)),
        json['not_type'] == null
            ? 0
            : (json['not_type'] is int
                ? json['not_type']
                : (int.tryParse(json['not_type'] is String
                        ? json['not_type']
                        : json['not_type'].toString()) ??
                    0)),
        json['prop_number'] ?? '',
        json['msg'] ?? '',
        json['username'] ?? '',
        json['text'] ?? '',
        json['created_at'] ?? '',
        json['alert_msg'] ?? '',
        json['time'] ?? '');
  }
}
