import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qubi7/Homepage.dart';
import 'package:qubi7/SignIn.dart';
import 'package:qubi7/users.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String message = '';
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController(),
      passwordController = new TextEditingController(),
      nameController = new TextEditingController(),
      phoneController = new TextEditingController();
  late String selected = "Student";
  List<String> profession = ['Student', 'Business', 'Teacher'];
  bool isLoading = false;
  CollectionReference collection = FirebaseFirestore.instance.collection('users');

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
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 10,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Calder',
                              color: Colors.white),
                        )),
                    SizedBox(
                      height: 150,
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
                                height: 50,
                              ),
                              text('Email', emailController),
                              SizedBox(
                                height: 20,
                              ),
                              text('Name', nameController),
                              SizedBox(
                                height: 20,
                              ),
                              text('Phone No.', phoneController),
                              SizedBox(
                                height: 20,
                              ),
                              text('Password', passwordController,
                                  obscure: true),
                              Container(
                                margin: EdgeInsets.only(right: 200, top: 20),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 20,
                                          color: Color(0xFF0096c7)
                                              .withOpacity(0.6))
                                    ]),
                                child: DropdownButton<String>(
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                  value: selected,
                                  elevation: 16,
                                  underline: Container(
                                    height: 1.5,
                                    color: Colors.blueAccent,
                                  ),
                                  iconSize: 20,
                                  onChanged: (String? val) {
                                    setState(() {
                                      selected = val!;
                                    });
                                  },
                                  items: profession.map(
                                    (e) {
                                      return DropdownMenuItem(
                                        child: new Text(e),
                                        value: e,
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    if (_key.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      signUp(emailController.text,
                                              passwordController.text)
                                          .then((value) async{
                                        if (value != null){
                                          final obj = UserDetails(email: emailController.text,name: nameController.text,phone: phoneController.text,profession: selected);
                                          await collection.doc(value.uid).set(obj.toJson());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Homepage(
                                                          userId: value.uid)));
                                          isLoading = false;
                                        } else {
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
                                              color: Color(0xFF0096c7)
                                                  .withOpacity(0.6))
                                        ]),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignIn()));
                                  },
                                  child: Text(
                                    'Already have an account? Sign in',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0096c7),
                                        fontSize: 18),
                                  ),
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

  Container text(String hint, TextEditingController val,
      {bool obscure = false}) {
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
        keyboardType:
            hint == "Phone No." ? TextInputType.number : TextInputType.text,
        obscureText: obscure,
        decoration: InputDecoration.collapsed(hintText: hint),
        style: TextStyle(fontSize: 16, color: Colors.blueGrey),
      ),
    );
  }

  Future<User?> signUp(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
        print(message);
        return null;
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
        print(message);
        return null;
      }
    } catch (e) {
      message = e.toString();
      print(message);
      return null;
    }
  }
}
