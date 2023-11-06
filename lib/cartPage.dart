import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartPrvider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<cartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context,index)
          {
            final cartItm = cart[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(cartItm['imageUrl'] as String ),
              ),
              trailing: IconButton(
                  onPressed: (){
                    showDialog(

                        barrierDismissible: false,
                        context: context, builder: (context){
                      return AlertDialog(title: const Text('Delete Product?'),
                      content: const Text('Are you sure?'),
                      actions: [
                        TextButton(onPressed: (){
                          Provider.of<cartProvider>(context,listen: false).removeProduct(cartItm);
                          Navigator.of(context).pop();
                        }, child: const Text('YES',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();

                        }, child: const Text('No',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                      ],
                      );
                    });

                  },
                  icon: const Icon(Icons.delete,color: Colors.red)),
              title: Text(cartItm['title'] as String,style: Theme.of(context).textTheme.titleSmall),
              subtitle: Text('Size: ${cartItm['size']}',style: Theme.of(context).textTheme.titleSmall ),

            );
          }));
  }
}
