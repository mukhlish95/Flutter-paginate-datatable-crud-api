import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tutor_api2/controllers/page_datatable_controller.dart';

void editDataDialog() {
  final PageDataTableController _controller =
      Get.put(PageDataTableController());
  Get.dialog(
    AlertDialog(
      title: Text('Edit Data'),
      content: Form(
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
                      SelectableText("ID:"),
                      SelectableText("${_controller.btnId}"),
                      // SelectableText("value"
                      // initialValue: _myData.field1,
                      // decoration: InputDecoration(labelText: 'id'),
                      // readOnly: true,
                      // validator: (value) => value.isEmpty ? 'Please enter a value' : null,
                      // onSaved: (value) => _myData.field1 = value,
                      // ),
                    ],
                  ),
                ),
              ),
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
                            // controller: _controller.editForm_1.value,
                            initialValue: _controller.editPower.toString(),
                            decoration: InputDecoration(labelText: 'Power'),
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter a value' : null,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) =>
                                _controller.updatePower = int.parse(value),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            // controller: _controller.editPrice,
                            initialValue: _controller.editPrice.toString(),
                            decoration: InputDecoration(labelText: 'Price'),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter a value' : null,
                            onChanged: (value) =>
                                _controller.updatePrice = int.parse(value),
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
          onPressed: () {
            final id = _controller.btnId;
            _controller.updateData(id);
            Get.back();
          },
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
