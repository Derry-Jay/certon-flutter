import 'reply.dart';
import 'document_type.dart';

class DocumentTypeBase {
  final Reply reply;
  final List<DocumentType> types;
  DocumentTypeBase(this.reply, this.types);
  factory DocumentTypeBase.fromMap(Map<String, dynamic> json) {
    final list =
        List<Map<String, dynamic>>.from(json['get_certificate_types'] ?? []);
    return DocumentTypeBase(
        Reply.fromMap(json),
        list.isEmpty
            ? <DocumentType>[]
            : list.map(DocumentType.fromMap).toList());
  }
}
