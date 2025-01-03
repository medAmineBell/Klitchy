import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klitchyapp/models/category.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/models/food.dart';
import 'package:klitchyapp/models/resto.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/category_foods_screen.dart';
import 'package:klitchyapp/screens/food_details_screen.dart';
import 'package:klitchyapp/widgets/category_item.dart';
import 'package:klitchyapp/widgets/food_Item.dart';
import 'package:klitchyapp/widgets/food_card.dart';
import 'package:provider/provider.dart';

class RestoScreen extends StatefulWidget {
  const RestoScreen({Key? key}) : super(key: key);

  @override
  _RestoScreenState createState() => _RestoScreenState();
}

class _RestoScreenState extends State<RestoScreen> {
  // final List<Food> popularFoods = [
  //   Food(
  //       id: "1",
  //       categoryId: "1",
  //       name: 'Tandoori Chicken',
  //       price: 96.00,
  //       description: "Chicken Chicken Chicken Chicken",
  //       restoId: "1",
  //       imgurl: "images/plate-001.png"),
  //   Food(
  //       id: "1",
  //       categoryId: "1",
  //       name: 'Salmon',
  //       price: 40.50,
  //       description: "Chicken Chicken Chicken Chicken",
  //       restoId: "1",
  //       imgurl: "images/plate-002.png"),
  //   Food(
  //       id: "1",
  //       categoryId: "1",
  //       name: 'Rice and meat',
  //       price: 130.50,
  //       description: "Chicken Chicken Chicken Chicken",
  //       restoId: "1",
  //       imgurl: "images/plate-003.png"),
  //   Food(
  //       id: "1",
  //       categoryId: "1",
  //       name: 'Vegan food',
  //       price: 40.00,
  //       description: "Chicken Chicken Chicken Chicken",
  //       restoId: "1",
  //       imgurl: "images/plate-007.png"),
  //   Food(
  //       id: "1",
  //       categoryId: "1",
  //       name: 'Rich food',
  //       price: 140.00,
  //       description: "Chicken Chicken Chicken Chicken",
  //       restoId: "1",
  //       imgurl: "images/plate-006.png"),
  // ];

  // final List<Map<String, String>> popularFood = [
  //   {
  //     'name': 'Tandoori Chicken',
  //     'price': '96.00',
  //     'rate': '4.9',
  //     'clients': '200',
  //     'image': 'images/plate-001.png'
  //   },
  //   {
  //     'name': 'Salmon',
  //     'price': '40.50',
  //     'rate': '4.5',
  //     'clients': '168',
  //     'image': 'images/plate-002.png'
  //   },
  //   {
  //     'name': 'Rice and meat',
  //     'price': '130.00',
  //     'rate': '4.8',
  //     'clients': '150',
  //     'image': 'images/plate-003.png'
  //   },
  //   {
  //     'name': 'Vegan food',
  //     'price': '400.00',
  //     'rate': '4.2',
  //     'clients': '150',
  //     'image': 'images/plate-007.png'
  //   },
  //   {
  //     'name': 'Rich food',
  //     'price': '1000.00',
  //     'rate': '4.6',
  //     'clients': '10',
  //     'image': 'images/plate-006.png'
  //   }
  // ];

  List<Category> categories = [];

  late Client client;
  late Resto resto;

  List<Food> foods = [];
  List<Food> filtredfoods = [];

  void search() {
    filtredfoods = [];
    foods.forEach((element) {
      if (element.name == searchController.text) {
        filtredfoods.add(element);
      }
    });
    setState(() {});
  }

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    client = Provider.of<DataProvider>(context, listen: false).client;
    resto = Provider.of<DataProvider>(context, listen: false).resto;
    Provider.of<DataProvider>(context, listen: false).getFoods();
    Provider.of<DataProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    foods = Provider.of<DataProvider>(context).foods;
    categories = Provider.of<DataProvider>(context).categories;

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    resto.name,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  InkWell(
                      onTap: () {
                        // Provider.of<DataProvider>(context, listen: false)
                        //     .requestJoinTable();
                      },
                      child: Icon(Icons.notifications_none, size: 28.0))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hi, ${client.name}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const Text(
                    'What do you want to eat today?',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 20.0,
                right: 20.0,
              ),
              child: TextField(
                controller: searchController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  search();
                },
                autocorrect: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        BorderSide(color: Colors.grey[300]!, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Color(0xFFA3A3A3), width: 1.0),
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    size: 28.0,
                    color: Color(0xFFA3A3A3),
                  ),
                  hintText: 'Search here',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 19.0,
                  ),
                ),
              ),
            ),
            Container(
              height: 105,
              margin: const EdgeInsets.only(
                top: 20.0,
                bottom: 25.0,
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    Category category = categories[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CategoryFoodsScreen(
                              category: category,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: CategoryItem(category: category),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Text(
                'Recomended for you',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF59495F)),
              ),
            ),
            if (searchController.text.isEmpty)
              Container(
                height: 260.0,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    Food product = foods[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                FoodDetailsScreen(
                              food: product,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FoodItem(
                          primaryColor: theme.primaryColor,
                          productName: product.name,
                          productPrice: product.price.toString(),
                          productUrl: product.imgurl,
                          productClients: "100",
                          productRate: "4.9",
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (searchController.text.isNotEmpty)
              Container(
                height: 260.0,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: filtredfoods.length,
                  itemBuilder: (context, index) {
                    Food product = filtredfoods[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                FoodDetailsScreen(
                              food: product,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FoodItem(
                          primaryColor: theme.primaryColor,
                          productName: product.name,
                          productPrice: product.price.toString(),
                          productUrl: product.imgurl,
                          productClients: "100",
                          productRate: "4.9",
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
