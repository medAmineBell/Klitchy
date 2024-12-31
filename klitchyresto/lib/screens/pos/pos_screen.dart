import 'package:flutter/material.dart';
import 'package:klitchyresto/app_constants.dart';
import 'package:klitchyresto/models/category.dart';
import 'package:klitchyresto/models/food.dart';
import 'package:klitchyresto/models/tableResto.dart';
import 'package:klitchyresto/providers/cart_provider.dart';
import 'package:klitchyresto/providers/data_provider.dart';
import 'package:klitchyresto/widgets/app_drawer.dart';
import 'package:klitchyresto/widgets/pos_category_item.dart';
import 'package:klitchyresto/widgets/pos_food_item.dart';
import 'package:klitchyresto/widgets/select_food_alert.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class POSScreen extends StatefulWidget {
  POSScreen({Key? key}) : super(key: key);

  @override
  State<POSScreen> createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen> {
  List<Food> foods = [];
  List<Food> filtredFoods = [];
  List<Category> categories = [];
  List<TableResto> tables = [];
  late IO.Socket socket;
  TableResto? dropdownTableValue;

  @override
  void initState() {
    super.initState();
    foods = Provider.of<DataProvider>(context, listen: false).foods;
    filtredFoods = Provider.of<DataProvider>(context, listen: false).foods;
    Provider.of<DataProvider>(context, listen: false).getTables();
    Provider.of<DataProvider>(context, listen: false).getCategories();
    categories = Provider.of<DataProvider>(context, listen: false).categories;
    socket = Provider.of<DataProvider>(context, listen: false).socket;
  }

  Widget renderCartList(CartProvider cart) {
    return ListView(
      children: [
        ...cart.items.values.map((cartItem) {
          Food food = cartItem.food;
          int qty = cartItem.quantity;
          return ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(AppConstants.serverUrl + food.imgurl),
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
            title: Text(
              "${qty}X ${food.name}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              food.description,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Container(
              // width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (food.price * qty).toString() + " TND",
                    style: TextStyle(color: Colors.white),
                  ),
                  InkWell(
                      onTap: () {
                        cart.removeItem(food.id);
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  void filterFoods(String catId) {
    filtredFoods = [];
    for (var food in foods) {
      if (food.categoryId == catId) {
        filtredFoods.add(food);
      }
    }

    setState(() {});
  }

  void clearFilter() {
    filtredFoods = foods;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    categories = Provider.of<DataProvider>(context).categories;
    tables = Provider.of<DataProvider>(context).tableRestos;
    final cart = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        backgroundColor: AppConstants.primaryColorDark1,
        appBar: AppBar(
          title: Text("Klitchy POS System"),
          centerTitle: true,
          backgroundColor: AppConstants.primaryColorDark1,
        ),
        body: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.68,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Categories",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        InkWell(
                          onTap: () {
                            clearFilter();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 76.0,
                                      width: 76,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("images/all.png"),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    ),
                                    Text("All Categories"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        ...categories
                            .map((cat) => InkWell(
                                  onTap: () {
                                    filterFoods(cat.id);
                                  },
                                  child: POSCategoryItem(
                                    category: cat,
                                  ),
                                ))
                            .toList(),
                      ],
                      shrinkWrap: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Foods",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: GridView.count(
                      crossAxisCount: 5,
                      shrinkWrap: true,
                      children: [
                        ...filtredFoods
                            .map((e) => InkWell(
                                  onTap: () async {
                                    await showDialog(
                                      context: this.context,
                                      builder: (BuildContext context) =>
                                          SelectFoodAlert(
                                        food: e,
                                      ),
                                    );
                                  },
                                  child: POSFoodItem(
                                    food: e,
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppConstants.mcgpalette0[400],
              ),
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton<TableResto>(
                    underline: Container(),
                    // Initial Value
                    value: dropdownTableValue,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    dropdownColor: AppConstants.primaryColorDark2,

                    // Down Arrow Icon
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    hint: Text(
                      "Choose Table",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Array list of items
                    items: tables.map((TableResto items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items.name),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (TableResto? newValue) {
                      setState(() {
                        dropdownTableValue = newValue!;
                      });
                    },
                  ),
                  Expanded(
                    child: renderCartList(cart),
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: AppConstants.primaryColorDark2,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                cart.totalAmount.toStringAsFixed(2) + " TND",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: cart.canOrder
                              ? () async {
                                  final orderNum = "00" +
                                      dropdownTableValue!.restoId +
                                      dropdownTableValue!.id +
                                      DateTime.now().year.toString() +
                                      DateTime.now().month.toString() +
                                      DateTime.now().day.toString() +
                                      DateTime.now().hour.toString() +
                                      DateTime.now().minute.toString() +
                                      DateTime.now().second.toString();

                                  cart.items.forEach((key, cartItem) async {
                                    final total =
                                        cartItem.food.price * cartItem.quantity;

                                    await Provider.of<DataProvider>(context,
                                            listen: false)
                                        .addOrder(
                                            total,
                                            orderNum,
                                            cartItem.quantity,
                                            cartItem.food.id,
                                            dropdownTableValue!.id);
                                  });
                                  cart.clear();
                                }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Text(
                              "Order",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
