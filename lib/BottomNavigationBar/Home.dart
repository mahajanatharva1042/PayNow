import 'package:flutter/material.dart';
import 'package:paykaro/MainPage2.dart';
import 'package:paykaro/BottomNavigationBar/Account.dart';
import 'package:paykaro/subpages.dart';
import 'package:paykaro/Login.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // TextEditingController searchbar=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(top:10,bottom:10,left:20,right:20),
            child: Column(
              children: [
                SizedBox(height: 10,),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // Changes position of the shadow
                          ),
                        ],
                      ),
                    child:SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(height: 20,),
                             Container(
                               child:Container(
                                 // color: Colors.black,
                                    child: Row(
                                      children: [
                                      SizedBox(width: 10),
                                 ClipRRect(
                                     borderRadius: BorderRadius.circular(15),
                                     child:GestureDetector(
                                       onTap: (){
                                         // _pickFile();
                                         debugPrint("Banner1");
                                       },
                                       child: Image.asset("assets/Images/banner.jpg",
                                         width: 360.0,
                                         // height:150.0,
                                         // fit: BoxFit.cover,
                                       ),
                                     )
                                 ),//Banner1
                                 SizedBox(width: 10),
                                 ClipRRect(
                                     borderRadius: BorderRadius.circular(15),
                                     child:GestureDetector(
                                       onTap: (){
                                         // _pickFile();
                                         debugPrint("Banner2");
                                       },
                                       child: Image.asset("assets/Images/banner.jpg",
                                         width: 360.0,
                                         // height:150.0,
                                         // fit: BoxFit.cover,
                                       ),
                                     )
                                 ),//Banner2
                                 SizedBox(width: 10),
                                 ClipRRect(
                                     borderRadius: BorderRadius.circular(15),
                                     child:GestureDetector(
                                       onTap: (){
                                         // _pickFile();
                                         debugPrint("Banner3");
                                       },
                                       child: Image.asset("assets/Images/banner.jpg",
                                         width: 360.0,
                                         // height:150.0,
                                         // fit: BoxFit.cover,
                                       ),
                                     )
                                    ),
                                      ],
                                    )
                                ),//BannerContainer
                            ),
                        ],
                      ),
                    )
                  ), //BannerOrOffer

                SizedBox(height: 10,),

                Container(
                  padding: EdgeInsets.only(left:10,right:10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // Changes position of the shadow
                      ),
                    ],
                  ),
                    child: Container(

                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("Services",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[

                              SizedBox(width: 20,),
                              Column(
                                children:<Widget>[
                                  ElevatedButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LightBill()));
                                  }, child: Icon(Icons.receipt), style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyanAccent,
                                  iconColor:Colors.black,
                                  padding: EdgeInsets.all(20),
                                  textStyle: TextStyle(fontSize: 16), elevation: 5, shadowColor: Colors.green,),),
                                  SizedBox(height: 5,),
                                  Text("Light Bill",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                ]
                              ),
                              SizedBox(width: 20,),
                              Column(
                                children:<Widget>[
                                  ElevatedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCart()));
                                  }, child: Icon(Icons.add_card), style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.cyanAccent,
                                    iconColor:Colors.black,
                                    padding: EdgeInsets.all(20),
                                    textStyle: TextStyle(fontSize: 16), elevation: 5, shadowColor: Colors.green,),),
                                  SizedBox(height: 5,),
                                  Text("Add Cart",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                ]
                            ),
                              SizedBox(width: 20,),
                            Column(
                                children:<Widget>[
                                  ElevatedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Recharge()));
                                  }, child: Icon(Icons.phone_android), style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.cyanAccent,
                                    iconColor:Colors.black,
                                    padding: EdgeInsets.all(20),
                                    textStyle: TextStyle(fontSize: 16), elevation: 5, shadowColor: Colors.green,),),
                                  SizedBox(height: 5,),
                                  Text("Recharge",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                ]
                            ),
                              SizedBox(width: 20,),
                            Column(
                                children:<Widget>[
                                  ElevatedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Balance()));
                                    }, child: Icon(Icons.account_balance_outlined), style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.cyanAccent,
                                    iconColor:Colors.black,
                                    padding: EdgeInsets.all(20),
                                    textStyle: TextStyle(fontSize: 16), elevation: 5, shadowColor: Colors.green,),),
                                  SizedBox(height: 5,),
                                  Text("Balance",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                ]
                            ),
                              SizedBox(width: 20,),]
                        ),

                        SizedBox(height: 15,),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                  children:<Widget>[
                                    ElevatedButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Chart()));
                                    }, child: Icon(Icons.addchart_outlined), style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.cyanAccent,
                                      iconColor:Colors.black,
                                      padding: EdgeInsets.all(20),
                                      textStyle: TextStyle(fontSize: 16), elevation: 5, shadowColor: Colors.green,),),
                                    SizedBox(height: 5,),
                                    Text("Chart",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                  ]
                              ),
                              Column(
                                  children:<Widget>[
                                    ElevatedButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>YourBusiness()));
                                      }, child: Icon(Icons.add_business_sharp), style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.cyanAccent,
                                      iconColor:Colors.black,
                                      padding: EdgeInsets.all(20),
                                      textStyle: TextStyle(fontSize: 16), elevation: 5, shadowColor: Colors.green,),),
                                    SizedBox(height: 5,),
                                    Text("Business",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                  ]
                              ),
                              Column(
                                  children:<Widget>[
                                    ElevatedButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Unit()));
                                      }, child: Icon(Icons.ad_units_rounded), style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.cyanAccent,
                                      iconColor:Colors.black,
                                      padding: EdgeInsets.all(20),
                                      textStyle: TextStyle(fontSize: 16), elevation: 5, shadowColor: Colors.green,),),
                                    SizedBox(height: 5,),
                                    Text("Units",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                  ]
                              ),
                              Column(
                                  children:<Widget>[
                                    ElevatedButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Wallet()));
                                      }, child: Icon(Icons.account_balance_wallet), style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.cyanAccent,
                                      iconColor:Colors.black,
                                      padding: EdgeInsets.all(20),
                                      textStyle: TextStyle(fontSize: 16), elevation: 5, shadowColor: Colors.green,),),
                                    SizedBox(height: 5,),
                                    Text("Wallet",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                  ]
                              ), ]
                        ),
                        SizedBox(height: 15,),
                      ],
                    )
                  ),
                ),//Services

                SizedBox(height: 10,),

                Container(
                    padding: EdgeInsets.only(left:10,right:10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
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
                        Text("Peoples",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>User1()));
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
                                  children:[
                                    // const Padding(padding: EdgeInsets.only(left: 10,right: 10)),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child:GestureDetector(
                                        onTap:(){
                                          debugPrint("You Have selected Account2");
                                          // Navigator.of(context).pop();
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>User2()));
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
                                  children:[
                                    // const Padding(padding: EdgeInsets.only(left: 10,right: 10)),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child:GestureDetector(
                                        onTap:(){
                                          debugPrint("You Have selected Account3");
                                          // Navigator.of(context).pop();
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>User3()));
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
                              ]
                        ),

                        SizedBox(height: 20,),

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
                                          debugPrint("You Have selected Account4");
                                          // Navigator.of(context).pop();
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>User4()));
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
                                  children:[
                                    // const Padding(padding: EdgeInsets.only(left: 10,right: 10)),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child:GestureDetector(
                                        onTap:(){
                                          debugPrint("You Have selected Account5");
                                          // Navigator.of(context).pop();
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>User5()));
                                        },
                                        child: Image.asset("assets/Images/OIP.jpeg",
                                          width: 100.0,
                                          height: 100.0,
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text("User 5",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),

                                  ]
                              ),
                              Column(
                                  children:[
                                    // const Padding(padding: EdgeInsets.only(left: 10,right: 10)),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child:GestureDetector(
                                        onTap:(){
                                          debugPrint("You Have selected Account6");
                                          // Navigator.of(context).pop();
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>User6()));
                                        },
                                        child: Image.asset("assets/Images/OIP.jpeg",
                                          width: 100.0,
                                          height: 100.0,
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text("User 6",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),

                                  ]
                              ),
                            ]
                        ),
                        SizedBox(height: 20,),

                      ],
                    )
                ),//Peoples
              ]
            ),
          ),

      ),
    );
  }
}


