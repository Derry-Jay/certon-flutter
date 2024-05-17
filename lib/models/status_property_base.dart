import 'user.dart';
import 'reply.dart';
import 'property.dart';
import 'package:flutter/material.dart';

class StatusPropertyBase extends ChangeNotifier {
  final Reply base;
  final User user;
  final int docCount, count, owned, access;
  final Property property;
  StatusPropertyBase(this.base, this.owned, this.access, this.count,
      this.docCount, this.property, this.user);

  void onChange() {
    notifyListeners();
  }

  factory StatusPropertyBase.fromMap(Map<String, dynamic> json) {
    return StatusPropertyBase(
        Reply.fromMap(json),
        json['propertOwned'],
        json['propertyAccess'],
        json['to_be_added_document'] == null
            ? 0
            : (json['to_be_added_document'] is int
                ? json['to_be_added_document']
                : (int.tryParse(json['to_be_added_document'] is String
                        ? json['to_be_added_document']
                        : json['to_be_added_document'].toString()) ??
                    0)),
        json['availableDocsCount'],
        Property.fromMap(json['propdata']),
        json['usersData'] is Map<String, dynamic>
            ? User.fromMap(json['usersData'])
            : User.emptyUser);
  }
}
