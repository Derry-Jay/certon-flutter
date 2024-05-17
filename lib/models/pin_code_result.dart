import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class PinCodeResult extends ChangeNotifier {
  final double latitude, longitude;
  final List<String> addresses;
  PinCodeResult(this.latitude, this.longitude, this.addresses);
  static PinCodeResult emptyResult = PinCodeResult(0.0, 0.0, <String>[]);
  void onChange() {
    notifyListeners();
  }

  factory PinCodeResult.fromMap(Map<String, dynamic> json) {
    bool removeCriterion(String element) {
      return element.isEmpty;
    }

    try {
      List<String> list =
          List<String>.from(json['addresses'] ?? json['message']);
      List<String> whereAbouts = <String>[];
      if (list.isNotEmpty) {
        for (String item in list) {
          List<String> parts = <String>[];
          for (String ele in item.toString().trim().split(',')) {
            if (ele.trim().isNotEmpty) {
              parts.add(ele.trim());
            }
          }
          parts.removeWhere(removeCriterion);
          final wa = parts.join(', ').trim();
          if (!whereAbouts.contains(wa)) {
            whereAbouts.add(wa);
          }
        }
      }
      whereAbouts.forEach(log);
      return PinCodeResult(json['latitude'], json['longitude'], whereAbouts);
    } catch (e) {
      sendAppLog(e);
      return PinCodeResult.emptyResult;
    }
  }
}
