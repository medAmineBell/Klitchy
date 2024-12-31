import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:klitchyresto/app_constants.dart';
import 'package:klitchyresto/models/event.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class UpdateEventScreen extends StatefulWidget {
  final Event event;

  const UpdateEventScreen({super.key, required this.event});
  @override
  _UpdateEventScreenState createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();

  TextEditingController priceccontroller = TextEditingController();

  bool _validatname = false;
  bool _validatprice = false;

  late Image image;

  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFileList = [];

  DateTime _date = DateTime.now();

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
  void initState() {
    super.initState();
    namecontroller.text = widget.event.name;
    desccontroller.text = widget.event.description;
    _date = DateTime.parse(widget.event.date);
  }

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    desccontroller.dispose();
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
        child: Image.network(AppConstants.serverUrl + widget.event.imgurl),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update event',
        ),
        backgroundColor: AppConstants.primaryColorDark1,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<DataProvider>(context, listen: false)
                    .deleteEvent(widget.event.id);
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ))
        ],
      ),
      backgroundColor: AppConstants.primaryColorDark1,
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
                        labelText: 'Event name',
                        errorText: _validatname ? 'Event name empty' : null,
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
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      controller: desccontroller,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Event Description',
                        errorText:
                            _validatprice ? 'Event Description empty' : null,
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
                  DatePicker(
                    context,
                    leading: 'Event date',
                    trailing: getDateStr(_date),
                    updateDateState: (date) => setState(() {
                      _date = date;
                    }),
                    openDate: DateTime.now(),
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
                          desccontroller.text.isEmpty
                              ? _validatprice = true
                              : _validatprice = false;
                        });
                        if (namecontroller.text.isNotEmpty &&
                            desccontroller.text.isNotEmpty &&
                            _imageFileList != null) {
                          setState(() {
                            isLoading = true;
                          });
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .updateEvent(
                                  _imageFileList.first,
                                  namecontroller.text,
                                  desccontroller.text,
                                  getDateStr(_date),
                                  priceccontroller.text,
                                  widget.event.id);
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .getEvents();
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        "Update Event",
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

String getDateStr(DateTime date) {
  if (date == null) {
    return 'N/A';
  }
  String year = date.year.toString();
  String month = date.month.toString();
  String day = date.day.toString();
  return '$year-${getTwoDigitStr(month)}-${getTwoDigitStr(day)}';
}

String getTwoDigitStr(String str) {
  return str.length == 1 ? '0$str' : str;
}

Future<DateTime?> openDatePicker(
  BuildContext context, {
  required DateTime openDate,
}) {
  return showDatePicker(
    context: context,
    //cancelText: "Annuler",
    // helpText: "Choisir une Date",
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Theme.of(context).primaryColor,
          accentColor: Theme.of(context).primaryColor,
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).primaryColor,
          ),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(
      Duration(days: 365),
    ),
    lastDate: DateTime.now().add(
      Duration(days: 365),
    ),
  );
}

class DatePicker extends StatelessWidget {
  final BuildContext context;
  final String leading;
  final String trailing;
  final Function updateDateState;
  final DateTime openDate;

  DatePicker(
    this.context, {
    this.leading = '',
    this.trailing = '',
    required this.updateDateState,
    required this.openDate,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(leading),
          Text(trailing),
          Icon(
            Icons.calendar_today,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
      onPressed: () async {
        DateTime? date = await openDatePicker(
          context,
          openDate: openDate,
        );

        if (date != null) {
          DateTime now = DateTime.now();
          DateTime dateWithCurrentTime = DateTime(
            date.year,
            date.month,
            date.day,
            now.hour,
            now.minute,
            now.second,
          );
          updateDateState(dateWithCurrentTime);
        }
      },
    );
  }
}
