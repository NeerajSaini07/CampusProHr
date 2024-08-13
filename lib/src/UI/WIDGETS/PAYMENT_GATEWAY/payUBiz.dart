import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:xml2json/xml2json.dart';

typedef void Closure(bool val, String response);

class Transaction {
  String? sTATUS;
  String? tXNMODE;
  String? tXNDATETIME;
  String? tXNCURRENCYCODE;
  String? tRANSACTIONID;
  String? tRANSACTIONAMT;
  String? tRANSACTIONSTATUS;
  String? sTATUSMSG;
  String? tRANSACTIONVARIANT;
  String? mERCHANTTRANSACTIONID;
  String? mERCHANTKEY;
  String? cUSTOMVAR;
  String? aPSECUREHASH;
  String? cHMOD;
  String? fULLNAME;
  String? eMAIL;
  String? cONTACTNO;
  String? iSRISK;
  String? bANKNAME;
  CARDDETAILS? cARDDETAILS;
  String? eMIDETAILS;
  String? mERCHANTNAME;
  String? sETTLEMENTDATE;
  String? sURCHARGE;
  String? bILLEDAMOUNT;
  String? rRN;
  String? tRANSACTIONREASON;

  Transaction(
      {this.sTATUS,
      this.tXNMODE,
      this.tXNDATETIME,
      this.tXNCURRENCYCODE,
      this.tRANSACTIONID,
      this.tRANSACTIONAMT,
      this.tRANSACTIONSTATUS,
      this.sTATUSMSG,
      this.tRANSACTIONVARIANT,
      this.mERCHANTTRANSACTIONID,
      this.mERCHANTKEY,
      this.cUSTOMVAR,
      this.aPSECUREHASH,
      this.cHMOD,
      this.fULLNAME,
      this.eMAIL,
      this.cONTACTNO,
      this.iSRISK,
      this.bANKNAME,
      this.cARDDETAILS,
      this.eMIDETAILS,
      this.mERCHANTNAME,
      this.sETTLEMENTDATE,
      this.sURCHARGE,
      this.bILLEDAMOUNT,
      this.rRN,
      this.tRANSACTIONREASON});

  Transaction.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    tXNMODE = json['TXN_MODE'];
    tXNDATETIME = json['TXN_DATE_TIME'];
    tXNCURRENCYCODE = json['TXN_CURRENCY_CODE'];
    tRANSACTIONID = json['TRANSACTIONID'];
    tRANSACTIONAMT = json['TRANSACTIONAMT'];
    tRANSACTIONSTATUS = json['TRANSACTIONSTATUS'];
    sTATUSMSG = json['STATUSMSG'];
    if (json['TRANSACTIONVARIANT'] != null) {
      tRANSACTIONVARIANT = json['TRANSACTIONVARIANT'];
    }
    mERCHANTTRANSACTIONID = json['MERCHANTTRANSACTIONID'];
    mERCHANTKEY = json['MERCHANTKEY'];
    if (json['CUSTOMVAR'] != null) {
      cUSTOMVAR = json['CUSTOMVAR'];
    }
    aPSECUREHASH = json['AP_SECUREHASH'];
    cHMOD = json['CHMOD'];
    fULLNAME = json['FULLNAME'];
    eMAIL = json['EMAIL'];
    cONTACTNO = json['CONTACTNO'];
    iSRISK = json['ISRISK'];
    bANKNAME = json['BANKNAME'];
    cARDDETAILS = json['CARD_DETAILS'] != null
        ? new CARDDETAILS.fromJson(json['CARD_DETAILS'])
        : null;
    if (json['EMI_DETAILS'] != null && json['EMI_DETAILS'] is String) {
      eMIDETAILS = json['EMI_DETAILS'];
    }
    mERCHANTNAME = json['MERCHANT_NAME'];
    if (json['SETTLEMENT_DATE'] != null) {
      sETTLEMENTDATE = json['SETTLEMENT_DATE'];
    }
    sURCHARGE = json['SURCHARGE'];
    bILLEDAMOUNT = json['BILLEDAMOUNT'];
    rRN = json['RRN'];
    tRANSACTIONREASON = json['TRANSACTIONREASON'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = this.sTATUS;
    data['TXN_MODE'] = this.tXNMODE;
    data['TXN_DATE_TIME'] = this.tXNDATETIME;
    data['TXN_CURRENCY_CODE'] = this.tXNCURRENCYCODE;
    data['TRANSACTIONID'] = this.tRANSACTIONID;
    data['TRANSACTIONAMT'] = this.tRANSACTIONAMT;
    data['TRANSACTIONSTATUS'] = this.tRANSACTIONSTATUS;
    data['STATUSMSG'] = this.sTATUSMSG;
    if (this.tRANSACTIONVARIANT != null) {
      data['TRANSACTIONVARIANT'] = this.tRANSACTIONVARIANT;
    }
    data['MERCHANTTRANSACTIONID'] = this.mERCHANTTRANSACTIONID;
    data['MERCHANTKEY'] = this.mERCHANTKEY;
    if (this.cUSTOMVAR != null) {
      data['CUSTOMVAR'] = this.cUSTOMVAR;
    }
    data['AP_SECUREHASH'] = this.aPSECUREHASH;
    data['CHMOD'] = this.cHMOD;
    data['FULLNAME'] = this.fULLNAME;
    data['EMAIL'] = this.eMAIL;
    data['CONTACTNO'] = this.cONTACTNO;
    data['ISRISK'] = this.iSRISK;
    data['BANKNAME'] = this.bANKNAME;
    if (this.cARDDETAILS != null) {
      data['CARD_DETAILS'] = this.cARDDETAILS!.toJson();
    }
    if (this.eMIDETAILS != null) {
      data['EMI_DETAILS'] = this.eMIDETAILS;
    }
    data['MERCHANT_NAME'] = this.mERCHANTNAME;
    if (this.sETTLEMENTDATE != null) {
      data['SETTLEMENT_DATE'] = this.sETTLEMENTDATE;
    }
    data['SURCHARGE'] = this.sURCHARGE;
    data['BILLEDAMOUNT'] = this.bILLEDAMOUNT;
    data['RRN'] = this.rRN;
    data['TRANSACTIONREASON'] = this.tRANSACTIONREASON;
    return data;
  }
}

