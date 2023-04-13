import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_api2/controllers/page_datatable_controller.dart';
import 'package:tutor_api2/screens/add_dialog_screen.dart';

import '../Source/page_datatable_source.dart';

class PageDataTable extends StatelessWidget {
  PageDataTable({super.key});
  final PageDataTableController _controller =
      Get.put(PageDataTableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Tables'),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container(
            color: Color.fromARGB(255, 93, 90, 90),
            child: ListView(
              // shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // TextField(
                        //   decoration: const InputDecoration(hintText: 'Search'),
                        //   onChanged: (value) {},
                        // ),
                        Expanded(
                            child: Text(
                          "Power and Price",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.start,
                        )),
                        ElevatedButton.icon(
                          onPressed: () => addDataDialog(),
                          icon: Icon(Icons.add),
                          label: Text('Add'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _controller.deleteData(),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => PaginatedDataTable(
                    header: TextField(
                      decoration: const InputDecoration(hintText: 'Search'),
                      onChanged: (searhValue) =>
                          _controller.setSearchQuery(searhValue),
                    ),
                    arrowHeadColor: Color.fromARGB(255, 0, 0, 0),
                    rowsPerPage: 10,
                    columns: [
                      DataColumn(
                        label: SelectableText('id'),
                        onSort: (columnIndex, ascending) {
                          _controller.sort(columnIndex, ascending);
                        },
                      ),
                      DataColumn(label: SelectableText('power')),
                      DataColumn(label: SelectableText('price')),
                      DataColumn(label: SelectableText('')),
                    ],
                    source: PageDTDataSource(),
                    showCheckboxColumn: true,
                    sortAscending: _controller.sortAscending.value,
                    sortColumnIndex: _controller.sortColumnIndex.value,
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
