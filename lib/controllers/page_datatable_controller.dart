import 'dart:math';

import 'package:flutter/src/material/data_table.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tutor_api2/models/page_datatable_model.dart';
import 'package:tutor_api2/screens/add_dialog_screen.dart';

import '../apis/page_data_api.dart';
import '../screens/edit_dialog_screen.dart';

class PageDataTableController extends GetxController {
  var sortAscending = true.obs;
  var sortColumnIndex = 0.obs;
  var isLoading = true.obs;

  //list of data
  RxList dataList = <PageDatatableModel>[].obs;
  //list of selected data id
  RxList<int> rowSelect = <int>[].obs;
  //list of selected index id
  RxList<int> rowIndex = <int>[].obs;
  //search input data
  RxString onSearch = "".obs;
  //filter input data
  RxString searchQuery = "".obs;
  //value query
  RxString query = "".obs;
  RxString filterList = "".obs;
  RxList filteredData = [].obs;
  RxInt power = 0.obs;
  RxInt price = 0.obs;
  Rxn<TextEditingController> powerTextController =
      Rxn<TextEditingController>(TextEditingController());
  Rxn<TextEditingController> priceTextController =
      Rxn<TextEditingController>(TextEditingController());
  int btnId = 0;
  //declare for edit
  int editPower = 0;
  int editPrice = 0;
  //declare for update
  int updatePower = 0;
  int updatePrice = 0;

  @override
  void onInit() {
    super.onInit();

    fetchData();
  }

  void fetchData() async {
    // print(editForm_1.text);
    try {
      isLoading(true);
      if (filteredData.isEmpty && searchQuery.isNotEmpty) {
        filteredData.clear();
      } else if (filteredData.isEmpty && searchQuery.isEmpty) {
        var data = await PageDatatableApis.fetchData();
        dataList.assignAll(data);
        filteredData = dataList;
        dataList.refresh();
        // print(searchQuery);
      } else if (filteredData.isNotEmpty && searchQuery.isEmpty) {
        filteredData = dataList;
        dataList.refresh();
        // print(searchQuery);
      }
    } finally {
      isLoading(false);
    }
  }

  void addData() async {
    // print(powerTextController.value?.text);
    // create an instance of the PageDatatableApis class
// call the addApiData method on the instance
    await PageDatatableApis.addApiData();
    Get.smartManagement;
    filteredData.clear();
    // dataList.refresh();
    fetchData();
    Get.back();
  }

  void editData(id) async {
    final responseEdit = await PageDatatableApis.editData(id);
    // print(query);
    btnId = id;
    editPower = responseEdit["electric"]["power"];
    editPrice = responseEdit["electric"]["price"];
    updatePower = editPower;
    updatePrice = editPrice;
    // print(updatePower);
    editDataDialog();
  }

  void updateData(id) async {
    await PageDatatableApis.updateData(id);
    btnId = id;
    // responseUpdate["electric"]["power"] = 12;
    // responseUpdate["electric"]["price"] = 12;
    filteredData.clear();
    fetchData();
    Get.back();
  }

  void setSearchQuery(String searhValue) {
    searchQuery.value = searhValue;
    if (searchQuery.isEmpty) {
      // print(searchQuery.value);
      fetchData();
      // print(filteredData.value);
      // print("searchQuery empty");
    } else if (searchQuery.isNotEmpty) {
      // print(filteredData);
      // print("searchQuery not empty");
      filteredData = RxList(dataList.where((item) {
        final itemPower = item.power.toString().toLowerCase();
        final itemPrice = item.price.toString().toLowerCase();
        final queryLower = searchQuery.toLowerCase();
        return itemPower.contains(queryLower) || itemPrice.contains(queryLower);
      }).toList());
      dataList.refresh();
      // data list base on fetch request
      fetchData();
      // print(filteredData);
    }
  }

  void sort(int columnIndex, bool ascending) {
    // print(searchQuery);
    // print(filteredData);
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    if (ascending) {
      dataList.sort((a, b) => a.id.compareTo(b.id));
    } else {
      dataList.sort((a, b) => b.id.compareTo(a.id));
    }
  }

  void deleteData() async {
    try {
      isLoading(true);

      for (var el in rowSelect.toList()) {
        await PageDatatableApis.deleteCheckedData(el);
        dataList.clear();
      }
    } finally {
      isLoading(false);
      fetchData();
      rowIndex.clear();
      rowSelect.clear();
      // print(rowIndex);
    }
  }
}