class CARDDETAILS {
  String? pRIACCNOSTART;
  String? pRIACCNOEND;
  String? cARDISSUER;
  String? cARDTYPE;
  String? cARDCOUNTRY;

  CARDDETAILS(
      {this.pRIACCNOSTART,
      this.pRIACCNOEND,
      this.cARDISSUER,
      this.cARDTYPE,
      this.cARDCOUNTRY});

  CARDDETAILS.fromJson(Map<String, dynamic> json) {
    pRIACCNOSTART = json['PRI_ACC_NO_START'];
    pRIACCNOEND = json['PRI_ACC_NO_END'];
    cARDISSUER = json['CARDISSUER'];
    cARDTYPE = json['CARDTYPE'];
    cARDCOUNTRY = json['CARDCOUNTRY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PRI_ACC_NO_START'] = this.pRIACCNOSTART;
    data['PRI_ACC_NO_END'] = this.pRIACCNOEND;
    data['CARDISSUER'] = this.cARDISSUER;
    data['CARDTYPE'] = this.cARDTYPE;
    data['CARDCOUNTRY'] = this.cARDCOUNTRY;
    return data;
  }
}

class PayUBizRequest {
  String? hash;
  String? txnId;
  String? key;
  String? amount;
  String? firstName;
  String? email;
  String? phone;
  String? productInfo;
  String? surl;
  String? furl;
  String? udf1;
  String? udf2;
  String? udf3;
  String? udf4;
  String? udf5;
  PayUBizRequest({
    this.hash,
    this.txnId,
    this.key,
    this.amount,
    this.firstName,
    this.email,
    this.phone,
    this.productInfo,
    this.surl,
    this.furl,
    this.udf1,
    this.udf2,
    this.udf3,
    this.udf4,
    this.udf5,
  });

  @override
  String toString() {
    return 'amount $amount';
  }
}

class PayUBiz extends StatefulWidget {
  final PayUBizRequest? user;
  final Closure? closure;

  PayUBiz({Key? key, @required this.user, this.closure}) : super(key: key);
  @override
  _PayUBizState createState() => new _PayUBizState();
}

class _PayUBizState extends State<PayUBiz> {
  // var URL = 'https://google.com.tr';
  String url = "";
  double progress = 0;
  var postdata = "";
  bool isShow = true;

  @override
  void initState() {
    print('Entered in PayUBiz Class');
    super.initState();
  }

