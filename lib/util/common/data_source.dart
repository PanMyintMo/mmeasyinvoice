import 'package:flutter/material.dart';

class DataSource<T> extends DataTableSource {
  final List<T> data;

  final Function(T) buildRowWidgets;
  final BuildContext context;

  DataSource({required this.data, required this.buildRowWidgets, required this.context});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final T rowData = data[index];
    List<Widget> rowWidgets = buildRowWidgets(rowData);

    return DataRow(cells: rowWidgets.map((widget) => DataCell(widget)).toList());
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
