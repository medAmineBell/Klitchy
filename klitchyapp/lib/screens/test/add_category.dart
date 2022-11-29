import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController namecontroller = TextEditingController();

  bool _validatname = false;

  late Image image;
  late DateTime _date;
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFileList = [];

  bool isLoading = false;

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
                  SizedBox(
                    height: 10,
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

                        // ElevatedButton(
                        //   onPressed: getImage,
                        //   child: Text(
                        //     "Choose image",
                        //     style: TextStyle(
                        //       fontSize: 14.0,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Theme.of(context).primaryColor,
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(10)),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _previewImages(),
                  //if (image != null) image,

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
                        if (namecontroller.text.isNotEmpty &&
                            _imageFileList != null) {
                          setState(() {
                            isLoading = true;
                          });
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .addCategoryAPI(
                                  namecontroller.text, _imageFileList.first);

                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: Text(
                        "Upload",
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
