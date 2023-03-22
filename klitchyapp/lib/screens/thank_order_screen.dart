import 'package:flutter/material.dart';
import 'package:klitchyapp/screens/home_screen.dart';

class ThankScreen extends StatefulWidget {
  const ThankScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ThankScreen> createState() => _ThankScreenState();
}

class _ThankScreenState extends State<ThankScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Thank you for your order"),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Continue",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
