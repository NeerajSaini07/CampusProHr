import 'dart:io';

import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoToSite extends StatefulWidget {
  static const routeName = "/go-to-site";
  const GoToSite({Key? key}) : super(key: key);

  @override
  _GoToSiteState createState() => _GoToSiteState();
}

class _GoToSiteState extends State<GoToSite> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Our Website"),
      body:
       WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://campuspro.in',
      ),
    );
  }
}
