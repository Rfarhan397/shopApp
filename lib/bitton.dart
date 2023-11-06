import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class buttonn extends StatefulWidget {
  const buttonn({super.key});

  @override
  State<buttonn> createState() => _buttonnState();
}

class _buttonnState extends State<buttonn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: (){
              saveData();
            },child: const Text('upload'),
          ),
        ),
      ),
    );
  }

  void saveData() async{
    await FirebaseFirestore.instance.collection("data")
        .doc("feeeee")
        .set({
      "daa":"t",
    });
  }
}
