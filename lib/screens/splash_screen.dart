import 'package:flutter/material.dart';
import 'package:shopapp/screens/welcomeScreen.dart';

import 'colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      // Push the new page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const welcomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kPrimaryColor,
            kPrimaryLightColor,
          ],
        ),
      ),
      child: Column(
        children: [
          const AnimatedPositioned(
              duration: Duration(seconds: 2),
              child: Text(
                "Stylesta Footwear",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Center(
            child: Image.asset('assets/images/shoe.png'),
          ),
        ],
      ),
    ));
  }
}
