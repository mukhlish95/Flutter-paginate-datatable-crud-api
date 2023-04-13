import 'package:flutter/material.dart';
import 'package:get/get.dart';

void editDataDialog() {
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
                      SelectableText("ID:"),
                      SelectableText("value"
                          // initialValue: _myData.field1,
                          // decoration: InputDecoration(labelText: 'id'),
                          // readOnly: true,
                          // validator: (value) => value.isEmpty ? 'Please enter a value' : null,
                          // onSaved: (value) => _myData.field1 = value,
                          ),
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
                            // initialValue: _myData.field1,
                            decoration: InputDecoration(labelText: 'Field 2'),
                            // validator: (value) => value.isEmpty ? 'Please enter a value' : null,
                            // onSaved: (value) => _myData.field1 = value,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            // initialValue: _myData.field1,
                            decoration: InputDecoration(labelText: 'Field 2'),
                            // validator: (value) => value.isEmpty ? 'Please enter a value' : null,
                            // onSaved: (value) => _myData.field1 = value,
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
          onPressed: () => Get.back(),
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