  grabUrl(String changedUrl) async {
    // if (changedUrl.contains(Api.successUrl)) {
    //   print("Case hit Success");
    //   await Future.delayed(Duration(seconds: 1));
    //   Navigator.pop(context, changedUrl);
    // } else if (changedUrl.contains(Api.failureUrl)) {
    //   print("Case hit Failure");
    //   setPaymentUiStatus(UiPaymentStatus.PaymentFail);
    //   await Future.delayed(Duration(seconds: 1));
    //   Navigator.pop(context, changedUrl);
    // }
    return;
  }

  String loadData() {
    var date = new DateTime.now();
    var format = DateFormat("yyyy-MM-dd");
    var formattedDate = format.format(date);
    // var temp = utf8.encode(
    //     '${widget.user!.secret}@${widget.user!.username}:|:${widget.user!.password}');
    // var privatekey = sha256.convert(temp);
    // var setAllData = utf8.encode(
    //     '${widget.user!.email}${widget.user!.fname}${widget.user!.lname}${widget.user!.fulladdress}${widget.user!.city}${widget.user!.state}${widget.user!.country}${widget.user!.amount}${widget.user!.orderid}$formattedDate$privatekey');
    // var checksum = md5.convert(setAllData);
    // var protocolDomain = getProtoDomain(widget.user!.protoDomain!);
    // List<int> bytes = ascii.encode(protocolDomain);
    // var encoded = base64.encode(bytes);
    var user = widget.user;

    String productionURL = "https://payments.PayUBiz.co.in/pay/index.php";
    String productionFailedURL = "https://payments.PayUBiz.co.in/error.php";
    // String productionVPAURL = "https://payments.PayUBiz.co.in/upi/v.php";
    String stagingURL = "https://payments.PayUBiz.ninja/pay/index.php";
    String stagingFailedURL = "https://payments.PayUBiz.ninja/error.php";
    // String stagingVPAURL = "https://payments.PayUBiz.ninja/upi/v.php";

    // var isGateWay = (user!.isStaging != null && user.isStaging == true)
    //     ? stagingURL
    //     : productionURL;
    // user.failedUrl = (user.isStaging != null && user.isStaging == true)
    //     ? stagingFailedURL
    //     : productionFailedURL;

    var url = "<!DOCTYPE html>" +
        "<html>" +
        "<body onload='document.PostForm.submit()'>" +
        "<form action='https://secure.payu.in/_payment' method='post' name='PostForm'>" +
        "  <input type='hidden' name='hash' value='${user!.hash}'><br>" +
        "  <input type='hidden' name='txnid' value='${user.txnId}'><br>" +
        "  <input type='hidden' name='key' value='${user.key}'><br>" +
        "  <input type='hidden' name='amount' value='${user.amount}'><br>" +
        "  <input type='hidden' name='firstname' value='${user.firstName}'><br>" +
        "  <input type='hidden' name='email' value='${user.email}><br>" +
        "  <input type='hidden' name='phone' value='${user.phone}'><br>" +
        "  <input type='hidden' name='productinfo' value='${user.productInfo}'><br>" +
        "  <input type='hidden' name='surl' value='${user.surl}'><br>" +
        "  <input type='hidden' name='furl' value='${user.furl}'><br>" +
        "  <input type='hidden' name='udf1' value='${user.udf1}'><br>" +
        "  <input type='hidden' name='udf2' value='${user.udf2}'><br>" +
        "  <input type='hidden' name='udf3' value='${user.udf3}'><br>" +
        "  <input type='hidden' name='udf4' value='${user.udf4}'><br>" +
        "  <input type='hidden' name='udf5' value='${user.udf5}'><br>" +
        "</form>" +
        "</body>" +
        "</html>";
    return url;
  }

  String getProtoDomain(String sDomain) {
    int slashslash = sDomain.indexOf("//") + 2;
    return sDomain.substring(0, sDomain.indexOf("/", slashslash));
  }

  userCancel(String withMessage) {
    // var trans = Transaction();
    // trans.sTATUS = '500';
    // trans.tRANSACTIONREASON = withMessage;
    widget.closure!(false, 'failed');
  }

