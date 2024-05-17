import '../helpers/helper.dart';
import 'role.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class User extends ChangeNotifier {
   int userID,
      status,
      userStatus,
      notificationCount,
      createdBy,
      verified,
      countryCode,
      loginStatus;
   String userName,
      userEmail,
      token,
      firstName,
      lastName,
      phoneNo,
      address1,
      address2,
      city,
      uuID,
      pinCode;
   Role role;
   List<int>? sectors;
   int? contractorInfoID;
   String? companyName, companyPhone, companyNo;
   int? emailnotification, pushnotification;
  User(
      this.userID,
      this.userName,
      this.userEmail,
      this.firstName,
      this.lastName,
      this.phoneNo,
      this.address1,
      this.address2,
      this.city,
      this.pinCode,
      this.countryCode,
      this.uuID,
      this.status,
      this.verified,
      this.token,
      this.createdBy,
      this.loginStatus,
      this.role,
      this.userStatus,
      this.notificationCount,
      this.emailnotification,
      this.pushnotification,
      {this.companyName,
      this.companyPhone,
      this.companyNo,
      this.sectors,
      this.contractorInfoID});
  bool get isEmpty => userID == -1 || userID == 0;
  bool get isNotEmpty => !isEmpty;
  bool get isOwner => isNotEmpty && role.roleID == 3;
  bool get isContractor => isNotEmpty && role.roleID == 5;
  bool get isLandlord => isNotEmpty && role.roleID == 4;
  static User emptyUser = User(-1, '', '', '', '', '', '', '', '', '', -1, '',
      -1, -1, '', -1, -1, Role(-1, ''), -1, -1, 0, 0);
  void onChange() {
    notifyListeners();
  }

  Map<String, dynamic> get json {
    Map<String, dynamic> map = role.json;
    map['id'] = userID;
    map['name'] = userName;
    map['email'] = userEmail;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['contact_no'] = phoneNo;
    map['cont_addr1'] = address1;
    map['cont_addr2'] = address2;
    map['cont_town'] = city;
    map['cont_postcode'] = pinCode;
    map['cont_country'] = countryCode;
    map['uuid'] = uuID;
    map['status'] = status;
    map['verified'] = verified;
    map['api_token'] = token;
    map['created_by'] = createdBy;
    map['is_logged_in'] = loginStatus;
    map['userstatus'] = userStatus;
    map['notification_count'] = notificationCount;
    map['email_notification'] = emailnotification;
    map['push_notification'] = pushnotification;
    if (isContractor) {
      map['companyname'] = companyName;
      map['companytel'] = companyPhone;
      map['companyregno'] = companyNo;
      map['sectors'] = sectors;
    }
    return map;
  }

  Map<String, dynamic> get map {
    Map<String, dynamic> json = <String, dynamic>{};
    json['user_id'] = userID.toString();
    return json;
  }

  factory User.fromMap(Map<String, dynamic> json) {
    try {
      log(json['sectors']);
      log('object');
      final list = json['sectors'].toString().contains('[') &&
              json['sectors'].toString().contains(']')
          ? jsonDecode(json['sectors'].toString()) as List<dynamic>
          : [];
      return User(
          json['id'] ?? json['user_id'] ?? 0,
          json['name'] ?? '',
          json['email'] ?? '',
          json['first_name'] ?? '',
          json['last_name'] ?? '',
          json['contact_no'] ?? '',
          json['cont_addr1'] ?? '',
          json['cont_addr2'] ?? '',
          json['cont_town'] ?? '',
          json['cont_postcode'] ?? '',
          json['cont_country'] == null
              ? 0
              : (json['cont_country'] is int
                  ? json['cont_country']
                  : mapInt(json['cont_country'])),
          json['uuid'] ?? '',
          json['status'] ?? 0,
          json['verified'] ?? 0,
          json['api_token'] ?? '',
          json['created_by'] ?? 0,
          json['is_logged_in'] == null
              ? -1
              : (json['is_logged_in'] is int
                  ? json['is_logged_in']
                  : mapInt(json['is_logged_in'])),
          Role.fromMap(json),
          json['userstatus'] ?? 0,
          json['notification_count'] ?? 0,
          json['email_notification'] ?? 0,
          json['push_notification'] ?? 0,
          companyName: json['role_id'] == 5 ? json['companyname'] : null,
          companyPhone: json['role_id'] == 5 ? json['companytel'] : null,
          sectors: json['role_id'] == 5 ||
                  (json['sectors']?.toString().isNotEmpty ?? false)
              ? ((json['sectors'].toString().contains('[') &&
                          json['sectors'].toString().contains(']')
                      ? list
                      : json['sectors'].toString().split(','))
                  .map<int>(mapInt)
                  .toList())
              : null,
          contractorInfoID:
              json['role_id'] == 5 ? json['contractor_info_id'] : null,
          companyNo: json['role_id'] == 5 ? json['companyregno'] : null);
    } catch (e) {
      sendAppLog(e);
      log('object');
      return User.emptyUser;
    }
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is User && userID == other.userID;
  }

  @override
  String toString() {
    // TODO: implement toString
    return jsonEncode(json);
  }

  @override
  // TODO: implement hashCode
  int get hashCode => userID.hashCode;
}
