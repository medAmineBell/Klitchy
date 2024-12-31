import 'package:flutter/material.dart';
import 'package:klitchyapp/models/client.dart';
import 'package:klitchyapp/provider/data_provider.dart';
import 'package:klitchyapp/screens/cart_screen.dart';
import 'package:klitchyapp/screens/events/events_screen.dart';
import 'package:klitchyapp/screens/profile_screen.dart';
import 'package:klitchyapp/screens/resto_screen.dart';
import 'package:klitchyapp/screens/table_screen.dart';
import 'package:klitchyapp/widgets/fab_bottom_app_bar.dart';
import 'package:klitchyapp/widgets/request_joinTable.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeScreen extends StatefulWidget {
  final int index;

  const HomeScreen({super.key, required this.index});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;
  late PageController pageController;
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    final isOwner = Provider.of<DataProvider>(context, listen: false).isOwner();
    socket = Provider.of<DataProvider>(context, listen: false).socket;
    if (socket.disconnected) {
      Provider.of<DataProvider>(context, listen: false).connectToSocket();
    }
    if (isOwner) {
      socket.on('JoinTable', (data) {
        print(data);
        final tableId =
            Provider.of<DataProvider>(context, listen: false).tableResto.id;
        final socketTableId = data["tableId"];

        print("tableid = " + tableId);
        print("socketTableId = " + socketTableId);
        print("equal = " + tableId.toString() == socketTableId.toString());
        if (tableId.toString() == socketTableId.toString()) {
          final client = Client.fromJson(data["user"]);
          print("pop the request for : " + client.name);
          showDialog(
            context: this.context,
            builder: (BuildContext context) => RequestJoinTable(
              client: client,
            ),
          ).then((value) {
            print("res req = $value");
            Provider.of<DataProvider>(context, listen: false)
                .responseJoinTable(client, value);
          });
        }
      });
    }
    if (widget.index == -1) {
      _selectedTab(widget.index);
    }
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
      resizeToAvoidBottomInset: false,
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
