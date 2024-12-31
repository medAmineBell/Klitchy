import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' as ff;

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController priceccontroller = TextEditingController();

  bool _validatname = false;
  bool _validatdesc = false;
  bool _validatprice = false;

  DateTime _date = DateTime.now();

  bool isLoading = false;

  @override
  void dispose() {
    namecontroller.dispose();

    super.dispose();
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
          'Add event',
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
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      controller: priceccontroller,
                      decoration: InputDecoration(
                        labelText: 'Event price',
                        errorText: _validatprice ? 'Event price empty' : null,
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
                            _validatdesc ? 'Event Description empty' : null,
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
                          desccontroller.text.isEmpty
                              ? _validatdesc = true
                              : _validatdesc = false;
                          priceccontroller.text.isEmpty
                              ? _validatprice = true
                              : _validatprice = false;
                        });
                        if (namecontroller.text.isNotEmpty &&
                            desccontroller.text.isNotEmpty &&
                            priceccontroller.text.isNotEmpty &&
                            _image != null) {
                          setState(() {
                            isLoading = true;
                          });
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .addEvent(
                                  _image!,
                                  namecontroller.text,
                                  desccontroller.text,
                                  getDateStr(_date),
                                  priceccontroller.text);
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
                        "Add Event",
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
