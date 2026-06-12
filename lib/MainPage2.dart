import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:paykaro/BottomNavigationBar/Home.dart';
import 'package:paykaro/BottomNavigationBar/Search.dart';
import 'package:paykaro/BottomNavigationBar/Pay.dart';
import 'package:paykaro/Drawer/History.dart';
import 'package:paykaro/BottomNavigationBar/Account.dart';
import 'package:paykaro/Drawer/Customization.dart';
import 'package:paykaro/Drawer/Analysis.dart';
import 'package:paykaro/Drawer/Settting.dart';
import 'package:paykaro/Login.dart';
import 'package:paykaro/logout.dart';
import 'package:paykaro/BottomNavigationBar/accountmenu.dart';

class HomeScreen extends StatefulWidget {

  String? username,password;
  HomeScreen({
    super.key,
    this.username,
    this.password
});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  String? username,password;
  _HomeScreenState({
    this.username,
    this.password
  });
  final _pageData=[Home(), Search(),Pay(),Account()];
  int _selectedIndex=0;
  // String yourname=AutofillHints.username;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context)=>IconButton(onPressed: (){
            Scaffold.of(context).openDrawer();
          }, icon: Icon(Icons.menu_rounded,size: 35,))
        ),
        // leading:(padding:EdgeInsets.only(left: 10,right: 10)),
        title:const Text("Pay Karo",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.cyanAccent,
        centerTitle: true,

        actions: [
          Padding(padding: EdgeInsets.only(left: 10,right: 10)),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child:GestureDetector(
              onTap:(){
                debugPrint("You Have selected Account");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>History()));
              },
              child: Icon(Icons.notifications,weight: 35,color: Colors.black,size: 30,),
            ),
          ),
          SizedBox(width: 10,),

          Container(
            margin:const EdgeInsets.only(right: 10),
            width: 45,
            height:45,

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
                borderRadius: BorderRadius.circular(50),
                child:GestureDetector(
                  onTap: (){
                    debugPrint("Kuch Bhi");

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountMenu()));
                  },
                  child: Image.asset("assets/Images/OIP.jpeg",
                    width: 20.0,
                    height: 20.0,
                    fit: BoxFit.cover,
                  ),
                )
            ),
          ),
        ],
      ),

      drawer:Drawer(
          child:Column(
              children:<Widget>[
                Container(
                    color:Theme.of(context).primaryColor,
                    width:double.infinity,
                    child:Column(
                      children: <Widget>[
                        Container(
                          margin:const EdgeInsets.only(top:40,bottom: 30),
                          width: 100,
                          height: 100,
                          decoration:  BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // Changes position of the shadow
                              ),
                            ],
                            gradient: LinearGradient(
                                colors: [Colors.blue,Colors.pink],
                                begin: Alignment.topLeft,
                                end:Alignment.bottomRight
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child:GestureDetector(
                                onTap: (){
                                  // _pickFile();
                                  debugPrint("You Have Click Account");
                                },
                                child: Image.asset("assets/Images/OIP.jpeg",
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              )

                          ),
                        ),
                        Text(AutofillHints.username,style: const TextStyle(
                            fontSize: 20,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold
                        ),),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 30.0,
                          ),
                          label: const Text('Edit'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Customization()));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),


                        const SizedBox(height: 10,),
                      ],
                    )
                ),
                const SizedBox(height: 10,),

                const SizedBox(height: 10,),
                ListTile(
                    title:const Text("Account",style:TextStyle(
                        fontSize: 20,
                        color: Colors.black87
                    ),),
                    leading:const Icon((Icons.account_box)),
                    onTap:(){
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountMenu(
                          username:username.text,
                          password:password.text,
                      )));
                    }
                ),

                const SizedBox(height: 10,),
                ListTile(
                    title:const Text("Analytics",style:TextStyle(
                        fontSize: 20,
                        color: Colors.black87
                    ),),
                    leading:const Icon((Icons.analytics)),
                    onTap:(){
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Analysis()));
                    }
                ),
                const SizedBox(height: 10,),


                ListTile(
                    title:const Text("Customization",style:TextStyle(
                        fontSize: 20,
                        color: Colors.black87
                    ),),
                    leading:const Icon((Icons.dashboard_customize)),
                    onTap:(){
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Customization()));
                    }
                ),
                const SizedBox(height: 10,),
                ListTile(
                    title:const Text("Setting",style:TextStyle(
                        fontSize: 20,
                        color: Colors.black87
                    ),),
                    leading:const Icon((Icons.settings)),
                    onTap:(){
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Setting()));
                    }
                ),
                const SizedBox(height: 10,),

                ListTile(
                    title:const Text("Log Out",style:TextStyle(
                        fontSize: 20,
                        color: Colors.black87
                    ),),
                    leading:const Icon((Icons.logout)),
                    onTap:(){
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const LogOut()));
                    }
                )

              ]
          )
      ),

      body:Container(
        child: Center(
          child:_pageData[_selectedIndex],
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          // padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
          padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
          child: GNav(
            selectedIndex: _selectedIndex,  // Update this line based on the current parameter name
            onTabChange: _onItemTapped,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.green,
            tabBackgroundColor: Colors.grey.shade800,

            padding: EdgeInsets.all(15),
            gap:8,
            tabs: const [
              GButton(icon: Icons.dashboard,text: "Home",),
              GButton(icon: Icons.search_rounded,text:"Search"),
              GButton(icon: Icons.paypal,text: "Pay",),
              GButton(icon: Icons.person,text: "Account",),
            ],

          ),
        ),
      ),
    );
  }
}

extension on String? {
  get text => null;
}

