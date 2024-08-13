import 'package:bot_toast/bot_toast.dart';
import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/UTILS/NotificationService.dart';
import 'package:campus_pro/src/UI/PAGES/splashScreen.dart';
import 'package:campus_pro/src/appRouter.dart';
import 'package:campus_pro/src/globalBlocProviders.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MultiProvider(
        providers: globalBlocProviders(context),
        child: MaterialApp(
          builder: BotToastInit(),
          navigatorObservers: <NavigatorObserver>[BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'OpenSans',
            primaryColor: primaryColor,
            textTheme:
                GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme)
                    .copyWith(
              titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: accentColor),
          ),
          home: SplashScreen(),
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
