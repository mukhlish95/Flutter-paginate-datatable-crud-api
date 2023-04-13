import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_api2/controllers/page_datatable_controller.dart';

import '../screens/edit_dialog_screen.dart';

class PageDTDataSource extends DataTableSource {
  final PageDataTableController _controller =
      Get.put(PageDataTableController());
  final List<int> _selectedIndices = [];

  @override
  DataRow? getRow(int index) {
    // if (index >= _controller.filteredData.length) return null;
    final data = _controller.filteredData[index];

    // final PageDataTableController _controller =
    //     Get.put(PageDataTableController());
    return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Text(data.id.toString())),
          DataCell(Text(data.power.toString())),
          DataCell(Text(data.price.toString())),
          DataCell(ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.green),
              onPressed: () => editDataDialog(),
              icon: Icon(Icons.edit),
              label: Text("Edit"))),
        ],
        selected: _selectedIndices.contains(index),
        onSelectChanged: (bool? value) {
          if (value == true) {
            _selectedIndices.add(index);
            _controller.rowIndex.add(index);
            _controller.rowSelect.add(data.id);
          } else {
            _selectedIndices.remove(index);
            _controller.rowIndex.remove(index);
            _controller.rowSelect.remove(data.id);
          }
          notifyListeners();

          // print(_controller.rowSelect);
          // print(_controller.rowIndex);
        });
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _controller.filteredData.length;

  @override
  int get selectedRowCount => _selectedIndices.length;
}
