// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = "/payment-screen";
  final String? gatewayUrl;
  PaymentScreen({Key? key, this.gatewayUrl}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  WebViewController? _webController;
  bool _loadingPayment = true;
  String _responseStatus = STATUS_LOADING;

  String? pageUrl = "";

  String _loadHTML() {
    return "${widget.gatewayUrl}";
  }

  void getData() {
    _webController!.evaluateJavascript("document.body.innerText").then((data) {
      var decodedJSON = jsonDecode(data);
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
      final checksumResult = responseJSON["status"];
      final paytmResponse = responseJSON["data"];
      if (paytmResponse["STATUS"] == "TXN_SUCCESS") {
        if (checksumResult == 0) {
          _responseStatus = STATUS_SUCCESSFUL;
        } else {
          _responseStatus = STATUS_CHECKSUM_FAILED;
        }
      } else if (paytmResponse["STATUS"] == "TXN_FAILURE") {
        _responseStatus = STATUS_FAILED;
      }
      this.setState(() {});
    });
  }

  Widget getResponseScreen() {
    switch (_responseStatus) {
      case STATUS_SUCCESSFUL:
        return PaymentSuccessfulScreen();
      case STATUS_CHECKSUM_FAILED:
        return CheckSumFailedScreen();
      case STATUS_FAILED:
        return PaymentFailedScreen();
    }
    return PaymentSuccessfulScreen();
  }

  @override
  void dispose() {
    _webController = null;
    super.dispose();
  }

  static _showAlert(BuildContext context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text("Are you sure to cancel payment?"),
                // content: Text(message1),
                actions: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(2.0),
                          // backgroundColor: Colors.blue[900]
                          ),
                      child: Text(
                        'no',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // RaisedButton(
                    //   padding: EdgeInsets.all(2.0),
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    //   color: Colors.red[900],
                    //   child: Text(
                    //     'no',
                    //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                    //   ),
                    // ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(12.0),
                          // backgroundColor: Colors.blue[900]
                          ),
                      child: Text(
                        'yes',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    // RaisedButton(
                    //   padding: EdgeInsets.all(12.0),
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //     Navigator.pop(context);
                    //   },
                    //   color: Colors.blue[900],
                    //   child: Text(
                    //     'yes',
                    //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                    //   ),
                    // ),
                  ),
                ],
              )
            : new AlertDialog(
                title: Text("Are you sure to cancel payment?"),
                // content: Container(
                //     height: 140.0,
                //     width: 400.0,
                //     child: ListView.builder(
                //         shrinkWrap: true,
                //         itemCount: 1,
                //         itemBuilder: (BuildContext context, int index) {
                //           return new Column(children: <Widget>[
                //             Text(message1),
                //           ]);
                //         })),
                actions: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(2.0),
                          // backgroundColor: Colors.blue[900]
                          ),
                      child: Text(
                        'no',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // RaisedButton(
                    //   padding: EdgeInsets.all(2.0),
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    //   color: Colors.red[900],
                    //   child: Text(
                    //     'no',
                    //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                    //   ),
                    // ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(2.0),
                          // backgroundColor: Colors.blue[900]
                          ),
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    //  RaisedButton(
                    //   padding: EdgeInsets.all(2.0),
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //     Navigator.pop(context);
                    //   },
                    //   color: Colors.blue[900],
                    //   child: Text(
                    //     'yes',
                    //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                    //   ),
                    // ),
                  ),
                ],
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: commonAppBar(
        //   context,
        //   title: "",
        //   automaticallyImplyLeading: false,
        //   leadingIcon: InkWell(
        //     onTap: () => _showAlert(context),
        //     child: Icon(Icons.arrow_back),
        //   ),
        // ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Secure Payment",
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
          leading: InkWell(
            onTap: () => _showAlert(context),
            child: Icon(Icons.arrow_back),
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
                // initialUrl: "https://app.campuspro.in/LoginAccounts.aspx",
                onWebViewCreated: (controller) {
                  _webController = controller;
                  // _webController!
                  //     .loadUrl(new Uri.dataFromString("https://app.campuspro.in/LoginAccounts.aspx").toString());
                  _webController!.loadUrl(
                      new Uri.dataFromString(_loadHTML(), mimeType: 'text/html')
                          .toString());
                },
                onPageFinished: (page) {
                  print("page : $page");
                  setState(() {
                    pageUrl = page;
                  });
                  if (page.contains("/transaction")) {
                    if (_loadingPayment) {
                      this.setState(() {
                        _loadingPayment = false;
                      });
                    }
                  }
                  if (page.contains("/paymentresponse")) {
                    // getData();
                    Future.delayed(Duration(seconds: 5))
                        .then((value) => Navigator.pop(context, true));
                  }
                },
              ),
            ),
            // (_loadingPayment)
            //     ? Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     : Center(),
            (_responseStatus != STATUS_LOADING)
                ? Center(child: getResponseScreen())
                : Center()
          ],
        ));
  }
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
