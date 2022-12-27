import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController telcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    telcontroller.dispose();
    namecontroller.dispose();
  }

  bool _validtel = false;
  bool _validname = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "images/logo.png",
                  width: 166,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Restaurant App",
                  style: TextStyle(fontSize: 14, color: Color(0xFF6D6D6D)),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Column(
              children: [
                Text("Welcome back",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    controller: namecontroller,
                    // style: TextStyle(
                    //   color: Colors.white,
                    // ),
                    decoration: InputDecoration(
                      labelText: 'Nom et prénom',
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).primaryColor,
                      ),

                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      errorText: _validname ? 'Nom et prénom vide !' : null,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    autofocus: false,
                    controller: telcontroller,
                    // style: TextStyle(
                    //   color: Colors.white,
                    // ),
                    decoration: InputDecoration(
                      labelText: 'Téléphone',
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
                      ),

                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      errorText: _validtel ? 'Téléphone vide !' : null,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    telcontroller.text.isEmpty
                        ? _validtel = true
                        : _validtel = false;
                    namecontroller.text.isEmpty
                        ? _validname = true
                        : _validname = false;
                  });
                  if (telcontroller.text.isNotEmpty &&
                      namecontroller.text.isNotEmpty) {
                    // await Provider.of<DataProvider>(context, listen: false)
                    //     .addClient(telcontroller.text, namecontroller.text);
                    // if (widget.isOwner) {
                    //   await Provider.of<DataProvider>(context, listen: false)
                    //       .setOwner();
                    //   Navigator.of(context).pushReplacement(
                    //     MaterialPageRoute(
                    //       builder: (BuildContext context) =>
                    //           RestaurantPreviewScreen(),
                    //     ),
                    //   );
                    // } else {
                    //   Navigator.of(context).pushReplacement(
                    //     MaterialPageRoute(
                    //       builder: (BuildContext context) => PendingScreen(),
                    //     ),
                    //   );
                    // }
                  }
                },
                child: Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(68),
                    color: Color(0xFF006C81),
                  ),
                  child: Center(
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
