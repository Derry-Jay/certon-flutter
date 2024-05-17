import 'package:flutter/material.dart';

import '../mobile/collection_row.dart';

class MyTable extends Table {
  final List<CollectionRow> rows;
  MyTable({Key? key, required this.rows}) : super(key: key, children: rows);
}
