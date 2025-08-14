import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class KDataTable extends StatelessWidget {
  final List<String> columnTitles;
  final List<Map<String, String>> rowData;

  const KDataTable({
    super.key,
    required this.columnTitles,
    required this.rowData,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 16,
      horizontalMargin: 12,
      minWidth: 1000,
      headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
      columns: columnTitles
          .map(
            (title) => DataColumn(
              label: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
          .toList(),
      rows: rowData.map((row) {
        return DataRow(
          cells: columnTitles
              .map((col) => DataCell(Text(row[col] ?? '-')))
              .toList(),
        );
      }).toList(),
    );
  }
}
