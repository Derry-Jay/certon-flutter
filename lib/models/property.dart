import 'dart:convert';
import 'property_type.dart';
import '../backend/api.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class Property extends ChangeNotifier {
  final int userID, accID, propID;
  final PropertyType type;
  final String uuID,
      propNo,
      qrCode,
      address1,
      address2,
      city,
      county,
      zipCode,
      date,
      address,
      fullAddress,
      showAddress,
      propertytypename,
      ownerName;
  final bool expired;
  Property(
      this.propID,
      this.uuID,
      this.userID,
      this.accID,
      this.propNo,
      this.qrCode,
      this.address1,
      this.address2,
      this.city,
      this.county,
      this.zipCode,
      this.type,
      this.date,
      this.address,
      this.showAddress,
      this.fullAddress,
      this.propertytypename,
      this.ownerName,
      this.expired);
  bool get isEmpty =>
      propID == -1 ||
      propID == 0 ||
      userID == -1 ||
      userID == 0 ||
      uuID.isEmpty;
  bool get isNotEmpty => !isEmpty;
  static Property emptyProperty = Property(-1, '', -1, -1, '', '', '', '', '',
      '', '', PropertyType(-1, '', 0), '', '', '', '', '', '', false);
  void onChange() {
    notifyListeners();
  }

  Map<String, dynamic> get json {
    Map<String, dynamic> mj = <String, dynamic>{};
    mj['id'] = propID.toString();
    mj['uuid'] = uuID;
    mj['user_id'] = userID.toString();
    mj['acc_id'] = accID.toString();
    mj['prop_number'] = propNo.toString();
    mj['qrcode'] = qrCode;
    mj['address1'] = address1;
    mj['address2'] = address2;
    mj['town'] = city;
    mj['county'] = county;
    mj['postcode'] = zipCode;
    mj['full_address'] = fullAddress;
    mj['purchase_date'] = date;
    mj['property_type_name'] = propertytypename;
    mj['property_owner_name'] = ownerName;
    mj['expired'] = expired;
    return mj;
  }

  Map<String, dynamic> get map {
    Map<String, dynamic> json = <String, dynamic>{};
    json['puuid'] = uuID;
    json['user_id'] = userID.toString();
    return json;
  }

  Map<String, dynamic> get jos {
    Map<String, dynamic> js = <String, dynamic>{};
    js['prop_id'] = propID.toString();
    js['user_id'] = currentUser.value.userID.toString();
    js['prop_user_id'] = userID.toString();
    return js;
  }

  factory Property.fromMap(Map<String, dynamic> json) {
    try {
      String address = (json['address'] ?? '').toString().trim();
      if (address.isNotEmpty && address.contains(', ,')) {
        address = address.replaceAll(', ,', '');
        log(address);
        if (!address.contains(', ') && address.contains(',')) {
          address = address.replaceAll(',', ', ');
        }
        log(address);
        if (address.endsWith(',')) {
          address = address.substring(0, address.length - 1);
        }
        log(address);
      }
      String completeAddress = json['full_address'] == null
          ? (json['text'] == null
              ? ''
              : json['text'].toString().split(' - ').last.trim())
          : json['full_address'].toString().trim();
      if (completeAddress.endsWith(',')) {
        completeAddress =
            completeAddress.substring(0, completeAddress.length - 1);
      }
      log(completeAddress);
      return Property(
          json['id'] == null
              ? -1
              : (json['id'] is int
                  ? json['id']
                  : (int.tryParse(json['id'] is String
                          ? json['id']
                          : json['id'].toString()) ??
                      -1)),
          json['uuid'] ?? '',
          json['user_id'] == null
              ? currentUser.value.userID
              : (json['user_id'] is int
                  ? json['user_id']
                  : (int.tryParse(json['user_id'] is String
                          ? json['user_id']
                          : json['user_id'].toString()) ??
                      currentUser.value.userID)),
          json['acc_id'] == null
              ? (json['req_acc_id'] == null
                  ? 0
                  : (json['req_acc_id'] is int
                      ? json['req_acc_id']
                      : (int.tryParse(json['req_acc_id'] is String
                              ? json['req_acc_id']
                              : json['req_acc_id'].toString()) ??
                          0)))
              : (json['acc_id'] is int
                  ? json['acc_id']
                  : (int.tryParse(json['acc_id'] is String
                      ? json['acc_id']
                      : json['acc_id'.toString()]))),
          json['prop_number'] ?? '',
          json['qrcode'] ?? '',
          json['address1'] ?? '',
          json['address2'] ?? '',
          json['town'] ?? '',
          json['county'] ?? '',
          json['postcode'] ?? '',
          PropertyType.fromMap(json),
          json['actualdate'] == null
              ? (json['date'] == null
                  ? ''
                  : (json['date'].toString().isEmpty
                      ? ''
                      : json['date'].toString().split('-').reversed.join('/')))
              : (json['actualdate'].toString().isEmpty
                  ? ''
                  : json['actualdate']
                      .toString()
                      .split('-')
                      .reversed
                      .join('/')),
          address,
          json['show_address'] ?? '',
          completeAddress,
          json['property_type_name'] ?? '',
          json['property_owner_name'] ?? '',
          json['expired'] ?? false);
    } catch (e) {
      sendAppLog(e);
      return Property.emptyProperty;
    }
  }

  bool isIn(List<Property> properties) {
    if (properties.isEmpty) {
      return properties.isNotEmpty;
    } else if (properties.length == 1) {
      return this == properties.single;
    } else {
      bool flag = false;
      for (Property p in properties) {
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
    return other is Property && propID == other.propID;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => userID.hashCode;

  @override
  String toString() {
    // TODO: implement toString
    return jsonEncode(json);
  }
}
