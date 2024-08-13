import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GooglePermission extends StatefulWidget {
  static const routeName = "/google-permission";
  final String? gatewayUrl;
  GooglePermission({Key? key, this.gatewayUrl}) : super(key: key);

  @override
  _GooglePermissionState createState() => _GooglePermissionState();
}

class _GooglePermissionState extends State<GooglePermission> {
  WebViewController? _webController;

  String? pageUrl = "";

  @override
  void initState() {
    print(widget.gatewayUrl);
    super.initState();
  }

  @override
  void dispose() {
    _webController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Google Permission",
                textScaleFactor: 1.5,
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                pageUrl!,
                textScaleFactor: 1.5,
                style: GoogleFonts.quicksand(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          leadingWidth: 40.0,
          leading: InkResponse(
            onTap: () => Navigator.pop(context),
            // onTap: () => _showAlert(context),
            child: Icon(Icons.close),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: WebView(
                debuggingEnabled: false,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: widget.gatewayUrl,
                userAgent: Platform.isIOS
                    ? 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_2 like Mac OS X) AppleWebKit/605.1.15' +
                        ' (KHTML, like Gecko) Version/13.0.1 Mobile/15E148 Safari/604.1'
                    : 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) ' +
                        'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',
                onWebViewCreated: (controller) {
                  _webController = controller;
                  // _webController!.loadUrl(
                  //     new Uri.dataFromString(widget.gatewayUrl!).toString());
                  // _webController!.loadUrl(
                  //     new Uri.dataFromString(_loadHTML(), mimeType: 'text/html')
                  //         .toString());
                },
                onPageFinished: (page) {
                  print("page $page");
                  setState(() {
                    pageUrl = page;
                  });
                  if (page.contains("/localhost:")) {
                    Navigator.pop(context, "Bingo!");
                  }
                },
              ),
            ),
            // (_loadingPayment)
            //     ? Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     : Center(),
            // (_responseStatus != STATUS_LOADING)
            //     ? Center(child: getResponseScreen())
            //     : Center()
          ],
        ));
  }

//   void readJS() async {
//     String html = await _webController!.evaluateJavascript(
//         "window.document.getElementsByTagName('html')[0].outerHTML;");
//     print("html : $html");
//   }
}

class PaymentSuccessfulScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Great!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Thank you making the payment!",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "OOPS!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Payment was not successful, Please try again Later!",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class CheckSumFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Oh Snap!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Problem Verifying Payment, If you balance is deducted please contact our customer support and get your payment verified!",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
