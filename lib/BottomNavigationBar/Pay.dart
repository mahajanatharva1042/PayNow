import 'package:flutter/material.dart';
import 'package:paykaro/main.dart';
import 'package:paykaro/subpages.dart';
class Pay extends StatelessWidget {
  const Pay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Container(
                padding: EdgeInsets.only(left:10,right:10),
                margin: EdgeInsets.only(left:15,right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // Changes position of the shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                              children:[
                                // const Padding(padding: EdgeInsets.only(left: 10,right: 10)),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child:GestureDetector(
                                    onTap:(){
                                      debugPrint("You Have selected Account1");
                                      // Navigator.of(context).pop();
                                    },
                                    child: Image.asset("assets/Images/OIP.jpeg",
                                      width: 100.0,
                                      height: 100.0,
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text("User 1",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                              ]
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text("User 1",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  ElevatedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>User1()));}, child: Text("Pay"))
                                ],
                              ),
                            ],
                          ),
                        ]
                    ),
                    SizedBox(height: 10,),
                  ],
                )
            ),
            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.only(left:10,right:10),
                margin: EdgeInsets.only(left:15,right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // Changes position of the shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                              children:[
                                // const Padding(padding: EdgeInsets.only(left: 10,right: 10)),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child:GestureDetector(
                                    onTap:(){
                                      debugPrint("You Have selected Account2");
                                      // Navigator.of(context).pop();
                                    },
                                    child: Image.asset("assets/Images/OIP.jpeg",
                                      width: 100.0,
                                      height: 100.0,
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text("User 2",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                              ]
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text("User 2",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  ElevatedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>User2()));}, child: Text("Pay"))
                                ],
                              )
                            ],
                          ),
                        ]
                    ),
                  ],
                )
            ),
            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.only(left:10,right:10),
                margin: EdgeInsets.only(left:15,right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // Changes position of the shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                              children:[
                                // const Padding(padding: EdgeInsets.only(left: 10,right: 10)),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child:GestureDetector(
                                    onTap:(){
                                      debugPrint("You Have selected Account3");
                                      // Navigator.of(context).pop();
                                    },
                                    child: Image.asset("assets/Images/OIP.jpeg",
                                      width: 100.0,
                                      height: 100.0,
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text("User 3",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                              ]
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text("User 3",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  ElevatedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>User1()));}, child: Text("Pay"))
                                ],
                              )
                            ],
                          ),
                        ]
                    ),
                  ],
                )
            ),SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.only(left:10,right:10),
                margin: EdgeInsets.only(left:15,right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // Changes position of the shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                              children:[
                                // const Padding(padding: EdgeInsets.only(left: 10,right: 10)),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child:GestureDetector(
                                    onTap:(){
                                      debugPrint("You Have selected Account1");
                                      // Navigator.of(context).pop();
                                    },
                                    child: Image.asset("assets/Images/OIP.jpeg",
                                      width: 100.0,
                                      height: 100.0,
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text("User 4",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                              ]
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text("User 4",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  ElevatedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>User1()));}, child: Text("Pay"))
                                ],
                              )
                            ],
                          ),
                        ]
                    ),
                  ],
                )
            ),


          ],
        ),
      ),
    );
  }
}
