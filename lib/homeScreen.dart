import 'package:flutter/material.dart';
import 'package:shopapp/productlist.dart';
import 'cartPage.dart';
class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);
  @override
  State<homeScreen> createState() => _homeScreenState();
}
class _homeScreenState extends State<homeScreen> {
  var currentPage = 0;
  List<Widget> pages = [const productlist(),const CartPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: currentPage,
          children : pages),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (value){
          setState(() {
            currentPage =value;
          });
        },
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
            label: '',
              icon: Icon(Icons.home,),
          ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.shopping_cart),
        ),
        ],
      ),
    );
  }
}
