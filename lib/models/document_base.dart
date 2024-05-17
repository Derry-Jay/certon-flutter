import 'reply.dart';
import 'document.dart';
import 'package:flutter/material.dart';

class DocumentBase extends ChangeNotifier {
  final Reply reply;
  final String url;
  final List<Document> documents;
  DocumentBase(this.reply, this.documents, this.url);
  void onChange() {
    notifyListeners();
  }

  factory DocumentBase.fromMap(Map<String, dynamic> json) {
    final list = List<Map<String, dynamic>>.from(
        json['docData'] ?? <Map<String, dynamic>>[]);
    return DocumentBase(
        Reply.fromMap(json),
        json['docData'] == null || list.isEmpty || !json.containsKey('docData')
            ? <Document>[]
            : list.map(Document.fromMap).toList(),
        json['doc_url'] ?? '');
  }
}
