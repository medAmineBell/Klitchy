import 'dart:io';

import 'package:flutter/material.dart';
import 'package:klitchyresto/app_constants.dart';
import 'package:klitchyresto/models/category.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryScreen extends StatefulWidget {
  final List<Category> categories;

  const AddCategoryScreen({super.key, required this.categories});
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController namecontroller = TextEditingController();

  bool _validatname = false;

  bool isLoading = false;

  late Image image;

  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFileList = [];

  Future getImageMulti() async {
    try {
      final pickedFileList = await _picker.pickMultiImage();
      setState(() {
        pickedFileList.forEach((element) {
          _imageFileList.add(element);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future getImageCam() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _imageFileList.add(pickedFile!);
      });
    } catch (e) {
      print(e);
    }
  }

  void clearImages() {
    setState(() {
      _imageFileList.clear();
    });
  }

  // String dropdownvalue = '';

  // List<String> categories = [];

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
  }

  Widget _previewImages() {
    if (_imageFileList.isNotEmpty) {
      return Container(
        height: 170,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.file(File(_imageFileList[index].path)),
            );
          },
          itemCount: _imageFileList.length,
        ),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red),
      );
    }
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      autofocus: false,
                      controller: namecontroller,
                      decoration: InputDecoration(
                        labelText: 'Category name',
                        errorText: _validatname ? 'Category name empty' : null,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                  // DropdownButton(
                  //   // Initial Value
                  //   value: dropdownvalue.isEmpty ? null : dropdownvalue,

                  //   // Down Arrow Icon
                  //   icon: const Icon(Icons.keyboard_arrow_down),
                  //   hint: Text("Choose Category"),
                  //   // Array list of items
                  //   items: categories.map((String items) {
                  //     return DropdownMenuItem(
                  //       value: items,
                  //       child: Text(items),
                  //     );
                  //   }).toList(),
                  //   // After selecting the desired option,it will
                  //   // change button value to selected value
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       dropdownvalue = newValue!;
                  //     });
                  //   },
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Upload Event image',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: getImageCam,
                                icon: Icon(Icons.camera_alt)),
                            IconButton(
                                onPressed: getImageMulti,
                                icon: Icon(Icons.image)),
                            IconButton(
                                onPressed: clearImages,
                                icon: Icon(Icons.refresh)),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _previewImages(),

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
                        setState(() {
                          namecontroller.text.isEmpty
                              ? _validatname = true
                              : _validatname = false;
                        });
                        if (namecontroller.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .addCategoryAPI(
                                  _imageFileList.first, namecontroller.text);

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
