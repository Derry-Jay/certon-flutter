import 'collection_row.dart';
import 'package:flutter/material.dart';

class Collection extends Table {
  final TableBorder? tableBorder;
  final List<CollectionRow>? rows;
  Collection({this.rows, this.tableBorder, Key? key})
      : super(
            key: key, children: rows ?? <CollectionRow>[], border: tableBorder);
}
