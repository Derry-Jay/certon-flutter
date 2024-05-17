import 'reply.dart';
import 'property.dart';
import 'package:flutter/material.dart';

class ContractorPropertyBase extends ChangeNotifier {
  final Reply base;
  final int docCount, count;
  final List<Property> owned, others;
  ContractorPropertyBase(
      this.base, this.owned, this.others, this.count, this.docCount);

  void onChange() {
    notifyListeners();
  }

  factory ContractorPropertyBase.fromMap(Map<String, dynamic> json) {
    return ContractorPropertyBase(
        Reply.fromMap(json),
        json['propdata'] == null && json['propdata'] == []
            ? <Property>[]
            : List<Map<String, dynamic>>.from(json['propdata'])
                .map(Property.fromMap)
                .toList(),
        json['otherpropDetails'] == null && json['otherpropDetails'] == []
            ? <Property>[]
            : List<Map<String, dynamic>>.from(json['otherpropDetails'])
                .map(Property.fromMap)
                .toList(),
        json['availableDocsCount'] ?? 0,
        json['to_be_added_document'] == null
            ? 0
            : (json['to_be_added_document'] is int
                ? json['to_be_added_document']
                : int.parse(json['to_be_added_document'] is String
                    ? (json['to_be_added_document'].isEmpty
                        ? '0'
                        : json['to_be_added_document'])
                    : json['to_be_added_document'].toString())));
  }
}
