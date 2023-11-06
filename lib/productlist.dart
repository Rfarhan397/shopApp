import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/colors.dart';
import 'package:shopapp/screens/welcomeScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'card.dart';
import 'details.dart';
import 'globall_variables.dart';

class productlist extends StatefulWidget {
  const productlist({super.key});

  @override
  State<productlist> createState() => _productlistState();
}

class _productlistState extends State<productlist> {
  bool isLoading = false;
  late String selectBrand;
  int activeIndex = 0;
  final List<String> imgUrl = [
    'assets/images/shoe.png',
    'assets/images/shoes_4.png',
    'assets/images/shoes_5.jpg',
    'assets/images/shoes_6.jpg',
  ];
  final colorList = [
    kPrimaryColor,
    kPrimaryLightColor,
    Colors.red,
    Colors.blue
  ];
  @override
  void initState() {
    super.initState();
    selectBrand = brands[0];
  }

  var brands = ['All', 'Addidas', 'Nike', 'Bata'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 255, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Shoes \nCollection",
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_outlined),
                        hintText: 'search',
                        border: border,
                        enabledBorder: border,
                        focusedBorder: border,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        logOut();
                      },
                      icon: const Icon(Icons.logout))
                ],
              ),
              SizedBox(
                height: 200,
                width: MediaQuery.sizeOf(context).width,
                child: CarouselSlider.builder(
                  itemCount: imgUrl.length,
                  itemBuilder: (context, index, realIndex) {
                    final imageUrl = imgUrl[index];
                    return buildImage(imageUrl, index);
                  },
                  options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      }),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                  height: 20,
                  width: MediaQuery.sizeOf(context).width,
                  child: buildIndicator()),
              SizedBox(
                height: 70,
                width: MediaQuery.sizeOf(context).width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: brands.length,
                    itemBuilder: (context, index) {
                      var brand = brands[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectBrand = brand;
                            });
                          },
                          child: Chip(
                            backgroundColor: selectBrand == brand
                                ? Theme.of(context).colorScheme.primary
                                : const Color.fromRGBO(245, 247, 249, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(
                              color: Color.fromRGBO(245, 247, 249, 1),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            label: Text(brand),
                            labelStyle: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 600,
                width: MediaQuery.sizeOf(context).width,
                child: LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth > 1080) {
                    return GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, childAspectRatio: 0.50),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => productDetail(
                                          product: product,
                                          title: 'Quantity',
                                          defaultValue: 0,
                                          onChangeValue: (int) {},
                                        )));
                          },
                          child: ProductCard(
                            title: product['title'] as String,
                            price: product['price'] as double,
                            image: product['imageUrl'] as String,
                            background: index.isEven
                                ? const Color.fromRGBO(216, 240, 253, 1)
                                : const Color.fromRGBO(245, 247, 249, 1),
                          ),
                        );
                      },
                    );
                  } else {
                    return SizedBox(
                      height: 150,
                      width: MediaQuery.sizeOf(context).width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => productDetail(
                                              product: product,
                                              title: 'Quantity',
                                              defaultValue: 0,
                                              onChangeValue: (int) {},
                                            )));
                              },
                              child: Container(
                                height: 250,
                                child: ProductCard(

                                  title: product['title'] as String,
                                  price: product['price'] as double,
                                  image: product['imageUrl'] as String,
                                  background: index.isEven
                                      ? const Color.fromRGBO(216, 240, 253, 1)
                                      : const Color.fromRGBO(245, 247, 249, 1),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return Center(
      child: AnimatedSmoothIndicator(
        effect: const ExpandingDotsEffect(
            dotWidth: 15, dotHeight: 10, activeDotColor: kPrimaryColor),
        activeIndex: activeIndex,
        count: imgUrl.length,
      ),
    );
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const welcomeScreen()));
  }

  Widget buildImage(imageUrl, int index) {
    return Container(
      decoration: BoxDecoration(
        color: colorList[index],
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Image.asset(imageUrl, fit: BoxFit.cover),
    );
  }
}
