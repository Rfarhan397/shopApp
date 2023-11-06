import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/colors.dart';

import 'cartPrvider.dart';

class productDetail extends StatefulWidget {
  final String title;
  final int defaultValue;
  final Function(int) onChangeValue;
  final Map<String,Object> product;
  const productDetail(
      {required this.title,
        required this.onChangeValue,
        this.defaultValue = 2,
        Key? key, required this.product})
      : assert(defaultValue >= 0),
        super(key: key);

  @override
  State<productDetail> createState() => _productDetailState();
}

class _productDetailState extends State<productDetail> {

  late int _count;
  late double _price;
  @override
  void initState() {
    super.initState();
    _count = widget.defaultValue;
    _price = widget.product['price'] as double;
  }
  int selectSize =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
              child: Text(
                  widget.product['title']as String,
                  style: Theme.of(context).textTheme.titleLarge
          ),),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(widget.product['imageUrl'] as String),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(245, 247, 247, 1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  const SizedBox(width: 4,),
                  Row(
                    children: [
                      OutlinedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(const Size(10, 10)),
                          ),
                          onPressed: () {
                            if (_count > 0) {
                              setState(() {
                                _count -= 1;
                                _price = _price / 2;
                              });
                              widget.onChangeValue(_count);
                            }
                          },
                          child: const Text(
                            "-",
                            style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.black),
                          )),
                      const SizedBox(width: 10,),
                      Text(_count.toString(),style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 15,
                      ),
                      OutlinedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(const Size(10, 10)),
                          ),
                          onPressed: () {
                            setState(() {
                              _count += 1;
                              _price = _price * 2;
                            });
                            widget.onChangeValue(_count);

                          },
                          child: const Text(
                            "+",
                            style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.black),
                          )),
                      const Spacer(),
                      Text('\$$_price ', style: Theme.of(context).textTheme.titleLarge),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: (widget.product['size'] as List<int>).length,
                        itemBuilder: (context,index){
                          final size = (widget.product['size'] as List<int>)[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () { setState(() {
                                  selectSize = size;
                                });},
                                child: Chip(label: Text(size.toString()),
                                backgroundColor: selectSize == size ? kPrimaryColor: null,
                                )),
                          );

                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_cart,color: Colors.black),  //icon data for elevated button
                        label: const Text("Add to cart",style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          minimumSize: const Size(250, 50)
                        ),
                        onPressed: (){
                          if (selectSize!=0){Provider.of<cartProvider>(context, listen: false).addProduct({
                            'id': widget.product['id'],
                            'title': widget.product['title'],
                            'price': widget.product['price'],
                            'imageUrl': widget.product['imageUrl'],
                            'company': widget.product['company'],
                            'size': selectSize
                          });
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added successfuly')));
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a Size')));
                          }

                        }, )),
                 ],
              ),
            ),
          )]),
    );
  }
}
