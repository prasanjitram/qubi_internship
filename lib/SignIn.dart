

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qubi7/Homepage.dart';
import 'package:qubi7/Signup.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String message='';
  bool isLoading=false;
  TextEditingController emailController = new TextEditingController(),
      passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Color(0xFF0096c7),
                Color(0xFF0096c7),
                Color(0xFF48cae4),
              ])),
          child:isLoading?Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 5,),): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Calder',
                        color: Colors.white),
                  )),
              SizedBox(
                height: 200,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  child: Form(
                    key: _key,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        text('Email',emailController),
                        SizedBox(
                          height: 40,
                        ),
                        text('Password',passwordController,obscure: true),
                        SizedBox(height: 60,),
                        Center(child: GestureDetector(onTap: (){
                          if(_key.currentState!.validate()){
                            setState(() {
                              isLoading = true;
                            });
                            signIn(emailController.text, passwordController.text).then((value){
                              if(value!=null){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage(userId: value.uid)));
                                isLoading = false;
                              }
                              else{
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                              }
                            });
                          }

                        },
                          child: Container(
                            width: 150,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color(0xFF48cae4),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 20,
                                      color: Color(0xFF0096c7).withOpacity(0.6))
                                ]),
                            child: Icon(Icons.arrow_forward,size: 50,color: Colors.white,),
                          ),
                        ),),
                        SizedBox(height: 20,),
                        Center(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                            },
                            child: Text('Don\'t have an account? Sign Up',style: TextStyle(fontWeight:FontWeight.bold,color: Color(0xFF0096c7),fontSize: 18),),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container text(String hint,TextEditingController val, {bool obscure = false}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 20,
                color: Color(0xFF0096c7).withOpacity(0.6))
          ]),
      child: TextFormField(
        validator: (val) {
          if (val == null || val.isEmpty) return "This field can't be empty";
        },
        controller: val,
        obscureText: obscure,
        decoration: InputDecoration.collapsed(hintText: hint),
        style: TextStyle(fontSize: 16,color: Colors.blueGrey),
      ),
    );
  }
  Future<User?> signIn(String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      return user;
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
        return null;
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
        return null;
      } else {
        message = 'Invalid Details';
        return null;
      }
    }
  }
}
