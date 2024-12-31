import 'package:flutter/material.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/models/tableResto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/into_screen.dart';
import 'package:klitchyapp/screens/restaurant_preview_screen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PendingScreen extends StatefulWidget {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  late Resto resto;
  late TableResto tableResto;
  late IO.Socket socket;
  late Client client;

  @override
  void dispose() {
    super.dispose();
    socket.dispose();
  }

  @override
  void initState() {
    super.initState();
    resto = Provider.of<DataProvider>(context, listen: false).resto;
    tableResto = Provider.of<DataProvider>(context, listen: false).tableResto;
    socket = Provider.of<DataProvider>(context, listen: false).socket;
    client = Provider.of<DataProvider>(context, listen: false).client;
    Provider.of<DataProvider>(context, listen: false).requestJoinTable();

    socket.on('JoinTable_response', (data) {
      final tableId =
          Provider.of<DataProvider>(context, listen: false).tableResto.id;
      final socketTableId = data["tableId"];
      if (tableId.toString() == socketTableId.toString()) {
        final clientSocket = Client.fromJson(data["user"]);
        if (client.id == clientSocket.id) {
          bool isAllowed = data["isAllowed"];
          print("isAllowed : " + isAllowed.toString());
          if (isAllowed) {
            Provider.of<DataProvider>(context, listen: false)
                .addClientToTable()
                .then((value) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => RestaurantPreviewScreen(
                    resto: resto,
                  ),
                ),
              );
            });
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => const IntroScreen(),
              ),
            );
          }
        }
      }
    });
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
          //CircularProgressIndicator(),
          InkWell(
              onTap: () {
                Provider.of<DataProvider>(context, listen: false)
                    .requestJoinTable();
              },
              child: Icon(Icons.notifications_none, size: 28.0)),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: InkWell(
              onTap: () async {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => RestaurantPreviewScreen(
                      resto: resto,
                    ),
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
