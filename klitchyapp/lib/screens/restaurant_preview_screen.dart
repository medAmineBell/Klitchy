import 'package:flutter/material.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/home_screen.dart';
import 'package:provider/provider.dart';

class RestaurantPreviewScreen extends StatelessWidget {
  const RestaurantPreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // body: Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   foregroundDecoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [
        //           Colors.white,
        //           Colors.black,
        //         ]),
        //     image: DecorationImage(
        //         image: Image.asset("images/kamkoum.jpeg").image,
        //         fit: BoxFit.cover),
        //   ),
        // ),
        //     Container(
        //       width: double.infinity,
        //       height: double.infinity,
        //       // decoration: BoxDecoration(

        //       //   image: DecorationImage(
        //       //       image: Image.asset("images/kamkoum.jpeg").image,
        //       //       fit: BoxFit.cover),
        //       // ),
        //       child: Image.asset("images/kamkoum.jpeg", fit: BoxFit.cover),
        //     ),
        //   ],
        // ),
        body: Stack(
          children: [
            Image.asset(
              "images/kamkoum.jpeg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    // Colors.transparent,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 150,
              left: 40,
              child: Row(
                children: [
                  Container(
                    width: 67,
                    height: 67,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      image: DecorationImage(
                          image: Image.asset("images/kamkoum.jpeg").image,
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  // Image.asset(
                  //   "images/kamkoum.jpeg",
                  //   fit: BoxFit.cover,
                  //   width: 67,
                  //   height: 67,
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "9am9oum Nabeul",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Traditional tunisian dishes",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6D6D6D),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: InkWell(
                  onTap: () async {
                    await Provider.of<DataProvider>(context, listen: false)
                        .getFoods();
                    await Provider.of<DataProvider>(context, listen: false)
                        .getCategories();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(68),
                      color: Color.fromRGBO(0, 108, 129, 0.3),
                    ),
                    child: Center(
                      child: Text(
                        "View menu",
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
            ),
          ],
        ),
      ),
    );
  }
}
