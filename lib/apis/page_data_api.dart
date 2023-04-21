import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_api2/controllers/page_datatable_controller.dart';
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

  static Future addApiData() async {
    // final connect = GetConnect();
    final PageDataTableController controller =
        Get.put(PageDataTableController());
    // print(controller.power.value);
    // print(controller.powerTextController.value?.text);
    // print("apis");
    final response = await http.post(
      Uri.parse('http://smart-home.test/api/save-power'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        'power': int.parse(controller.powerTextController.value?.text ?? '0'),
        'price': int.parse(controller.priceTextController.value?.text ?? '0')
      }),
    );
    // print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('Data added successfully');
      return true;
    } else {
      throw Exception('Failed to add');
    }
  }

  static Future<Map> editData(id) async {
    final response =
        await http.get(Uri.parse('http://smart-home.test/api/edit-power/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch');
    }
  }

  static final Dio _dio = Dio();

  static Future updateData(id) async {
    final PageDataTableController controller =
        Get.put(PageDataTableController());

    print(controller.editPower);
    final response = await _dio
        .post('http://smart-home.test/api/update-power/$id', data: {
      "power": controller.updatePower,
      "price": controller.updatePrice
    });
    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('Update successfully');
      return true;
    } else {
      throw Exception('Failed to update');
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
