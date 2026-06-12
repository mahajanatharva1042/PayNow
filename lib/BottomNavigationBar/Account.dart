import 'package:paykaro/MainPage2.dart';
import 'package:flutter/material.dart';
import 'package:paykaro/logout.dart';

class Account extends StatelessWidget {
  // const Account({super.key, required password});

  String? username,password;
  Account({
    this.username,
    this.password
});
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        // appBar:AppBar(
        //   title: const Text("Account",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
        // ),

        body:Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin:const EdgeInsets.only(top:10,bottom: 30,left: 20,right: 20),
                            width: 150,
                            height: 150,
                            decoration:  BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // Changes position of the shadow
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(75),
                              child:GestureDetector(
                                onTap: (){
                                  debugPrint("You Have Selected Account");
                                },
                                child: Image.asset("assets/Images/OIP.jpeg",
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),


                            ),
                          ),
                          Text("Admin",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                        ],
                      ),
                      Column(
                        children: [
                          Text("Admin",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                          SizedBox(height: 10,),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.account_balance,
                              color: Colors.green,
                              size: 30.0,
                            ),
                            label: const Text('Your Bank'),
                            onPressed: () {
                              // print('Button Pressed');
                              // Customization();
                            },
                          ),
                          SizedBox(height: 10,),
                          Text("Your Balance: ₹99",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),

                  Container(
                      padding: EdgeInsets.all(30),
                      margin: EdgeInsets.all(15),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Row(
                                children: [
                                  SizedBox(width: 35,),
                                  Text("Click Here to LogOut", style: TextStyle(color: Colors.red, fontSize: 15,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 15,),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // Navigator.of(context).pop();
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LogOut()));
                                    },
                                    icon: Icon(Icons.logout_outlined), // The icon
                                    label: Text('LogOut',style: TextStyle(color:Colors.red,fontWeight: FontWeight.bold),), // The text label
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      textStyle: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      )
                  ),
                ]
            )
        )
    );
  }
}


