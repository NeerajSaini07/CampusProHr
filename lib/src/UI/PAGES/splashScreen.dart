import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UI/PAGES/log_in_screen.dart';
import 'package:campus_pro/src/UI/PAGES/account_type_screen.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash-screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe9e9e9),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 80.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: Image.asset('assets/images/logo_rugerp.png'),
                // child: Text("schoolImage"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Text(
                "Welcome To $schoolName",
                style: splashScreenTextStyle.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkUserLogin() async {
    final uid = await UserUtils.idFromCache();
    final loginToken = await UserUtils.loginTokenFromCache();
    print("uid $uid");
    print("loginToken $loginToken");

    Future.delayed(Duration(seconds: 3)).then((value) {
      if (uid != null && loginToken != null) {
        print("UserTypeList");
        Navigator.pushNamedAndRemoveUntil(context, AccountTypeScreen.routeName, (route) => false);
      } else {
        print("SignInPage");
        Navigator.pushNamedAndRemoveUntil(context, LogInScreen.routeName, (route) => false);
      }
    });
  }
}
