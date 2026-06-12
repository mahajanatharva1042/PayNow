import 'package:flutter/material.dart';

class Analysis extends StatelessWidget {
  const Analysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analysis",style:TextStyle( color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      body: Center(

         child:Column(
           children: [
             Text("Rupees Analytics", style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold),),
             Container(
              margin: const EdgeInsets.only(top: 10, bottom: 30, left: 20, right: 20),
              width: 400,
              height: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // Changes position of the shadow
                  ),
                ],
                // shape: BoxShape.circle,
              ),

              child: ClipRect( // U
                // se ClipOval for circular shape
                child: Image.asset(
                  'assets/Images/Rupee.jpg',
                  width: 400.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
                     ),
           ],
         ),
      ),
    );
  }
}
