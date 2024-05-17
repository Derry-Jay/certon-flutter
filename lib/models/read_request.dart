import 'dart:convert';

import '../helpers/helper.dart';

ReadRequest readRequestFromMap(String str) =>
    ReadRequest.fromMap(json.decode(str));

// String readRequestToMap(ReadRequest data) => json.encode(data.toMap());

class ReadRequest {
  ReadRequest(
    this.success,
    this.requestAccess,
    this.propData,
    this.usersData,
  );

  final bool success;
  final RequestAccess requestAccess;
  final PropData propData;
  final UsersData usersData;

  static ReadRequest emptyReply = ReadRequest(false, RequestAccess.emptyReply,
      PropData.emptyReply, UsersData.emptyReply);

  factory ReadRequest.fromMap(Map<String, dynamic> json) {
    try {
      log(json);
      return ReadRequest(
        json['success'],
        /*json['requestAccess'] == null ? null :*/ RequestAccess.fromMap(
            json['requestAccess']),
        /*json['propData'] == null ? null :*/ PropData.fromMap(
            json['propData']),
        /*json['usersData'] == null ? null :*/ UsersData.fromMap(
            json['usersData']),
      );
    } catch (e) {
      sendAppLog(e);
      return ReadRequest.emptyReply;
    }
  }

  // Map<String, dynamic> toMap() => {
  //     'success': success == null ? null : success,
  //     'requestAccess': requestAccess == null ? null : requestAccess.toMap(),
  //     'propData': propData == null ? null : propData.toMap(),
  //     'usersData': usersData == null ? null : usersData.toMap(),
  // };
}

class PropData {
  PropData(
      this.id,
      this.uuid,
      this.userId,
      this.accId,
      this.propNumber,
      this.qrcode,
      this.address1,
      this.address2,
      this.town,
      this.county,
      this.postcode,
      this.country,
      this.type,
      this.date,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.fullAddress,
      this.propertytypename,
      this.propertyownername);

  final int id, type, userId, accId;
  final String uuid,
      propNumber,
      qrcode,
      address1,
      address2,
      town,
      county,
      postcode,
      country,
      date,
      status,
      createdAt,
      updatedAt,
      fullAddress,
      propertytypename,
      propertyownername;

  static PropData emptyReply = PropData(0, '', 0, 0, '', '', '', '', '', '', '',
      '', 0, '', '', '', '', '', '', '');

  factory PropData.fromMap(Map<String, dynamic> json) => PropData(
      json['id'] ?? 0,
      json['uuid'] ?? '',
      json['user_id'] ?? 0,
      json['acc_id'] ?? 0,
      json['prop_number'] ?? '',
      json['qrcode'] ?? '',
      json['address1'] ?? '',
      json['address2'] ?? '',
      json['town'] ?? '',
      json['county'] ?? '',
      json['postcode'] ?? '',
      json['country'] ?? '',
      json['type'] ?? 0,
      json['date'] ?? '',
      json['status'] ?? '',
      json['created_at'] ?? '',
      json['updated_at'] ?? '',
      json['full_address'] ?? '',
      json['property_type_name'] ?? '',
      json['property_owner_name'] ?? '');

  // Map<String, dynamic> toMap() => {
  //     'id': id == null ? null : id,
  //     'uuid': uuid == null ? null : uuid,
  //     'user_id': userId == null ? null : userId,
  //     'acc_id': accId == null ? null : accId,
  //     'prop_number': propNumber == null ? null : propNumber,
  //     'qrcode': qrcode == null ? null : qrcode,
  //     'address1': address1 == null ? null : address1,
  //     'address2': address2 == null ? null : address2,
  //     'town': town == null ? null : town,
  //     'county': county == null ? null : county,
  //     'postcode': postcode == null ? null : postcode,
  //     'country': country == null ? null : country,
  //     'type': type == null ? null : type,
  //     'date': date == null ? null : '',
  //     'status': status == null ? null : status,
  //     'created_at': createdAt == null ? null : createdAt,
  //     'updated_at': updatedAt == null ? null : updatedAt,
  //     'full_address': fullAddress == null ? null : fullAddress,
  // };
}

