import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tutor_api2/controllers/page_datatable_controller.dart';

void addDataDialog() {
  final PageDataTableController _controller =
      Get.put(PageDataTableController());
  Get.dialog(
    AlertDialog(
      title: Text('Edit Data'),
      content: Form(
        // key: _formKey,
        child: Container(
          height: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 16,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _controller.powerTextController.value,
                            keyboardType: TextInputType.number,
                            // initialValue: _myData.field1,
                            decoration: InputDecoration(labelText: 'Power'),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            // validator: (value) => value.isEmpty ? 'Please enter a value' : null,
                            onSaved: (power) => _controller.addData(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _controller.priceTextController.value,
                            // initialValue: _myData.field1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Price'),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            // validator: (value) => value.isEmpty ? 'Please enter a value' : null,
                            onSaved: (price) => _controller.addData(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => _controller.addData(),
          child: Text('Save'),
        ),
      ],
    ),
    // title: const Text('Dialog'),
    // content: const Text('This is a dialog'),
    // actions: [
    //   TextButton(
    //     child: const Text("Close"),
    //     onPressed: () => Get.back(),
    //   ),
    // ],
  );
}
