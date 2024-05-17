import 'reply.dart';
import 'property_type.dart';

class PropertyTypeBase {
  final Reply reply;
  final List<PropertyType> propertyTypes;
  PropertyTypeBase(this.reply, this.propertyTypes);
  factory PropertyTypeBase.fromMap(Map<String, dynamic> json) {
    return PropertyTypeBase(
        Reply.fromMap(json),
        json['get_property_types'] == null ||
                List<Map<String, dynamic>>.from(json['get_property_types'])
                    .isEmpty
            ? <PropertyType>[]
            : List<Map<String, dynamic>>.from(json['get_property_types'])
                .map(PropertyType.fromMap)
                .toList());
  }
}
