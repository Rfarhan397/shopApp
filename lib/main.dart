import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/cartPrvider.dart';
import 'package:shopapp/screens/colors.dart';
import 'package:shopapp/screens/signupScreen.dart';

import 'firebase_options.dart';
import 'homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => cartProvider(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(254, 206, 1, 1),
              primary: kPrimaryColor),
          inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              prefixIconColor: Color.fromRGBO(119, 119, 119, 1)),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SignUpScreen(),
      ),
    );
  }
}
