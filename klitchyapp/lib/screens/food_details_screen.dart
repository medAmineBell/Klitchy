import 'package:flutter/material.dart';
import 'package:klitchyapp/models/food.dart';
import 'package:klitchyapp/screens/add_to_cart_screen.dart';
import 'package:klitchyapp/widgets/custom_header.dart';
import 'package:klitchyapp/widgets/review_item.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Food food;

  const FoodDetailsScreen({super.key, required this.food});
  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            width: size.width,
            height: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/food.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomHeader(
                  title: '',
                  quantity: 0,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: size.width * 0.55,
                  ),
                ),
                // Container(
                //   alignment: Alignment.centerRight,
                //   margin: const EdgeInsets.only(right: 65.0, bottom: 10.0),
                //   child: iconBadge(
                //     icon: Icons.favorite,
                //     iconColor: theme.primaryColor,
                //   ),
                // ),
                Expanded(
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 50.0),
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(38.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 30.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    widget.food.name,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${widget.food.price} DT',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Pizza',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                            ),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '4',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Text(
                                    '/5',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 30.0,
                              left: 30.0,
                              top: 40,
                            ),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 30.0),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut enim leo. In sagittis velit nibh. Morbi sollicitudin lorem vitae nisi iaculis,sit amet suscipit orci mollis. Ut dictum lectus eget diam vestibulum, at eleifend felis mattis. Sed molestie congue magna at venenatis. In mollis felis ut consectetur consequat.',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 30.0,
                              left: 30.0,
                              bottom: 20,
                            ),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Reviews',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ReviewItem(
                            name: 'amine',
                            review: "very good",
                          ),
                          ReviewItem(
                            name: 'amine',
                            review: "very good",
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 30, right: 30, bottom: 60),
                            child: InkWell(
                              onTap: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        AddToCartScreen(
                                      food: widget.food,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(68),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    "ORDER",
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
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget iconBadge({required IconData icon, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(3.0, 3.0),
          )
        ],
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(
        icon,
        size: 20.0,
        color: iconColor,
      ),
    );
  }

  Widget detailsTab() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut enim leo. In sagittis velit nibh. Morbi sollicitudin lorem vitae nisi iaculis,sit amet suscipit orci mollis. Ut dictum lectus eget diam vestibulum, at eleifend felis mattis. Sed molestie congue magna at venenatis. In mollis felis ut consectetur consequat.',
            ),
          ),
        ],
      ),
    );
  }

  Widget renderCardReview() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                child: Icon(Icons.person),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Person',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'December 14, 2019',
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 50.0,
              top: 2.0,
            ),
            child: Text(
              'Cras ac nunc pretium, lacinia lorem ut, congue metus. Aenean vitae lectus at mauris eleifend placerat. Proin a nisl ut risus euismod ultrices et sed dui.',
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget reviewTab() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            renderCardReview(),
            renderCardReview(),
            renderCardReview(),
            renderCardReview(),
          ],
        ),
      ),
    );
  }
}
