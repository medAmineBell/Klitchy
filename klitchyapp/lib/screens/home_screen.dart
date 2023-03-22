import 'package:flutter/material.dart';
import 'package:klitchyapp/screens/cart_screen.dart';
import 'package:klitchyapp/screens/events/events_screen.dart';
import 'package:klitchyapp/screens/profile_screen.dart';
import 'package:klitchyapp/screens/resto_screen.dart';
import 'package:klitchyapp/screens/table_screen.dart';
import 'package:klitchyapp/widgets/fab_bottom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
    });
  }

  void _selectedTab(int index) {
    setState(() {
      if (currentIndex != index) {
        pageController.jumpToPage(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          RestoScreen(),
          TableScreen(),
          EventsScreen(),
          ProfileScreen(),
        ],
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        //mini: true,
        backgroundColor: Color(0xFF006C81),
        elevation: 4,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const CartScreen()));
        },
        //mini: true,
        child: const Icon(
          Icons.shopping_cart_outlined,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.white,
        selectedColor: Colors.black,
        notchedShape: const CircularNotchedRectangle(),
        backgroundColor: Color(0xFF006C81),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(
            iconData: Icons.menu_book,
            //text: 'Menu',
            text: '',
          ),
          FABBottomAppBarItem(
            iconData: Icons.table_restaurant_outlined,
            //text: 'Table',
            text: '',
          ),
          FABBottomAppBarItem(
            iconData: Icons.view_list_outlined,
            //text: 'Events',
            text: '',
          ),
          FABBottomAppBarItem(
            iconData: Icons.person,
            //text: 'Profile',
            text: '',
          ),
        ],
        centerItemText: '',
      ),
    );
  }
}
