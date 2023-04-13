import 'package:get/get.dart';
import 'package:tutor_api2/models/page_datatable_model.dart';

import '../apis/page_data_api.dart';

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

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
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

  // void setSearchQuery(String searchQuery) {
  //   // print(setS);
  //   if (searchQuery.isEmpty) {
  //     filteredData = dataList;
  //     // print(searchQuery + "atas");
  //   } else {
  //     // print(searchQuery + "bawah");
  //     filteredData = RxList(dataList.where((item) {
  //       final itemPower = item.power.toString().toLowerCase();
  //       final itemPrice = item.price.toString().toLowerCase();
  //       final queryLower = searchQuery.toLowerCase();
  //       return itemPower.contains(queryLower) || itemPrice.contains(queryLower);
  //     }).toList());
  //     // dataList.assignAll(filteredData);
  //   }
  // filteredData.refresh();
// }

  // List get filteredData {
  //   if (searchQuery.isEmpty) {
  //     print(searchQuery.value);
  //     return dataList;
  //   } else {
  //     print(searchQuery + "bawah");
  //     return dataList.where((item) {
  //       final itemPower = item.power.toString().toLowerCase();
  //       final itemPrice = item.price.toString().toLowerCase();
  //       final queryLower = searchQuery.toLowerCase();
  //       return itemPower.contains(queryLower) || itemPrice.contains(queryLower);
  //     }).toList();
  //   }
  // }

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
      print(rowIndex);
    }
  }
}
