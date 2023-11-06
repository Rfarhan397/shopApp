
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'colors.dart';
import 'loginPage.dart';

class SignUpScreen extends StatefulWidget {
  final bool login;
  const SignUpScreen({super.key,  this.login = true});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var username,email,password;
  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isRegistering = false;

  @override
  Widget build(BuildContext context) {
    Size  size = MediaQuery.of(context).size;
    return  SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          body: SizedBox(
            width: double.infinity,
            height: size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 0,left: 0,
                    child: Image.asset('assets/images/signup_top.png',width: size.width* 0.35,)),
                Positioned(
                    bottom: 0,left: 0,
                    child: Image.asset('assets/images/main_bottom.png',width: size.width* 0.23,)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(children: [
                      SvgPicture.asset('assets/icons/signup.svg',height: 180),
                    ],)),
                    Expanded(
                        flex: 2,
                        child: Column(children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'username',
                            icon:Icon(Icons.person,color: kPrimaryColor) ,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'email',
                            icon:Icon(Icons.person,color: kPrimaryColor) ,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextField(
                          obscureText: !isPasswordVisible,
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'password',
                              icon:const Icon(Icons.lock,color: kPrimaryColor) ,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: kPrimaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                        width: size.width * 0.8,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                            ),
                            onPressed: (){
                              if (!isRegistering) {
                                setState(() {
                                  isRegistering = true; // Start the registration process
                                });
                                saveData();
                              }
                              }, child: isRegistering
                            ? const CircularProgressIndicator(color: Colors.white,) // Show the progress indicator
                            : const Text('SIGNUP',style: TextStyle(color: Colors.white),)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text( 'Already have an account?',style: TextStyle(color: kPrimaryColor)),
                          GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  const LoginScreen()));

                              },
                              child: const Text(' SignIn',style: TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor))),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
                        child: Row(
                          children: [
                            Expanded(child: Divider(color: Color(0xFFD9D9D9),height: 1.5,)),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('OR',style: TextStyle(color: kPrimaryColor)),
                            ),
                            Expanded(child: Divider(color: Color(0xFFD9D9D9),height: 1.5,))
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){},
                            child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5), // Shadow color
                                      spreadRadius: 0,
                                      blurRadius: 1.5,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child:  SvgPicture.asset(
                                  'assets/icons/twitter.svg',
                                  height: 20,
                                  width: 20,
                                  color: kPrimaryColor,
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: InkWell(
                              onTap: (){},
                              child: Container(
                                padding: const EdgeInsets.all(20),

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5), // Shadow color
                                      spreadRadius: 0,
                                      blurRadius: 1.5,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset('assets/icons/facebook.svg',height: 20,
                                    width: 20,color: kPrimaryColor),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){},
                            child: Container(
                              padding: const EdgeInsets.all(20),

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5), // Shadow color
                                    spreadRadius: 0,
                                    blurRadius: 1.5,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset('assets/icons/google-plus.svg',height: 20,
                                  width: 20,color: kPrimaryColor),
                            ),
                          ),
                        ],),
                    ],))
                  ],),
              ],
            ),
          ),
      ),
    );
  }

 void saveData() async {

    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      ).then((userCredential) {
        if (userCredential.user != null) {
          String userId = userCredential.user!.uid;
          FirebaseFirestore.instance.collection("Users").doc(userId).set({
            "username": usernameController.text.toString(),
            "email": emailController.text.toString(),
            "password": passwordController.text.toString(),
            "Userid" : userId.toString(),
          }).whenComplete(() {
            setState(() {
              isLoading = true;
            });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User creation failed')));
        }
      });
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('something went wrong')));
    }
    }
  }