class RequestAccess {
  RequestAccess(this.id, this.propID, this.propUserID, this.userId, this.status,
      this.accessForever, this.expireDate, this.createdAt);

  final int? id;
  final int? propID;
  final int? propUserID;
  final int? userId;
  final int? status;
  final int? accessForever;
  final String? expireDate;
  final String? createdAt;

  static RequestAccess emptyReply = RequestAccess(0, 0, 0, 0, 0, 0, '', '');

  factory RequestAccess.fromMap(Map<String, dynamic> json) => RequestAccess(
        json['id'] ?? 0,
        json['prop_id'] ?? 0,
        json['prop_user_id'] ?? 0,
        json['user_id'] ?? 0,
        json['status'] ?? 0,
        json['access_forever'] ?? 0,
        json['expire_date'] ?? '',
        json['created_at'] ?? '',
      );

  // Map<String, dynamic> toMap() => {
  //     'id': id == null ? null : id,
  //     'prop_id': propId == null ? null : propId,
  //     'propUserID': propUserId == null ? null : propUserId,
  //     'user_id': userId == null ? null : userId,
  //     'status': status == null ? null : status,
  //     'access_forever': accessForever == null ? null : accessForever,
  //     'expire_date': expireDate,
  //     'created_at': createdAt == null ? null : createdAt,
  // };
}

class UsersData {
  UsersData(
    this.id,
    this.name,
    this.email,
    this.password,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.contactNo,
    this.contAddr1,
    this.contAddr2,
    this.contTown,
    this.contCounty,
    this.contPostcode,
    this.contCountry,
    this.uuid,
    this.status,
    this.verified,
    this.verifyToken,
    this.apiToken,
    this.lastLogin,
    this.haName,
    this.profilepicture,
    this.createdBy,
    this.isLoggedIn,
    this.roleName,
    this.roleId,
    this.companyname,
    this.companytel,
    this.companyregno,
    this.sectors,
    this.contractorInfoId,
    this.userstatus,
  );

  final int id,
      status,
      verified,
      createdBy,
      roleId,
      contractorInfoId,
      userstatus;
  final String name,
      email,
      password,
      rememberToken,
      createdAt,
      updatedAt,
      firstName,
      lastName,
      contactNo,
      contAddr1,
      contAddr2,
      contTown,
      contCounty,
      contPostcode,
      contCountry,
      uuid,
      verifyToken,
      apiToken,
      lastLogin,
      haName,
      profilepicture,
      isLoggedIn,
      roleName,
      companyname,
      companytel,
      companyregno,
      sectors;

  static UsersData emptyReply = UsersData(
      0,
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      0,
      0,
      '',
      '',
      '',
      '',
      '',
      0,
      '',
      '',
      0,
      '',
      '',
      '',
      '',
      0,
      0);

