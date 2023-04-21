import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Column(children: [
          Text("Home"),
          ElevatedButton(
              onPressed: () => Get.toNamed('/datatable'),
              child: Text("Ke Datatable")),
        ]),
      ),
    );
  }
}
