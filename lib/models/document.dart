import 'document_type.dart';
import 'package:flutter/material.dart';

class Document extends ChangeNotifier {
  final int docID, docNo, accID, userID, propID, transactionID, boughtStatus;
  final String uuID,
      docName,
      deleteDate,
      expiryDate,
      description,
      stripeTokenID,
      balanceTransactionID,
      boughtDate,
      puuID,
      address,
      sharedurl;
  final List<String> files;
  final DocumentType type;

  Document(
      this.docID,
      this.uuID,
      this.docName,
      this.type,
      this.docNo,
      this.files,
      this.accID,
      this.userID,
      this.propID,
      this.deleteDate,
      this.expiryDate,
      this.description,
      this.stripeTokenID,
      this.balanceTransactionID,
      this.boughtDate,
      this.boughtStatus,
      this.transactionID,
      this.puuID,
      this.address,
      this.sharedurl);
  static Document emptyDocument = Document(-1, '', '', DocumentType.emptyType,
      -1, <String>[], -1, -1, -1, '', '', '', '', '', '', -1, -1, '', '', '');
  void onChange() {
    notifyListeners();
  }

  factory Document.fromMap(Map<String, dynamic> json) {
    return Document(
        json['id'] ?? -1,
        json['uuid'] ?? '',
        json['name'] ?? '',
        DocumentType.fromMap(json),
        json['doc_number'] ?? '',
        // List<String>.from(json['doc_file'] ?? [])
        //     .map<String>(getFileUrl)
        //     .toList(),
        List<String>.from(json['doc_file'] ?? []).toList(),
        json['acc_id'] ?? -1,
        json['user_id'] ?? -1,
        json['prop_id'] ?? -1,
        json['deletion_date'] ?? '',
        json['expire_date'] ?? '',
        json['description'] ?? '',
        json['stripe_token_id'] ?? '',
        json['balance_transaction_id'] ?? '',
        json['purchased_date'] ?? '',
        json['purchase_status'] ?? '',
        json['transactions_id'] ?? -1,
        json['puuid'] ?? '',
        json['address1'] ?? '',
        json['shared_url'] ?? '');
  }
}
