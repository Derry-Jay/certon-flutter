import '../helpers/helper.dart';

class AccessList {
  final bool success;
  final String message;
  List<AccessListData> data;
  AccessOthersListData propowner;
  AccessList(this.success, this.message, this.data, this.propowner);

  // factory AccessList.fromMap(Map<String, dynamic> json) {
  //   return AccessList(
  //       json['success'] ?? false,
  //       json['message'] ?? (json['messages'] ?? '') ?? '',
  //       json['data'] ?? [AccessListData.emptyReply]);
  // }

  factory AccessList.fromMap(Map<String, dynamic> json) {
    log(json['data']);
    final list = List<Map<String, dynamic>>.from(
        json['data'] ?? <Map<String, dynamic>>[]);

    return AccessList(
        json['success'] ?? false,
        json['message'] ?? '',
        json['data'] == null || list.isEmpty
            ? <AccessListData>[]
            : list.map(AccessListData.fromMap).toList(),
        AccessOthersListData.fromMap(json['prop_owner'] is List
            ? <String, dynamic>{}
            : json['prop_owner']));
  }

  static AccessList emptyReply = AccessList(
      false, '', <AccessListData>[], AccessOthersListData.emptyReply);
}

class AccessListData {
  final int propID;
  final int propUserID;
  final int status;
  final int accessForever;
  final int requestAccessID;
  final int userID;
  final int userAccessRole;
  final String expiryDate, name, daysRemaining;
  final bool expired;

  AccessListData(
      this.propID,
      this.propUserID,
      this.status,
      this.accessForever,
      this.expiryDate,
      this.name,
      this.requestAccessID,
      this.userAccessRole,
      this.daysRemaining,
      this.userID,
      this.expired);

  factory AccessListData.fromMap(Map<String, dynamic> json) {
    log(json);
    return AccessListData(
        json['prop_id'] ?? 0,
        json['prop_user_id'] ?? 0,
        json['status'] ?? 0,
        json['access_forever'] ?? 0,
        json['expire_date'] ?? '',
        json['name'] ?? '',
        json['req_acc_id'] ?? 0,
        json['user_access_role'] ?? 0,
        json['remaining_days'] ?? '',
        json['user_id'] ?? 0,
        json['expired'] ?? false);
  }

  static AccessListData emptyReply =
      AccessListData(0, 0, 0, 0, '', '', 0, 0, '', 0, false);
}

class AccessOthersListData {
  final int propID;
  final int propUserID;
  final int status;
  final int accessForever;
  final int requestAccessID;
  final int userID;
  final int userAccessRole;
  final String expiryDate, name, daysRemaining;
  final bool expired;

  AccessOthersListData(
      this.propID,
      this.propUserID,
      this.status,
      this.accessForever,
      this.expiryDate,
      this.name,
      this.requestAccessID,
      this.userAccessRole,
      this.daysRemaining,
      this.userID,
      this.expired);

  factory AccessOthersListData.fromMap(Map<String, dynamic> json) {
    log(json);
    return AccessOthersListData(
        json['prop_id'] ?? 0,
        json['prop_user_id'] ?? 0,
        json['status'] ?? 0,
        json['access_forever'] ?? 0,
        json['expire_date'] ?? '',
        json['name'] ?? '',
        json['req_acc_id'] ?? 0,
        json['user_access_role'] ?? 0,
        json['remaining_days'] ?? '',
        json['user_id'] ?? 0,
        json['expired'] ?? false);
  }

  static AccessOthersListData emptyReply =
      AccessOthersListData(0, 0, 0, 0, '', '', 0, 0, '', 0, false);
}
