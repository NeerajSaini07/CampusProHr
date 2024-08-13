import 'dart:io';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUBizzHashModel.dart';
import 'package:campus_pro/src/UI/WIDGETS/PAYMENT_GATEWAY/payUBiz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/PAY_U_BIZ_HASH_CUBIT/pay_u_biz_hash_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/gatewayTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/feePaymentStudent.dart';
import 'package:campus_pro/src/UI/WIDGETS/PAYMENT_GATEWAY/airPay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentGatewayMethods {
  PaymentGatewayMethods._();

  static sendPayUBizData(BuildContext context,
      {List<PayUBizHashModel>? payUBizData,
      List<GatewayTypeModel>? gatewayData,
      String? amount}) {
    String? transactionId = generateTransactionId('PayUBiz');

    PayUBizRequest user = PayUBizRequest(
      hash: payUBizData![0].mainHash,
      txnId: transactionId,
      key: gatewayData![0].param2,
      amount: amount,
      firstName: 'MITHUN',
      email: gatewayData[0].param4,
      phone: '9876543210',
      productInfo: 'SchoolFee',
      surl: 'https://app.campuspro.in/student/paymentresponse.aspx',
      furl: 'https://app.campuspro.in/student/paymentresponse.aspx',
      udf1: '2873', //StuEmpId
      udf2: '1', //Schoolid
      udf3: '9998', //OrgId
      udf4: '2', //TillMonthId
      udf5: '3276', //AdmNo
    );

    // String errMsg = "";
    // if (user.secret!.isEmpty) {
    //   errMsg = 'Enter your AirPay Secret Key in kAirPaySecretKey';
    // } else if (user.merchantId!.isEmpty) {
    //   errMsg = 'Enter your AirPay MerchantID';
    // } else if (user.password!.isEmpty) {
    //   errMsg = 'Enter your AirPay password';
    // } else if (user.username!.isEmpty) {
    //   errMsg = 'Enter your AirPay Username';
    // } else if (user.successUrl!.isEmpty) {
    //   errMsg = 'Enter your AirPay successUrl';
    // } else if (user.protoDomain!.isEmpty) {
    //   errMsg = 'Enter your AirPay protoDomain';
    // }
    // if (errMsg.isNotEmpty) {
    //   _showAlert(
    //       context,
    //       errMsg +
    //           '\n to proceed with the demo app you must enter the required details to proceed.');
    //   return;
    // }

    print('user Data sending : $user');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => new PayUBiz(
            user: user,
            closure: (status, response) =>
                {onComplete(context, status, response)}),
      ),
    );
  }

  static sendAirPayData(BuildContext context,
      {List<GatewayTypeModel>? gatewayData,
      String? amount,
      StudentInfoModel? stuInfo}) async {
    String? transactionId = generateTransactionId('AirPay');

    //TODO- Enter here Real URL (API Response)
    String domainPath = 'https://app.campuspro.in/';

    String kAirPayUserName = '5926256';

    String kAirPayPassword = 'me65Pf2K';

    String kAirPaySecretKey = 'A3brM5V9wjMWZh29';

    String merchantID = '40594';

    String userEmail = 'email@gmail.com';

    // String kAirPayUserName = gatewayData![0].param1!;

    // String kAirPayPassword = gatewayData[0].param2!;

    // String kAirPaySecretKey = gatewayData[0].param3!;

    // String merchantID = gatewayData[0].param4!;

    // String userEmail = gatewayData[0].param5!;

    String successURL = 'https://app.campuspro.in/student/paymentresponse.aspx';

    final stuInfo = await UserUtils.stuInfoDataFromCache();

    AirPayRequest user = AirPayRequest(
        username: kAirPayUserName,
        password: kAirPayPassword,
        secret: kAirPaySecretKey,
        merchantId: merchantID,
        protoDomain: domainPath,
        fname: stuInfo!.stName,
        lname: '',
        email: userEmail,
        phone: stuInfo.mobile,
        fulladdress: '811, Unitech arcadia',
        pincode: '122018',
        orderid: transactionId.toString(),
        amount: amount,
        city: 'Gurugram',
        state: 'Haryana',
        country: 'India',
        currency: "356",
        isCurrency: "INR",
        chMode: "",
        customVar: "",
        txnSubtype: "",
        wallet: "0",
        isStaging: false, //True for the Staging
        successUrl: successURL);

    String errMsg = "";
    if (user.secret!.isEmpty) {
      errMsg = 'Enter your AirPay Secret Key in kAirPaySecretKey';
    } else if (user.merchantId!.isEmpty) {
      errMsg = 'Enter your AirPay MerchantID';
    } else if (user.password!.isEmpty) {
      errMsg = 'Enter your AirPay password';
    } else if (user.username!.isEmpty) {
      errMsg = 'Enter your AirPay Username';
    } else if (user.successUrl!.isEmpty) {
      errMsg = 'Enter your AirPay successUrl';
    } else if (user.protoDomain!.isEmpty) {
      errMsg = 'Enter your AirPay protoDomain';
    }
    if (errMsg.isNotEmpty) {
      _showAlert(
          context,
          errMsg +
              '\n to proceed with the demo app you must enter the required details to proceed.');
      return;
    }

    print('user Data sending : $user');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => new AirPay(
            user: user,
            closure: (status, response) =>
                {onComplete(context, status, response)}),
      ),
    );
  }

  static onComplete(BuildContext context, status, response) {
    Navigator.pop(context);
    if (status == true) {
      if (response == 'success') {
        _showAlert(context, "Your payment is successfull");
      } else {
        _showAlert(context, "Sorry! Your payment is failed.");
      }
    } else {
      _showAlert(context, "This payment is failed");
    }

    // _showAlert(context, '${response.toJson()}');
  }

  static _showAlert(context, message) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "Airpay";
        String message1 = message;
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message1),
                actions: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(12.0),
                        // backgroundColor: Colors.blue[900]
                      ),
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // RaisedButton(
                    //   padding: EdgeInsets.all(12.0),
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    //   color: Colors.blue[900],
                    //   child: Text(
                    //     'Okay',
                    //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                    //   ),
                    // ),
                  )
                ],
              )
            : new AlertDialog(
                title: Text(title),
                content: Container(
                    height: 140.0,
                    width: 400.0,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return new Column(children: <Widget>[
                            Text(message1),
                          ]);
                        })),
                actions: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(2.0),
                        // backgroundColor: Colors.blue[900]
                      ),
                      child: Text(
                        'Okay',
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
                    //     'Okay',
                    //     style: TextStyle(color: Colors.white, fontSize: 24.0),
                    //   ),
                    // ),
                  )
                ],
              );
      },
    );
  }

  static String? generateTransactionId(String gateway) {
    String? txnId = '';
    switch (gateway) {
      case 'PayUBiz':
        txnId = "WEBPayUBiz" +
            "${DateFormat("yyyyMMddHHmmssffff").format(DateTime.now())}";
        return txnId;
      case 'AirPay':
        txnId = "${DateFormat("yyyyMMddHHmmssffff").format(DateTime.now())}";
        return txnId;
      default:
        return 'none';
    }
  }
}
