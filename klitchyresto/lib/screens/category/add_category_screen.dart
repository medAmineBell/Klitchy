import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as ff;
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

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
  }

  XFile? _image;

  Image? image;

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        if (ff.kIsWeb) {
          image = Image.network(
            pickedFile.path,
            width: 300,
            height: 300,
          );
        } else {
          image = Image.file(
            File(pickedFile.path),
            width: 300,
            height: 300,
          );
        }
      } else {
        print('No image selected.');
      }
    });
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
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: getImage,
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Choose photo"),
                      )),
                  SizedBox(
                    height: 20,
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
                        if (namecontroller.text.isNotEmpty && _image != null) {
                          setState(() {
                            isLoading = true;
                          });
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .addCategoryAPI(_image!, namecontroller.text);

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
