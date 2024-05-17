import '../helpers/helper.dart';
import 'package:flutter/foundation.dart';

class PropertyType extends ChangeNotifier {
  final int typeID, sorting;
  final String type;
  PropertyType(this.typeID, this.type, this.sorting);
  static PropertyType empty = PropertyType(-1, '', -1);
  factory PropertyType.fromMap(Map<String, dynamic> json) {
    try {
      return PropertyType(
          json['type'] == null
              ? (json['id'] == null
                  ? -1
                  : (json['id'] is int
                      ? json['id']
                      : (int.tryParse(json['id'] is String
                              ? json['id']
                              : json['id'].toString()) ??
                          -1)))
              : (json['type'] is int
                  ? json['type']
                  : (int.tryParse(json['type'] is String
                          ? json['type']
                          : json['type'].toString()) ??
                      -1)),
          json['property_type_name'] ?? (json['name'] ?? ''),
          json['sorting'] ?? 0);
    } catch (e) {
      sendAppLog(e);
      return PropertyType.empty;
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return type.isEmpty || type == 'null' ? '' : type;
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is PropertyType && other.typeID == typeID;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => typeID.hashCode;
}
