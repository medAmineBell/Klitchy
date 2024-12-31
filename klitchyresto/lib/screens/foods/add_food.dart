import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:klitchyresto/models/category.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' as ff;

class AddFoodScreen extends StatefulWidget {
  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();

  bool _validatname = false;
  bool _validatprice = false;

  bool isLoading = false;

  Category? dropdownvalue;
  List<Category> categories = [];

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
  void dispose() {
    namecontroller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    categories = Provider.of<DataProvider>(context, listen: false).categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a food',
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
                        labelText: 'Food name',
                        errorText: _validatname ? 'Food name empty' : null,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      controller: pricecontroller,
                      decoration: InputDecoration(
                        labelText: 'Food price',
                        errorText: _validatprice ? 'Food price empty' : null,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton<Category>(
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    hint: Text("Choose Category"),
                    // Array list of items
                    items: categories.map((Category items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items.name),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (Category? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
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
                          pricecontroller.text.isEmpty
                              ? _validatprice = true
                              : _validatprice = false;
                        });
                        if (namecontroller.text.isNotEmpty &&
                            pricecontroller.text.isNotEmpty &&
                            _image != null) {
                          setState(() {
                            isLoading = true;
                          });
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .addFood(_image!, namecontroller.text,
                                  pricecontroller.text, dropdownvalue!.id);
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .getFoods();
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        "Add Food",
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
