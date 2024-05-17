import 'dart:convert';

import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TableData extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final TableType type;
  BuildContext? context;
  TableData(this.data, this.type, {this.context});
  List<Map<String, dynamic>> selectedItems = <Map<String, dynamic>>[];

  factory TableData.fromString(String e, TableType type,
          {BuildContext? context}) =>
      TableData.fromIterable(jsonDecode(e), type, context: context);

  factory TableData.fromIterable(Iterable<dynamic> elements, TableType type,
          {BuildContext? context}) =>
      TableData(List<Map<String, dynamic>>.from(elements), type,
          context: context);

  Helper get hp => Helper.of(context!);

  DataColumn mapKeyToColumn(String e) => DataColumn(
      tooltip: e,
      label: SelectableText(
          e.contains(RegExp(r'[iI][dD]')) ? e.toUpperCase() : e));

  List<DataColumn> get columns {
    List<String> mapKeys = <String>[];
    for (Map<String, dynamic> item in data) {
      if (item.isEmpty) {
        continue;
      } else {
        for (String key in item.keys) {
          if (!mapKeys.contains(key)) {
            mapKeys.add(key);
          } else {
            continue;
          }
        }
      }
    }
    return mapKeys.map(mapKeyToColumn).toList();
  }

  List<DataRow> get rows {
    List<DataRow> drs = <DataRow>[];
    for (int i = 0; i < rowCount; i++) {
      final row = getRow(i);
      if (row != null) drs.add(row);
    }
    return drs;
  }

  @override
  DataRow? getRow(int index) {
    // TODO: implement getRow
    final val = data[index];
    final flag = ((index + 1) % 2) == 0;
    return DataRow(
        // onSelectChanged: (value) {
        //   hp.reload(() {
        //     if (!selectedItems.remove(val)) selectedItems.add(val);
        //   });
        //   log(selectedItems);
        // },
        // selected: selectedItems.contains(val),
        color: MaterialStateProperty.all<Color>(
            Color(int.parse('0xff${flag ? 'f4f4f4' : 'ffffff'}'))),
        cells: val.keys
            .map<DataCell>((e) => DataCell(MouseRegion(
                    cursor: val[e].toString().contains('http')
                        ? SystemMouseCursors.click
                        : SystemMouseCursors.text,
                    child: GestureDetector(
                        child: SelectableText(
                            val[e] is String ? val[e] : val[e].toString(),
                            style: TextStyle(
                                decoration: val[e].toString().contains('http')
                                    ? TextDecoration.underline
                                    : null)),
                        onTap: () async {
                          if (val[e].toString().contains('http')) {
                            final url =
                                Uri.tryParse(val[e].toString()) ?? Uri();
                            final p = await launchUrl(url);
                            if (p) {
                              log(val[e]);
                            }
                          }
                        }))
                //         ,
                // placeholder: true,
                // showEditIcon: true
                ))
            .toList());
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
