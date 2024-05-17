import '../../models/table_data.dart';
import 'package:flutter/material.dart';

class NormalTableWidget extends StatefulWidget {
  final String tableTitle;
  final TableData tableData;
  const NormalTableWidget(
      {Key? key, required this.tableData, required this.tableTitle})
      : super(key: key);

  @override
  NormalTableWidgetState createState() => NormalTableWidgetState();
}

class NormalTableWidgetState extends State<NormalTableWidget> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: widget.tableData.columns,
        border: TableBorder.symmetric(
            outside: const BorderSide(width: 1, color: Colors.black)),
        rows: widget.tableData.rows);
  }
}