  factory UsersData.fromMap(Map<String, dynamic> json) => UsersData(
        json['id'] ?? 0,
        json['name'] ?? '',
        json['email'] ?? '',
        json['password'] ?? '',
        json['remember_token'] ?? '',
        json['created_at'] ?? '',
        json['updated_at'] ?? '',
        json['first_name'] ?? '',
        json['last_name'] ?? '',
        json['contact_no'] ?? '',
        json['cont_addr1'] ?? '',
        json['cont_addr2'] ?? '',
        json['cont_town'] ?? '',
        json['cont_county'] ?? '',
        json['cont_postcode'] ?? '',
        json['cont_country'] ?? '',
        json['uuid'] ?? '',
        json['status'] ?? 0,
        json['verified'] ?? 0,
        json['verify_token'] ?? '',
        json['api_token'] ?? '',
        json['last_login'] ?? '',
        json['ha_name'] ?? '',
        json['profilepicture'] ?? '',
        json['created_by'] ?? 0,
        json['is_logged_in'] ?? '',
        json['roleName'] ?? '',
        json['role_id'] ?? 0,
        json['companyname'] ?? '',
        json['companytel'] ?? '',
        json['companyregno'] ?? '',
        json['sectors'] ?? '',
        json['contractor_info_id'] ?? 0,
        json['userstatus'] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'remember_token': rememberToken,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'first_name': firstName,
        'last_name': lastName,
        'contact_no': contactNo,
        'cont_addr1': contAddr1,
        'cont_addr2': contAddr2,
        'cont_town': contTown,
        'cont_county': contCounty,
        'cont_postcode': contPostcode,
        'cont_country': contCountry,
        'uuid': uuid,
        'status': status,
        'verified': verified,
        'verify_token': verifyToken,
        'api_token': apiToken,
        'last_login': lastLogin,
        'ha_name': haName,
        'profilepicture': profilepicture,
        'created_by': createdBy,
        'is_logged_in': isLoggedIn,
        'roleName': roleName,
        'role_id': roleId,
        'companyname': companyname,
        'companytel': companytel,
        'companyregno': companyregno,
        'sectors': sectors,
        'contractor_info_id': contractorInfoId,
        'userstatus': userstatus
      };
}

