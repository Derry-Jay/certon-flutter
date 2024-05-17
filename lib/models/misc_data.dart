import 'reply.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class OtherData extends ChangeNotifier {
  final Reply reply;
  final dynamic data;

  OtherData(this.reply, this.data);
  void onChange() {
    notifyListeners();
  }

  factory OtherData.fromMap(Map<String, dynamic> json) {
    log(json);
    return OtherData(
        Reply.fromMap(json),
        json['status_property'] ??
            (json['property_id'] ??
                (json['count'] ?? (json['filename'].toString()))));
  }
}
