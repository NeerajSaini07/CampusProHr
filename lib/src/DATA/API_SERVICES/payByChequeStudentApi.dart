// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class PayByChequeStudentApi {
  Future<bool> payByChequeStudent(
      Map<String, String> chequeData, File? _pickedImage) async {
    print("PayByChequeStudent before API: $chequeData");
    try {
      // create multipart request
      var uri = Uri.parse(ApiEndpoints.payByChequeApi);
      var request = new http.MultipartRequest("POST", uri)
        ..fields.addAll(chequeData);

      // open a bytestream
      var stream =
          new http.ByteStream(DelegatingStream.typed(_pickedImage!.openRead()));
      // get file length
      var length = await _pickedImage.length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile('image', stream, length,
          filename: _pickedImage.path.split('/').last);

      print("multipartFile ${multipartFile.filename}");

      // add file to multipart
      request.files.add(multipartFile);

      // send
      var response = await request.send();

      // var uri = Uri.parse(Api.payByChequeApi);
      // var request = http.MultipartRequest('POST', uri)
      //   ..fields.addAll(chequeData);

      // //-------------------DOCS PIC-------------------------------------
      // String docsImagePath = chequeData['ProofPath']!;
      // request.fields.remove('ProofPath');
      // if (docsImagePath != null && docsImagePath.isNotEmpty) {
      //   request.files.add(await http.MultipartFile.fromPath(
      //       'ProofPath', chequeData['ProofPath']!));
      // } else if (docsImagePath == "") {
      //   //if already image uploaded than sending blank
      //   print("SENDING BLANK cheque_image -- $docsImagePath");
      //   request.fields['ProofPath'] = docsImagePath;
      // }
      // //------------------DOCS PIC END-----------------------------------

      // var response = await request.send();

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      print("multipartFile => ${response.statusCode}");
      print("PayByChequeStudent status code -- ${response.statusCode}");

      // final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON PayByChequeStudent API: $e");
      throw "$e";
    }
  }
}
// class PayByChequeStudentApi {
//   Future<bool> payByChequeStudent(Map<String, String?> requestPayload) async {
//     print("PayByChequeStudent before API: $requestPayload");
//     try {
//       http.Response response = await http.post(
//         Uri.parse(Api.payByChequeApi),
//         body: requestPayload,
//         headers: headers,
//         encoding: encoding,
//       );

//       print("PayByChequeStudent Status Code: ${response.statusCode}");
//       print("PayByChequeStudent API Body: ${response.body}");

//       if (response.statusCode == 500) {
//         throw SOMETHING_WENT_WRONG;
//       }

//       if (response.statusCode == 204) {
//         throw NO_RECORD_FOUND;
//       }
//       final respMap = json.decode(response.body);
//       String status = respMap['Messgae'] as String;

//       if (response.statusCode == 200) {
//         if (status == "200") {
//           return true;
//         }
//       }

//       throw SOMETHING_WENT_WRONG;
//     } catch (e) {
//       print("ERROR ON PayByChequeStudent API: $e");
//       throw "$e";
//     }
//   }
// }
