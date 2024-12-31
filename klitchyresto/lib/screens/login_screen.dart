import 'package:flutter/material.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:klitchyresto/screens/pos/pos_screen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    passcontroller.dispose();
    namecontroller.dispose();
  }

  bool _validpass = false;
  bool _validname = false;

  @override
  void initState() {
    super.initState();
    namecontroller.text = "planb";
    passcontroller.text = "azerty";
    SharedPreferences.getInstance().then((prefs) {
      String username = prefs.getString("username") ?? "";
      String pass = prefs.getString("pass") ?? "";
      if (username.isNotEmpty && pass.isNotEmpty) {
        Provider.of<DataProvider>(context, listen: false)
            .loginResto(namecontroller.text, passcontroller.text)
            .then((isLogin) {
          if (isLogin) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => POSScreen(),
              ),
            );
          }
        });
      }
    });
  }

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
                      labelText: 'Username',
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).primaryColor,
                      ),

                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      errorText: _validname ? 'Username empty !' : null,
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
                    keyboardType: TextInputType.text,
                    autofocus: false, obscureText: true,
                    controller: passcontroller,
                    // style: TextStyle(
                    //   color: Colors.white,
                    // ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).primaryColor,
                      ),

                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      errorText: _validpass ? 'Password empty !' : null,
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
                    passcontroller.text.isEmpty
                        ? _validpass = true
                        : _validpass = false;
                    namecontroller.text.isEmpty
                        ? _validname = true
                        : _validname = false;
                  });
                  if (passcontroller.text.isNotEmpty &&
                      namecontroller.text.isNotEmpty) {
                    final isLogin = await Provider.of<DataProvider>(context,
                            listen: false)
                        .loginResto(namecontroller.text, passcontroller.text);
                    if (isLogin) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("username", namecontroller.text);
                      prefs.setString("pass", passcontroller.text);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => POSScreen(),
                        ),
                      );
                    } else {
                      final snackBar = SnackBar(
                        content: const Text(
                          'Wrong login info',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Color(0xFF006C81),
                        // action: SnackBarAction(
                        //   textColor: Colors.white,
                        //   label: 'Hide',
                        //   onPressed: () {},
                        // ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
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
