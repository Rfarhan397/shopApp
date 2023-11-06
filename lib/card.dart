import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final Color background;
  const ProductCard({super.key ,required this.title, required this.price, required this.image, required this.background});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 5),
          Text('\$$price',style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 5),
          Center(child: Image.asset(height: 175,image)),

        ],
      ),
    );
  }
}
