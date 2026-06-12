import 'package:flutter/material.dart';
import 'package:paykaro/main.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("History",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 25,),
          Container(
              padding: EdgeInsets.only(left:80,right:80),
              // margin: EdgeInsets.only(left: 15),
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
              child:Column(
                children: [
                  Container(
                      child:Column(
                          children: [
                            SizedBox(height: 10,),
                            Text("Transaction 1 ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                            SizedBox(height: 10,),
                            Text("You Receive  ₹999 from User 1",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                            SizedBox(height: 10,),
                          ]
                      )
                  ),
                ],
              )
          ),

          SizedBox(height: 20,),

          Container(
              padding: EdgeInsets.only(left:80,right:80),
              // margin: EdgeInsets.only(left: 15),
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
              child:Column(
                children: [
                  Container(
                      child:Column(
                          children: [
                            SizedBox(height: 10,),
                            Text("Transaction 2 ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                            SizedBox(height: 10,),
                            Text("You Receive  ₹9999 from User 5",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                            SizedBox(height: 10,),
                          ]
                      )
                  ),
                ],
              )
          ),
          SizedBox(height: 20,),
          Container(
              padding: EdgeInsets.only(left:80,right:80),
              // margin: EdgeInsets.only(left: 15),
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
              child:Column(
                children: [
                  Container(
                      child:Column(
                          children: [
                            SizedBox(height: 10,),
                            Text("  Transaction 3  ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                            SizedBox(height: 10,),
                            Text("You Pay  ₹499 from User 4",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                            SizedBox(height: 10),
                          ]
                      )
                  ),
                ],
              )
          ),
          SizedBox(height: 20,),
          Container(
              padding: EdgeInsets.only(left:80,right:80),
              // margin: EdgeInsets.only(left: 15),
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
              child:Column(
                children: [
                  Container(
                      child:Column(
                          children: [
                            SizedBox(height: 10,),
                            Text("Transaction 4 ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                            SizedBox(height: 10,),
                            Text("You Receive  ₹599 from User 6",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                            SizedBox(height: 10,),
                          ]
                      )
                  ),
                ],
              )
          ),
          SizedBox(height: 20,),
          Container(
              padding: EdgeInsets.only(left:80,right:80),
              // margin: EdgeInsets.only(left: 15),
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
              child:Column(
                children: [
                  Container(
                      child:Column(
                          children: [
                            SizedBox(height: 10,),
                            Text("Transaction 5",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                            SizedBox(height: 10,),
                            Text("You Receive  ₹6999 from User 1",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                            SizedBox(height: 10,),
                          ]
                      )
                  ),
                ],
              )
          ),
          SizedBox(height: 20,),

        ],
      ),


    );
  }
}