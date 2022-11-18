import 'package:flutter/material.dart';
import 'package:klitchyapp/models/food.dart';
import 'package:klitchyapp/widgets/custom_header.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Food food;

  const FoodDetailsScreen({super.key, required this.food});
  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    int quantity = 0;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            width: size.width,
            height: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.food.imgurl),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomHeader(
                  title: '',
                  quantity: quantity,
                  internalScreen: true,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: size.width * 0.55,
                    left: 50.0,
                    right: 50.0,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 65.0, bottom: 10.0),
                  child: iconBadge(
                    icon: Icons.favorite,
                    iconColor: theme.primaryColor,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    width: size.width - 100.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  widget.food.name,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  '${widget.food.price} DT',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'by',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                              Text(' Restaurant'),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  if (quantity > 0) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 30.0,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                  vertical: 8.0,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text(
                                  '$quantity',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 30.0,
                                  color: theme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: detailsTab(),
                          // reviewTab(),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 8.0,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'Add To cart',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
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
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
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
