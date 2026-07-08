import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paynow/main.dart';
import 'package:paynow/Login.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const LogIn()));
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue,Colors.pink],
              begin: Alignment.topRight,
              end:Alignment.bottomLeft
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset("assets/Images/PayKaro.jpg",
                  width: 360.0,
                  // height:150.0,
                  // fit: BoxFit.cover,
                ),
              )
            ],
          ),
        )
    );
  }
}
