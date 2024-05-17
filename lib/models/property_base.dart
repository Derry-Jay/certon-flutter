// import '../helpers/helper.dart';
import 'reply.dart';
import 'dart:convert';
import 'property.dart';
import 'package:flutter/material.dart';

class PropertyBase extends ChangeNotifier {
  final Reply reply;
  final int docCount, count;
  final List<Property> properties;
  PropertyBase(this.reply, this.docCount, this.properties, this.count);
  void onChange() {
    notifyListeners();
  }

  factory PropertyBase.fromMap(Map<String, dynamic> json) {
    // log('List');
    // log(json['propdata'].runtimeType);
    // log([].runtimeType);
    final ite =
        json['propdata'] == null || (json['propdata'] as List<dynamic>).isEmpty
            ? json['otherpropDetails']
            : (json['propdata'] is String
                ? (json['propdata'].toString().isEmpty
                    ? json['otherpropDetails']
                    : jsonDecode(json['propdata']))
                : json['propdata']);
    final list = List<Map<String, dynamic>>.from(ite);
    return PropertyBase(
        Reply.fromMap(json),
        json['availableDocsCount'] ?? 0,
        list.isEmpty
            ? <Property>[]
            : list.map<Property>(Property.fromMap).toList(),
        json['to_be_added_document'] == null
            ? 0
            : (json['to_be_added_document'] is int
                ? json['to_be_added_document']
                : (int.tryParse(json['to_be_added_document'] is String
                        ? (json['to_be_added_document'].isEmpty
                            ? '0'
                            : json['to_be_added_document'])
                        : json['to_be_added_document'].toString()) ??
                    -1)));
  }
}
