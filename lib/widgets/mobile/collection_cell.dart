import 'package:flutter/material.dart';

class CollectionCell extends TableCell {
  final Widget cellData;
  final TableCellVerticalAlignment? alignmentVertical;
  const CollectionCell(this.cellData, {Key? key, this.alignmentVertical})
      : super(key: key, child: cellData, verticalAlignment: alignmentVertical);
}
