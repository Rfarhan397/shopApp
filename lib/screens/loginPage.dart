import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/signupScreen.dart';
import '../homeScreen.dart';
import 'colors.dart';
class LoginScreen extends StatefulWidget {
  final bool login;

  const LoginScreen({super.key,  this.login = true});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  bool isLoading = false;
  bool isRegistering = false;
  bool isPasswordVisible = false;
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size  size = MediaQuery.of(context).size;
    return  Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: 0,left: 0,
                  child: Image.asset('assets/images/main_top.png',width: size.width* 0.35,)),
              Positioned(
                  bottom: 0,right: 0,
                  child: Image.asset('assets/images/login_bottom.png',width: size.width* 0.4,)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('LOGIN',style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: size.height*0.03,),
                  Image.asset('assets/images/shoe.png',),
                  SizedBox(height: size.height*0.03,),
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
                        hintText: 'E-mail',
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
                        ),
                      ),
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
                          : const Text('LOGIN',style: TextStyle(color: Colors.white),)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don''t have an Account?',style: TextStyle(color: kPrimaryColor)),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>  const SignUpScreen()));
                          },
                          child: const Text( ' SignUp',style: TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor))),
                    ],
                  )

                ],),
            ],
          ),
        ),
      )
    );

  }
  void saveData() async {
    try {
      var  userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );
        if (userCredential.user != null) {
          setState(() {
            isLoading = true;
          });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const homeScreen()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Incorrect Login details')));
        }
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
    }
  }
  // void saveAuthData(String email, String password) async{
  //   var username = usernameController.toString();
  //   var password = passwordController.toString();
  //   FirebaseAuth.instance.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  //   // await FirebaseFirestore.instance.collection("AdminAccess")
  //   //     .doc("admin").get(
  //   // ).then((value) {
  //   //   if(value.exists){
  //   //     username = value.get('username');
  //   //     password = value.get('password');
  //   //
  //   //     if(username == usernameController.text.toString()){
  //   //       if(password == passwordController.text.toString()){
  //   //         Navigator.push(context, MaterialPageRoute(builder: (context) => homeScreen()));
  //   //       }else{
  //   //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sorry! Password theek kr')));
  //   //       }
  //   //     }else{
  //   //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sorry! username theek kr')));
  //   //     }
  //   //   }
  //   // });
  // }
}
