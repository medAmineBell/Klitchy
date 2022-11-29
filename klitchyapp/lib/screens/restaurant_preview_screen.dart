import 'package:flutter/material.dart';

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
                    Colors.transparent,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 150,
              left: 50,
              child: Row(
                children: [
                  Image.asset(
                    "images/kamkoum.jpeg",
                    fit: BoxFit.cover,
                    width: 67,
                    height: 67,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
