import 'package:flutter/material.dart';
import 'package:paynow/Login.dart';
class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue,Colors.pink],
                begin: Alignment.topRight,
                end:Alignment.bottomLeft
            )
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child:GestureDetector(
                  onTap:(){
                    debugPrint("You Have selected Account3");
                    // Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20,),
                      Text("Click Here to LogOut", style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(width: 15,),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
                        },
                        icon: Icon(Icons.logout_outlined), // The icon
                        label: Text('LogOut',style: TextStyle(color:Colors.red,fontWeight: FontWeight.bold),), // The text label
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
