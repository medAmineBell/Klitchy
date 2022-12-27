import 'package:flutter/material.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/home_screen.dart';
import 'package:klitchyapp/screens/into_screen.dart';
import 'package:klitchyapp/screens/restaurant_preview_screen.dart';
import 'package:provider/provider.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  late Resto resto;
  late TableResto tableResto;
  late Client owner;

  @override
  void initState() {
    super.initState();
    resto = Provider.of<DataProvider>(context, listen: false).resto;
    tableResto = Provider.of<DataProvider>(context, listen: false).tableResto;
    owner = Provider.of<DataProvider>(context, listen: false).owner;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                height: 20,
              ),
            ],
          ),
          Column(
            children: [
              Text("En attente de confirmation",
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
                    "Veuillez saisir votre nom complet, afin que nous puissions nous souvenir de vous et vous envoyer des informations sur nos promotions",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: InkWell(
              onTap: () async {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        RestaurantPreviewScreen(),
                  ),
                );
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
                    "QUIT",
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
    ));
  }
}
