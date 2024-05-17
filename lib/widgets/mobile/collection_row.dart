import 'collection_cell.dart';
import 'package:flutter/material.dart';

class CollectionRow extends TableRow {
  final Decoration? rowStyle;
  final List<CollectionCell>? cells;
  CollectionRow({LocalKey? key, this.cells, this.rowStyle})
      : super(
            key: key,
            children: cells == null || cells.isEmpty
                ? <Widget>[]
                : cells.map((e) => e.cellData).toList(),
            decoration: rowStyle);
}
