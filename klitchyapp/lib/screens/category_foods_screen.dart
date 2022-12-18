import 'package:flutter/material.dart';
import 'package:klitchyapp/models/category.dart';
import 'package:klitchyapp/models/food.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/food_details_screen.dart';
import 'package:klitchyapp/widgets/category_food_item.dart';
import 'package:klitchyapp/widgets/food_card.dart';
import 'package:provider/provider.dart';

class CategoryFoodsScreen extends StatefulWidget {
  final Category category;
  const CategoryFoodsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  _CategoryFoodsScreenState createState() => _CategoryFoodsScreenState();
}

class _CategoryFoodsScreenState extends State<CategoryFoodsScreen> {
  final List<Food> popularFoods = [
    Food(
        id: "1",
        categoryId: "1",
        name: 'Tandoori Chicken',
        price: 96.00,
        description: "Chicken Chicken Chicken Chicken",
        restoId: "1",
        imgurl: "images/food.jpeg"),
    Food(
        id: "1",
        categoryId: "1",
        name: 'Salmon',
        price: 40.50,
        description: "Chicken Chicken Chicken Chicken",
        restoId: "1",
        imgurl: "images/plate-002.png"),
    Food(
        id: "1",
        categoryId: "1",
        name: 'Rice and meat',
        price: 130.50,
        description: "Chicken Chicken Chicken Chicken",
        restoId: "1",
        imgurl: "images/plate-003.png"),
    Food(
        id: "1",
        categoryId: "1",
        name: 'Vegan food',
        price: 40.00,
        description: "Chicken Chicken Chicken Chicken",
        restoId: "1",
        imgurl: "images/plate-007.png"),
    Food(
        id: "1",
        categoryId: "1",
        name: 'Rich food',
        price: 140.00,
        description: "Chicken Chicken Chicken Chicken",
        restoId: "1",
        imgurl: "images/plate-006.png"),
    Food(
        id: "1",
        categoryId: "1",
        name: 'Tandoori Chicken',
        price: 96.00,
        description: "Chicken Chicken Chicken Chicken",
        restoId: "1",
        imgurl: "images/plate-001.png"),
    Food(
        id: "1",
        categoryId: "1",
        name: 'Salmon',
        price: 40.50,
        description: "Chicken Chicken Chicken Chicken",
        restoId: "1",
        imgurl: "images/plate-002.png"),
    Food(
        id: "1",
        categoryId: "1",
        name: 'Rice and meat',
        price: 130.50,
        description: "Chicken Chicken Chicken Chicken",
        restoId: "1",
        imgurl: "images/plate-003.png"),
    Food(
        id: "1",
        categoryId: "1",
        name: 'Vegan food',
        price: 40.00,
        description: "Chicken Chicken Chicken Chicken",
        restoId: "1",
        imgurl: "images/plate-007.png"),
    Food(
        id: "1",
        categoryId: "1",
        name: 'Rich food',
        price: 140.00,
        description: "Chicken Chicken Chicken Chicken",
        restoId: "1",
        imgurl: "images/plate-006.png"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
        centerTitle: true,
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
              child: Text(
                'Showing ${popularFoods.length} foods',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF59495F)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: popularFoods.length,
                itemBuilder: (context, index) {
                  Food product = popularFoods[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => FoodDetailsScreen(
                            food: product,
                          ),
                        ),
                      );
                    },
                    child: CategoryFoodItem(
                      productName: product.name,
                      productPrice: product.price.toString(),
                      productUrl: product.imgurl,
                      productRate: "4.9",
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
