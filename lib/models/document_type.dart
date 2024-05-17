import '../helpers/helper.dart';

class DocumentType {
  final int typeID, sorting;
  final String type;
  DocumentType(this.typeID, this.type, this.sorting);
  static DocumentType emptyType = DocumentType(-1, '', 0);
  factory DocumentType.fromMap(Map<String, dynamic> json) {
    log(json);
    log('josn valuesaadfsdg');
    return DocumentType(json['type'] ?? (json['id'] ?? -1),
        json['document_type'] ?? (json['name'] ?? ''), json['sorting'] ?? 0);
  }

  @override
  String toString() {
    // TODO: implement toString
    return type.isEmpty || type == 'null' ? '' : type;
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is DocumentType && typeID == other.typeID;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => typeID.hashCode;
}
