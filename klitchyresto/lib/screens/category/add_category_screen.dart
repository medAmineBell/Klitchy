import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:klitchyresto/app_constants.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController namecontroller = TextEditingController();

  bool _validatname = false;

  bool isLoading = false;

  String dropdownvalue = '';

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a category',
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 7,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: TextFormField(
                  //     keyboardType: TextInputType.name,
                  //     autofocus: false,
                  //     controller: namecontroller,
                  //     decoration: InputDecoration(
                  //       labelText: 'Category name',
                  //       errorText: _validatname ? 'Category name empty' : null,
                  //       contentPadding:
                  //           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(32.0)),
                  //     ),
                  //   ),
                  // ),
                  DropdownButton(
                    // Initial Value
                    value: dropdownvalue.isEmpty ? null : dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    hint: Text("Choose Category"),
                    // Array list of items
                    items: AppConstants.categories.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (!isLoading)
                    ElevatedButton(
                      onPressed: () async {
                        // setState(() {
                        //   namecontroller.text.isEmpty
                        //       ? _validatname = true
                        //       : _validatname = false;
                        // });
                        if (dropdownvalue.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .addCategoryAPI(dropdownvalue);

                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .getCategories();
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        "Add Category",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
