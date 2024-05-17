import '../helpers/helper.dart';
import 'user.dart';
import 'property.dart';
// import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class Reply extends ChangeNotifier {
  final bool success;
  final String message;
  Reply(this.success, this.message);
  void onChange() {
    notifyListeners();
  }

  factory Reply.fromMap(Map<String, dynamic> json) {
    // try {
    log(json['messages']);
    log(json['message']);
    return Reply(json['success'] ?? false,
        json['message'] ?? (json['messages'] ?? (json['data'] ?? '')));
    // } catch (e) {
    //   log(e);
    //   log('reply');
    //   return Reply.emptyReply;
    // }
  }

  static Reply emptyReply = Reply(false, '');
}

class Reply2 extends ChangeNotifier {
  final bool success;
  final String message;
  Reply2(this.success, this.message);
  void onChange() {
    notifyListeners();
  }

  factory Reply2.fromMap(Map<String, dynamic> json) {
    // try {
    // log(json['success']);
    // log(json['message']);
    return Reply2(
        json['success'] ?? false, json['message'] ?? (json['messages'] ?? ''));
    // } catch (e) {
    //   log(e);
    //   log('reply');
    //   return Reply.emptyReply;
    // }
  }

  static Reply2 emptyReply = Reply2(false, '');
}

class Reply3 extends ChangeNotifier {
  final bool success;
  final List<String> message;
  Reply3(this.success, this.message);
  void onChange() {
    notifyListeners();
  }

  factory Reply3.fromMap(Map<String, dynamic> json) {
    // try {
    // log(json['success']);
    // log(json['message']);
    return Reply3(
        json['success'] ?? false, List<String>.from(json['message'] ?? ''));
    // } catch (e) {
    //   log(e);
    //   log('reply');
    //   return Reply.emptyReply;
    // }
  }

  static Reply3 emptyReply = Reply3(false, []);
}

class UpdateAccess extends ChangeNotifier {
  final bool success;
  final String message;
  UpdateAccess(this.success, this.message);
  void onChange() {
    notifyListeners();
  }

  factory UpdateAccess.fromMap(Map<String, dynamic> json) {
    return UpdateAccess(json['success'] ?? false, json['data'] ?? '');
  }

  static UpdateAccess emptyReply = UpdateAccess(false, '');
}

class PropertyScanStatus extends ChangeNotifier {
  final User user;
  final Reply base;
  final Property property;
  // final List<Property> linkProps;
  final int owned, access, lastCount, availableSpace, propertyStatus;
  PropertyScanStatus(
    this.base,
    this.owned,
    this.propertyStatus,
    this.access,
    this.lastCount,
    this.availableSpace,
    this.property,
    this.user,
  );

  static PropertyScanStatus emptyStatus = PropertyScanStatus(Reply.emptyReply,
      -1, -1, -1, 0, 0, Property.emptyProperty, User.emptyUser);

  void onChange() {
    notifyListeners();
  }

  factory PropertyScanStatus.fromMap(Map<String, dynamic> json) {
    return PropertyScanStatus(
      Reply.fromMap(json),
      json['propertOwned'] ?? 0,
      json['status_property'] ?? 0,
      json['propertyAccess'] ?? 0,
      json['to_be_added_document'] == null
          ? 0
          : (json['to_be_added_document'] is String
              ? (int.tryParse(json['to_be_added_document']) ?? 0)
              : json['to_be_added_document']),
      json['availableDocsCount'] ?? 0,
      json['propdata'] == null
          ? Property.emptyProperty
          : Property.fromMap(json['propdata']),
      json['usersData'] is! Map<String, dynamic> || json['usersData'] == null
          ? User.emptyUser
          : User.fromMap(json['usersData']),
    );
  }
}
