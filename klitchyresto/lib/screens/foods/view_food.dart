import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:klitchyresto/app_constants.dart';
import 'package:klitchyresto/models/category.dart';
import 'package:klitchyresto/models/food.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ViewFoodScreen extends StatefulWidget {
  final Food food;

  const ViewFoodScreen({super.key, required this.food});
  @override
  _ViewFoodScreenState createState() => _ViewFoodScreenState();
}

class _ViewFoodScreenState extends State<ViewFoodScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();

  bool _validatname = false;
  bool _validatprice = false;

  late Image image;
  late DateTime _date;
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFileList = [];

  bool isLoading = false;

  Category? dropdownvalue;
  List<Category> categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller.text = widget.food.name;
    pricecontroller.text = widget.food.price.toStringAsFixed(2);
    categories = Provider.of<DataProvider>(context, listen: false).categories;
    dropdownvalue = categories
        .firstWhere((element) => element.id == widget.food.categoryId);
  }

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

  @override
  void dispose() {
    namecontroller.dispose();

    super.dispose();
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
      return Container(
        height: 170,
        child: Image.network(AppConstants.serverUrl + widget.food.imgurl),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update a food',
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<DataProvider>(context, listen: false)
                    .deleteFood(widget.food.id);
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ))
        ],
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Upload image',
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
                            _imageFileList != null) {
                          setState(() {
                            isLoading = true;
                          });
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .updateFood(
                                  _imageFileList,
                                  namecontroller.text,
                                  pricecontroller.text,
                                  dropdownvalue!.id,
                                  widget.food.id);
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
                        "Update",
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
