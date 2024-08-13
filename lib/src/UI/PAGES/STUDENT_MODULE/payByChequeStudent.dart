import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/PAY_BY_CHEQUE_STUDENT_CUBIT/pay_by_cheque_student_cubit.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../DATA/API_SERVICES/payByChequeStudentApi.dart';
import '../../../DATA/REPOSITORIES/payByChequeStudentRepository.dart';
import '../../../UTILS/fieldValidators.dart';

class PayByChequeStudent extends StatefulWidget {
  static const routeName = "/pay_by_cheque-student";
  final Map<String, String>? feeData;

  const PayByChequeStudent({Key? key, this.feeData}) : super(key: key);
  @override
  _PayByChequeStudentState createState() => _PayByChequeStudentState();
}

class _PayByChequeStudentState extends State<PayByChequeStudent> {
  TextEditingController chequeNoController = TextEditingController();
  TextEditingController bankDetailController = TextEditingController();
  TextEditingController depositedBankController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  bool showLoader = false;

  final _feeFormKey = GlobalKey<FormState>();

  File? _pickedImage;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: "SELECT DATE",
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<File?> getImage({ImageSource source = ImageSource.gallery}) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      print('Wow! Image selected.');
      final image = File(pickedFile.path);
      return image;
    } else {
      print('Ops! No Image selected.');
    }

    // setState(() {
    //   if (pickedFile != null) {
    //     _pickedImage = File(pickedFile.path);
    //     print('Wow! Image selected.');
    //   } else {
    //     print('Ops! No Image selected.');
    //   }
    // });
  }

  showUploadSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Upload via",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 60),
              child: Row(
                children: [
                  buildUploadOption(
                    context,
                    icon: Icons.camera_alt,
                    title: "Camera",
                    onTap: () async {
                      File? tempFile =
                          await getImage(source: ImageSource.camera);
                      if (mounted && tempFile != null) {
                        setState(() {
                          _pickedImage = tempFile;
                        });
                      }
                    },
                    // onTap: () => getImage(source: ImageSource.camera),
                  ),
                  buildUploadOption(
                    context,
                    icon: Icons.photo_library,
                    title: "Gallery",
                    onTap: () async {
                      File? tempFile =
                          await getImage(source: ImageSource.gallery);
                      if (mounted && tempFile != null) {
                        setState(() {
                          _pickedImage = tempFile;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Expanded buildUploadOption(BuildContext context,
      {IconData? icon, String? title, void Function()? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 28),
            Text(
              title.toString(),
              textScaleFactor: 1.0,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    chequeNoController.dispose();
    bankDetailController.dispose();
    depositedBankController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(context, title: "Pay By Cheque"),
        body: BlocProvider<PayByChequeStudentCubit>(
          create: (_) => PayByChequeStudentCubit(
              PayByChequeStudentRepository(PayByChequeStudentApi())),
          child: MultiBlocListener(
            listeners: [
              BlocListener<PayByChequeStudentCubit, PayByChequeStudentState>(
                listener: (context, state) {
                  if (state is PayByChequeStudentLoadSuccess) {
                    setState(() {
                      showLoader = !showLoader;
                      _pickedImage = null;
                      chequeNoController.clear();
                      bankDetailController.clear();
                      depositedBankController.clear();
                      amountController.clear();
                    });
                    toast('Cheque Deposited!');
                  }
                  if (state is PayByChequeStudentLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    } else {
                      setState(() {
                        showLoader = !showLoader;
                      });
                      toast(state.failReason);
                    }
                  }
                },
              ),
            ],
            child: Form(
              key: _feeFormKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTextFields(
                              label: "Cheque No / Transaction No",
                              controller: chequeNoController,
                              validator: FieldValidators.chequeNoValidator,
                              maxLength: 9,
                            ),
                            // buildTextFields(
                            //   label: "Cheque Date / Transaction Date",
                            //   controller: dateController,
                            //   validator: FieldValidators.globalValidator,
                            // ),
                            buildDateWidget(),
                            buildTextFields(
                              label: "Bank Details",
                              controller: bankDetailController,
                              validator: FieldValidators.globalValidator,
                            ),
                            buildTextFields(
                              label: "Deposited in Bank",
                              controller: depositedBankController,
                              validator: FieldValidators.globalValidator,
                            ),
                            buildTextFields(
                              label: "Amount",
                              controller: amountController,
                              validator: FieldValidators.globalValidator,
                              keyboardType: TextInputType.number,
                            ),
                            buildImageUpload(context),
                            if (showLoader)
                              Center(child: CircularProgressIndicator())
                            else
                              buildSignUpBtn(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Padding buildDateWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabels("Cheque Date / Transaction Date"),
          buildDateSelector(
            selectedDate: DateFormat("dd MMM yyyy").format(selectedDate),
          ),
        ],
      ),
    );
  }

  Container buildSignUpBtn() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10.0),
        // gradient: LinearGradient(
        //     begin: Alignment.centerLeft,
        //     end: Alignment.centerRight,
        //     colors: [accentColor, primaryColor]),
      ),
      child: TextButton(
        onPressed: () async {
          if (_feeFormKey.currentState!.validate()) {
            print("Form is Validated");
            setState(() => showLoader = !showLoader);

            final uid = await UserUtils.idFromCache();
            final token = await UserUtils.userTokenFromCache();
            final userData = await UserUtils.userTypeFromCache();
            final chequeData = {
              'OUserId': uid!,
              'Token': token!,
              'OrgId': userData!.organizationId!,
              'Schoolid': userData.schoolId!,
              'SessionId': userData.currentSessionid!,
              'StudentId': userData.stuEmpId!,
              'transdate': selectedDate.toString(),
              // 'transdate': DateFormat("dd MMM yyyy").format(selectedDate),
              'feecatid': widget.feeData!['feecatid']!,
              'tillmonth': widget.feeData!['tillmonth']!,
              'AmountDeposit': amountController.text,
              'PayMode': 'm',
              'chqTxNo': chequeNoController.text,
              'chqTxDate': selectedDate.toString(),
              'BankName': bankDetailController.text,
              'DepBankName': depositedBankController.text
              // 'ProofPath': 'p', //doubt
            };

            // if (_pickedImage != null) {
            //   chequeData['ProofPath'] = _pickedImage!.path;
            // }
            print("Sending Pay by Cheque Data => $chequeData");
            context
                .read<PayByChequeStudentCubit>()
                .payByChequeStudentCubitCall(chequeData, _pickedImage);
          }
        },
        child: Text(
          "SAVE DETAILS",
          style:
              TextStyle(fontFamily: "BebasNeue-Regular", color: Colors.white),
        ),
      ),
    );
  }

  Padding buildImageUpload(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabels("Deposite Proof:"),
          Center(
            child: GestureDetector(
              onTap: () => showUploadSheet(),
              child: Container(
                height: 120,
                width: 120,
                decoration: new BoxDecoration(
                  color: Color(0xffFAFAFA),
                  border: Border.all(
                      width: 1,
                      style: BorderStyle.solid,
                      color: Color(0xffECECEC)),
                ),
                child: _pickedImage != null
                    ? GestureDetector(
                        onTap: () => showUploadSheet(),
                        child: Stack(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              child:
                                  Image.file(_pickedImage!, fit: BoxFit.cover),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 30,
                                width: 150,
                                color: Colors.black54,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                alignment: Alignment.center,
                                child: FittedBox(
                                    child: Text(
                                  "Change",
                                  style: TextStyle(color: Colors.white70),
                                )),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_file,
                              color: accentColor, size: 28),
                          FittedBox(
                            child: Text(
                              "Upload",
                              // textScaleFactor: 1.0,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildTextFields(
      {String? label,
      int? maxLength,
      TextEditingController? controller,
      TextInputType? keyboardType,
      String? Function(String?)? validator}) {
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabels(label ?? ""),
          buildTextField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType ?? null,
            maxLength: maxLength ?? null,
          ),
        ],
      ),
    );
  }

  Padding buildLabels(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(
          // color: Theme.of(context).primaryColor,
          color: Color(0xff313131),
        ),
      ),
    );
  }

  InkWell buildDateSelector({String? selectedDate}) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // width: MediaQuery.of(context).size.width / 4,
              child: Text(
                selectedDate!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Icon(Icons.today, color: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }

  Container buildTextField({
    int? maxLength,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    @required TextEditingController? controller,
  }) {
    return Container(
      child: TextFormField(
        // obscureText: !obscureText ? false : true,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLength: maxLength,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(18.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
            gapPadding: 0.0,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          hintText: "type here",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          // suffixIcon: suffixIcon
          //     ? InkWell(
          //         onTap: () {
          //           setState(() {
          //             _showPassword = !_showPassword;
          //           });
          //         },
          //         child: !_showPassword
          //             ? Icon(Icons.remove_red_eye_outlined)
          //             : Icon(Icons.remove_red_eye),
          //       )
          //     : null,
        ),
      ),
    );
  }
}
