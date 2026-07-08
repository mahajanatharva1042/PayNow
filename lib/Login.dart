// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paynow/BottomNavigationBar/Home.dart';
import 'package:paynow/MainPage2.dart';
import 'package:paynow/main.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  TextEditingController username=TextEditingController();
  TextEditingController pass=TextEditingController();
  final formKey=GlobalKey<FormState>();
  bool _obscureText = false; // Initial state to obscure text

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // Toggle the visibility
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child:Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue,Colors.pink],
                  begin: Alignment.topRight,
                  end:Alignment.bottomLeft
              )
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:80),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:EdgeInsets.only(top:10,bottom: 30,left: 20,right: 20),
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
                        // _pickFile();
                        debugPrint("Kuch Bhi");
                      },
                      child: Image.asset("assets/Images/PayKaro.jpg",
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),


                  ),
                ),
                SizedBox(height: 10,),
                Text("Enter Username",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                SizedBox(height: 7,),
                Container(
                    padding: EdgeInsets.only(left:10,right: 10,top:0,bottom:0),
                    margin: EdgeInsets.only(left: 20,right:20,top: 10,bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white70,
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
                        TextFormField(
                          controller: username,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please Username";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Enter Username",
                              border: InputBorder.none
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 10,),
                Text("Enter Password",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                SizedBox(height: 7,),
                Container(
                    padding: EdgeInsets.only(left:10,right: 10,top:0,bottom:0),
                    margin: EdgeInsets.only(left: 20,right:20,top: 10,bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white70,
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
                        TextFormField(
                          obscureText: true,
                          controller: pass,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please Password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Enter Password",
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: _togglePasswordVisibility,),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  if(formKey.currentState!.validate()){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                      username:username.text,
                      password:pass.text,
                    )));
                  }
                }, child: Text("LogIn",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),))
              ],
            ),
          ),
        )
      ),
    );
  }
}
