import '../../models/table_data.dart';
import '../../web_pages/web_home_page.dart';
import 'package:flutter/material.dart';

class PaginatedTableWidget extends StatefulWidget {
  final String tableTitle;
  final TableData tableData;
  const PaginatedTableWidget(
      {Key? key, required this.tableData, required this.tableTitle})
      : super(key: key);

  @override
  PaginatedTableWidgetState createState() => PaginatedTableWidgetState();

  static WebHomePageState? of(BuildContext context) =>
      context.findAncestorStateOfType<WebHomePageState>();
}

class PaginatedTableWidgetState extends State<PaginatedTableWidget> {
  WebHomePageState? get hps => PaginatedTableWidget.of(context);
  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
        rowsPerPage: hps!.perPage,
        showFirstLastButtons: true,
        columns: widget.tableData.columns,
        source: widget.tableData,
        sortColumnIndex: 0,
        header: SelectableText(widget.tableTitle));
  }
}
