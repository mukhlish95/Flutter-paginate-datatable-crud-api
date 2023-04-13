import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_api2/models/page_datatable_model.dart';

class PageDatatableApis {
  static Future<List<PageDatatableModel>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://smart-home.test/api/total-power'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)["data"] as List;
      // print(data);
      return data
          .map((item) => PageDatatableModel(
                id: item['id'],
                power: item['power'],
                price: item['price'],
              ))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<void> deleteCheckedData(int el) async {
    // var el = 0;
    print(el);
    // for (var el in rowSelect.toList()) {
    final http.Response response = await http
        .delete(Uri.parse('http://smart-home.test/api/delete-power/$el'));
    if (response.statusCode == 200) {
      print('Data deleted successfully');
      // rowSelect.clear();
    } else {
      // rowSelect.clear();
      throw Exception('Failed to delete post');
    }
    // }
  }
}
