import 'package:flutter/material.dart';

class TableColumn extends DataColumn {
  final String columnName;
  final bool? isDigit;
  final void Function(int, bool)? whileSort;
  TableColumn({required this.columnName, this.isDigit, this.whileSort})
      : super(
            numeric: isDigit ?? false,
            onSort: whileSort,
            tooltip: columnName,
            label: SelectableText(columnName.contains(RegExp(r'[iI][dD]'))
                ? columnName.toUpperCase()
                : columnName));
}
