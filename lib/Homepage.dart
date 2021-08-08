import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qubi7/Signup.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SignIn.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, required String userId}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int count = 0;
  int count1 = 0;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movies'),),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Movies',style: TextStyle(color: Colors.white),),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/abstract.jpg')
              )
            ),),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: (){
                setState(() {
                  selected = false;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Company Info'),
              onTap: (){
                setState(() {
                  selected = true;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.open_in_browser),
              title: Text('Hoblist'),
              onTap: () {
                _launchURL();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log Out'),
              onTap: ()=>signOut(),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: selected?Center(child:RichText(text: TextSpan(
            children: [
              TextSpan(text: 'Company: Technoboot Technologies Pvt Ltd\n',style: TextStyle(fontSize: 18,color: Colors.black)),
              TextSpan(text: 'Address: Bhubaneswar\n',style: TextStyle(fontSize: 18,color: Colors.black)),
              TextSpan(text: 'Phone: XXXXXXXXXXX09\n',style: TextStyle(fontSize: 18,color: Colors.black)),
              TextSpan(text: 'Email: XXXXXXXXX@gmail.com\n',style: TextStyle(fontSize: 18,color: Colors.black)),
            ]
          ),)):ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              count++;
                            });
                          },
                            child: Icon(
                          Icons.arrow_drop_up,
                          size: 50,
                          color: Colors.black,
                        )),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "$count",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 3),
                        GestureDetector(
                          onTap: (){
                            if(count>0){
                            setState(() {
                              count--;
                            });}
                          },
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 50,
                            color: Colors.black,
                          ),
                        ),
                        Text('Votes',style: TextStyle(fontSize: 18),)
                      ],
                    ),
                    Container(
                      height: 160,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                            child:Image(image: AssetImage('images/bond.png'),fit: BoxFit.fill,)),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Container(
                      height: 135,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bond 25',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 8,),
                          RichText(text: TextSpan(children: [
                            TextSpan(text: 'Genre: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 14)),
                            TextSpan(text: 'Adventure,Action,Thriller \n',style: TextStyle(color: Colors.black,fontSize: 14)),
                            TextSpan(text: 'Director: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 14)),
                            TextSpan(text: 'Cary Joji Fukunaga \n',style: TextStyle(color: Colors.black,fontSize: 14)),
                            TextSpan(text: 'Starring: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 14)),
                            TextSpan(text: 'Anna De Armas,Rami... \n',style: TextStyle(color: Colors.black,fontSize: 14)),
                            TextSpan(text: 'Mins | English | 2 Apr',style: TextStyle(color: Colors.black,fontSize: 14)),
                          ]),),
                          SizedBox(height: 3),
                          Text('137 views | Voted by $count people',style: TextStyle(fontWeight:FontWeight.bold,color: Colors.blue,fontSize: 14))
                        ],
                      ),
                    )

                ],
              ),
                    SizedBox(height: 5,),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('Watch Trailer',style: TextStyle(color: Colors.white,fontSize: 20),),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 10,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                                onTap:(){
                                  setState(() {
                                    count1++;
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  size: 50,
                                  color: Colors.black,
                                )),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "$count1",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 3),
                            GestureDetector(
                              onTap: (){
                                if(count1>0){
                                  setState(() {
                                    count1--;
                                  });}
                              },
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                            Text('Votes',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                        Container(
                          height: 160,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:Image(image: AssetImage('images/new.jpg'),fit: BoxFit.fill,)),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Container(
                          height: 135,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('The New Mutants',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              SizedBox(height: 8,),
                              RichText(text: TextSpan(children: [
                                TextSpan(text: 'Genre: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 14)),
                                TextSpan(text: 'Horror,Action,SciFi \n',style: TextStyle(color: Colors.black,fontSize: 14)),
                                TextSpan(text: 'Director: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 14)),
                                TextSpan(text: 'Josh Boone \n',style: TextStyle(color: Colors.black,fontSize: 14)),
                                TextSpan(text: 'Starring: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 14)),
                                TextSpan(text: 'Blue Hunt,Charlie Heat..\n',style: TextStyle(color: Colors.black,fontSize: 14)),
                                TextSpan(text: 'Mins | English | 1 Apr',style: TextStyle(color: Colors.black,fontSize: 14)),
                              ]),),
                              SizedBox(height: 3),
                              Text('127 views | Voted by $count1 people',style: TextStyle(fontWeight:FontWeight.bold,color: Colors.blue,fontSize: 14))
                            ],
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('Watch Trailer',style: TextStyle(color: Colors.white,fontSize: 20),),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));
  }
  _launchURL() async {
    const url = 'https://hoblist.com';
    if ( await canLaunch(url)) {
       launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not open $url')));
    }
  }
}
