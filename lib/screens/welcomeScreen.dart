import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/homeScreen.dart';
import 'package:shopapp/screens/signupScreen.dart';
import 'colors.dart';
import 'loginPage.dart';
class welcomeScreen extends StatefulWidget {
  const welcomeScreen({super.key});

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     autoMove();
  }
  @override
  Widget build(BuildContext context) {
    Size  size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
         body:  Container(
           height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  kPrimaryColor,
                  kPrimaryLightColor,
                ])
            ),
           child: Expanded(
             child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children:[
                   Padding(
                     padding:  const EdgeInsets.symmetric(vertical: 8.0),
                     child:  AnimatedTextKit(
                       animatedTexts: [
                         TyperAnimatedText('Stylesta Footwear',textStyle: const TextStyle(
                           fontWeight: FontWeight.bold,fontSize: 35,fontFamily: 'Lato',
                           fontStyle: FontStyle.italic,
                         ),speed: const Duration(milliseconds: 300)),
                       ],
                     ),
           ),
                   SizedBox(height: size.height* 0.08,),
                   Image.asset('assets/images/shoe.png',),
                   Container(
                     padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                     width: size.width * 0.8,
                     child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                           backgroundColor: kPrimaryColor,
                         ),
                         onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                         }, child: const Text('LOGIN',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                   ),
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 40),
                     width: size.width * 0.8,
                     child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                           backgroundColor: kPrimaryLightColor,
                         ),
                         onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUpScreen()));

                         }, child: const Text('SIGNUP',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                   ),

      ]),
           ),),
      ));
  }

  void autoMove() async{
    String? userUid= FirebaseAuth.instance.currentUser?.uid.toString();
    if (userUid!= null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const homeScreen()));
    }
  }
}