  _showConfirmation(context, message) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "PayUBiz";
        String message1 = message;
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message1),
                actions: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(8.0),
                          // backgroundColor: Colors.blue[900]
                          ),
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        userCancel('User canceled');
                      },
                    ),
                    // RaisedButton(
                    //   padding: EdgeInsets.all(8.0),
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //     userCancel('User canceled');
                    //   },
                    //   color: Colors.blue[900],
                    //   child: Text(
                    //     'Yes',
                    //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                    //   ),
                    // ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(8.0),
                          // backgroundColor: Colors.blue[900]
                          ),
                      child: Text(
                        'No',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // RaisedButton(
                    //   padding: EdgeInsets.all(8.0),
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    //   color: Colors.blue[900],
                    //   child: Text(
                    //     'No',
                    //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                    //   ),
                    // ),
                  )
                ],
              )
            : new AlertDialog(
                title: Text(title),
                content: Text(message1),
                actions: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(0),
                    child:ElevatedButton(
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
                        userCancel('User canceled');
                      },
                    ),
                    //  RaisedButton(
                    //   padding: EdgeInsets.all(2.0),
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //     userCancel('User canceled');
                    //   },
                    //   color: Colors.blue[900],
                    //   child: Text(
                    //     'Yes',
                    //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                    //   ),
                    // ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(2.0),
                          // backgroundColor: Colors.blue[900
                          ),
                      child: Text(
                        'No',
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
                    //   color: Colors.blue[900],
                    //   child: Text(
                    //     'No',
                    //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                    //   ),
                    // ),
                  ),
                ],
              );
      },
    );
  }

  // InAppWebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // title: Image.asset(
          //   AppImages.PayUBizIcon,
          //   height: 40,
          //   color: Colors.white,
          //   width: 200,
          // ),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => {
              _showConfirmation(
                  context, "Did you want to cancel this transaction ?")
            },
          ),
          backgroundColor: Colors.blue[900],
          actions: <Widget>[],
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                // padding: EdgeInsets.all(10.0),
                child: progress < 1.0
                    ? SpinKitCircle(
                        color: Colors.blue[900]!,
                        size: 50.0,
                      )
                    : Container(),
              ),
              if (isShow)
                Expanded(
                  child: InAppWebView(
                    //initialUrl: URL,
                    initialData: InAppWebViewInitialData(
                      data: loadData(),
                    ),
                    // initialHeaders: {},
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        // debuggingEnabled: true,
                        useShouldOverrideUrlLoading: true,
                      ),
                      android: AndroidInAppWebViewOptions(
                          // useOnRenderProcessGone: true,
                          // useHybridComposition: true,
                          ),
                    ),
                    onTitleChanged: (controller, url) {
                      setState(() {
                        print("onTitleChanged : $url");
                      });
                    },
                    onWebViewCreated: (InAppWebViewController controller) {},
                    // onLoadStart: (InAppWebViewController controller, Uri? url) {
                    // fetchDetails();
                    // },
                    // onLoadStart: (InAppWebViewController controller, Uri? url) {
                    //   setState(() {
                    //     print("onLoadStart : $url");
                    //     var succesPath =
                    //         getProtoDomain(widget.user!.successUrl!);
                    //     var webURLPath = getProtoDomain(url.toString());
                    //     // var webURLPath = getProtoDomain(
                    //     //     'https://app.campuspro.in/student/paymentresponse.aspx');
                    //     if (succesPath.contains("http://") &&
                    //         webURLPath.contains("https://")) {
                    //       webURLPath =
                    //           webURLPath.replaceAll("https://", "http://");
                    //     } else if (succesPath.contains("https://") &&
                    //         webURLPath.contains("http://")) {
                    //       webURLPath =
                    //           webURLPath.replaceAll("http://", "https://");
                    //     }

                    //     if (succesPath == webURLPath) {
                    //       isShow = false;
                    //       // fetchDetails();
                    //       print("onLoadStart : Success");
                    //       widget.closure!(true, 'success');
                    //     } else if (widget.user!.failedUrl == webURLPath) {
                    //       userCancel('Transaction failed');
                    //       print("onLoadStart : Failed");
                    //       widget.closure!(false, 'failed');
                    //     }
                    //   });
                    // },
                    // onLoadStop: (controller, url) async {
                    //   String ht = await controller.evaluateJavascript(
                    //       source:
                    //           "javascript:window.droid.print(document.getElementsByClassName('alert')[0].innerHTML);");

                    //   setState(() {
                    //     this.url = '$url';
                    //     var failurePath = widget.user!
                    //         .failedUrl; //getProtoDomain(widget.user.failedUrl);

                    //     if ('$url'.startsWith(failurePath!)) {
                    //       setState(() {
                    //         // controller.loadUrl(url: ht);
                    //         // print('ht: $url');
                    //         userCancel('Transaction failed');
                    //         print('onLoad Stop in - $url');
                    //       });
                    //     } else {
                    //       print('on Load Stop: not error URL: $url');
                    //     }
                    //   });
                    // },
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                )
              else
                Container(),
            ],
          ),
        ),
      ),
    );
  }
}
