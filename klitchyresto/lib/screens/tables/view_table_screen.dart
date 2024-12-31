import 'package:flutter/material.dart';
import 'package:klitchyresto/app_constants.dart';
import 'package:klitchyresto/models/tableResto.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:provider/provider.dart';

class ViewTableScreen extends StatefulWidget {
  final TableResto table;

  const ViewTableScreen({super.key, required this.table});
  @override
  _ViewTableScreenState createState() => _ViewTableScreenState();
}

class _ViewTableScreenState extends State<ViewTableScreen> {
  TextEditingController namecontroller = TextEditingController();

  bool _validatname = false;

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
  }

  @override
  void initState() {
    super.initState();
    namecontroller.text = widget.table.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update table',
        ),
        backgroundColor: AppConstants.primaryColorDark1,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<DataProvider>(context, listen: false)
                    .deleteTable(widget.table.id);
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
                        labelText: 'Table name',
                        errorText: _validatname ? 'Table name empty' : null,
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
                              .updateTable(
                                  namecontroller.text, widget.table.id);

                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .getTables();
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        "Update Table",
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
