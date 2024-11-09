import 'package:flutter/material.dart';
import 'package:todo_list_app/utils/color_constants.dart';
import 'package:todo_list_app/utils/image_constants.dart';
import 'package:todo_list_app/view/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then(
      (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.grey,
      body: Center(
        child: Image.asset(
          ImageConstants.logo,
          height: 150,
        ),
      ),
    );
  }
}