/*
// class ReadRequest {
//   final bool success;
//   final String requestAccess;
//   final String propData;
//   final String usersData;

//    ReadRequest(this.success, this.propData, this.requestAccess, this.usersData);

//   factory ReadRequest.fromJson(Map<String, dynamic> json) {
//     return ReadRequest(
//      json['success'],
//      json['requestAccess'],
//      json['propData'],
//      json['usersData']
//     );
//   }

//    static ReadRequest emptyReply = ReadRequest(false, Property.emptyProperty, User.emptyUser);
// }






class ReadRequest {
  final bool success;
  final RequestAccessData requestAccess;
  final RequestAccessPropsData propData;
  final RequestAccessUsersData usersData;
  ReadRequest(this.success, this.requestAccess, this.propData, this.usersData);
  // static ReadRequest emptyType = ReadRequest(-1, '', 0);
  factory ReadRequest.fromJson(Map<String, dynamic> json) {
    return ReadRequest(
     json['success'],
     json['requestAccess'],
     json['propData'],
     json['usersData']
    );
  }

   static ReadRequest emptyReply = ReadRequest(false, RequestAccessData.emptyReply, RequestAccessPropsData.emptyReply, RequestAccessUsersData.emptyReply);

}

class RequestAccessData {
  final int? id;
  final int? prop_id;
  final int? propUserID;
  final int? user_id;
  final int? status;
  final int? accessForever;
  final String? expire_date;
  final String? createdAt;

  RequestAccessData(this.id, this.prop_id, this.propUserID, this.user_id, this.status, this.accessForever, this.expire_date, this.created_at);
  // static ReadRequest emptyType = ReadRequest(-1, '', 0);
  factory RequestAccessData.fromJson(Map<String, dynamic> json) {
    return RequestAccessData(
        json['id'] ?? 0,
         json['prop_id'] ?? 0,
        json['prop_user_id'] ?? 0,
        json['user_id'] ?? 0,
        json['status'] ?? 0,
         json['accessForever'] ?? 0,
         json['expire_date'] ?? 0,
        json['created_at'] ?? 0,
        );
  }

  static RequestAccessData emptyReply = RequestAccessData(0,0,0,0,0,0,'','');


}


class RequestAccessPropsData {
  final int id;
  final String uuid;
  final int user_id;
  final int acc_id;
  final String prop_number;
  final String qrcode;
  final String address1;
  final String address2;
  final String town;
  final String county;
  final String postcode;
  final String country;
  final int type;
  final String date;
  final String status;
  final String created_at;
  final String updated_at;
  final String full_address;

   static RequestAccessPropsData emptyReply = RequestAccessPropsData(0,'',0,0,'','','','','','','','',0,'','','','','');
  

  RequestAccessPropsData(this.id, this.uuid, this.user_id, this.acc_id, this.prop_number, this.qrcode, this.address1, this.address2, this.town, this.county, this.postcode, this.country, this.type, this.date, this.status, this.createdAt, this.updated_at, this.full_address);
  // static ReadRequest emptyType = ReadRequest(-1, '', 0);
  factory RequestAccessPropsData.fromJson(Map<String, dynamic> json) {
    return RequestAccessPropsData(
         json['id'] ?? 0,
         json['uuid'] ?? 0,
         json['user_id'] ?? 0,
         json['acc_id'] ?? 0,
         json['prop_number'] ?? 0,
         json['qrcode'] ?? 0,
         json['address1'] ?? 0,
         json['address2'] ?? 0,
         json['town'] ?? 0,
         json['county'] ?? 0,
         json['postcode'] ?? 0,
         json['country'] ?? 0,
         json['type'] ?? 0,
         json['date'] ?? 0,
         json['status'] ?? 0,
         json['created_at'] ?? 0,
         json['updated_at'] ?? 0,
         json['full_address'] ?? 0,
     
        );
  }

}

class RequestAccessUsersData {
  

        final int id;
       final String  name;
        final String email;
        final String password;
        final String remember_token;
       final String  createdAt;
        final String updated_at;
        final String first_name;
        final String last_name;
        final String contact_no;
        final String cont_addr1;
        final String cont_addr2;
        final String cont_town;
        final String cont_county;
        final String cont_postcode;
        final String cont_country;
        final String uuid;
      final int  status;
      final int  verified;
        final String verify_token;
        final String api_token;
        final String last_login;
        final String ha_name;
        final String profilepicture;
        final String created_by;
        final String is_logged_in;
        final String roleName;
      final int  role_id;
        final String companyname;
        final String companytel;
        final String companyregno;
        final String sectors;
       final int contractor_info_id;
      final int  userstatus;

      static RequestAccessUsersData emptyReply = RequestAccessUsersData(0,'','','','','','','','','','','','','','','','',0,0,'','','','','','','','',0,'','','','',0,0);
  
  

  RequestAccessUsersData(this.id, this.name, this.email, this.password, this.remember_token, this.created_at, this.updated_at, this.first_name, this.last_name, this.contact_no, this.cont_addr1, this.cont_addr2, this.cont_town, this.cont_county, this.cont_postcode, this.cont_country, this.uuid, this.status, this.verified, this.verify_token, this.api_token, this.last_login, this.ha_name, this.profilepicture, this.created_by, this.is_logged_in, this.roleName, this.role_id, this.companyname, this.companytel, this.companyregno, this.sectors, this.contractor_info_id, this.userstatus);
  // static ReadRequest emptyType = ReadRequest(-1, '', 0);
  factory RequestAccessUsersData.fromMap(Map<String, dynamic> json) {
    return RequestAccessUsersData(
        json['id'] ?? 0,
        json['name'] ?? 0,
        json['email'] ?? 0,
        json['password'] ?? 0,
        json['remember_token'] ?? 0,
        json['created_at'] ?? 0,
        json['updated_at'] ?? 0,
        json['first_name'] ?? 0,
        json['last_name'] ?? 0,
        json['contact_no'] ?? 0,
        json['cont_addr1'] ?? 0,
        json['cont_addr2'] ?? 0,
        json['cont_town'] ?? 0,
        json['cont_county'] ?? 0,
        json['cont_postcode'] ?? 0,
        json['cont_country'] ?? 0,
        json['uuid'] ?? 0,
        json['status'] ?? 0,
        json['verified'] ?? 0,
        json['verify_token'] ?? 0,
        json['api_token'] ?? 0,
        json['last_login'] ?? 0,
        json['ha_name'] ?? 0,
        json['profilepicture'] ?? 0,
        json['created_by'],
        json['is_logged_in'],
        json['roleName'],
        json['role_id'],
        json['companyname'],
        json['companytel'],
        json['companyregno'],
        json['sectors'],
        json['contractor_info_id'],
        json['userstatus'],
     
        );
  }

}

*/