import 'dart:io';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/PROFILE_EDIT_REQUEST_CUBIT/profile_edit_request_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/profileStudentModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../UTILS/fieldValidators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditRequest extends StatefulWidget {
  static const routeName = "/profile-edit-request";

  final ProfileStudentModel? profileData;

  const ProfileEditRequest({Key? key, this.profileData}) : super(key: key);
  @override
  _ProfileEditRequestState createState() => _ProfileEditRequestState();
}

class _ProfileEditRequestState extends State<ProfileEditRequest> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController guardianPhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aadharNoController = TextEditingController();
  TextEditingController fatherAadharNoController = TextEditingController();
  TextEditingController motherAadharNoController = TextEditingController();
  TextEditingController presentAddressController = TextEditingController();
  TextEditingController presentPinCodeController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController permanentPinCodeController = TextEditingController();

  File? _pickedImage;

  bool showLoader = false;

  GlobalKey<FormState> __formKey = new GlobalKey<FormState>();

  Container buildDateSelector() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffECECEC)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => _selectDate(context),
            child: Row(
              children: [
                Icon(Icons.today, color: Theme.of(context).primaryColor),
                SizedBox(width: 8),
                Container(
                  child: Text(
                    DateFormat('dd MMM yyyy').format(selectedDate!) !=
                            DateFormat('dd MMM yyyy').format(DateTime.now())
                        ? DateFormat('dd MMM yyyy').format(selectedDate!)
                        : '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          if (DateFormat('dd MMM yyyy').format(selectedDate!) !=
              DateFormat('dd MMM yyyy').format(DateTime.now()))
            InkResponse(
              onTap: () => setState(() => selectedDate = DateTime.now()),
              child: Icon(Icons.cancel, color: Colors.grey),
            ),
        ],
      ),
    );
  }

  DateTime? selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
      helpText: "SELECT DATE",
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      print('selectedDate : $selectedDate');
    }
  }

  Future<File?> getImage({ImageSource source = ImageSource.gallery}) async {
    // Navigator.pop(context);
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      print('Wow! Image selected.');
      final image = File(pickedFile.path);
      return image;
    } else {
      print('Ops! No Image selected.');
    }
    return null;
  }

  FocusNode? myFocusNode;

  @override
  void initState() {
    if (widget.profileData != null) autoFillFormValues(widget.profileData);
    myFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(myFocusNode);
    });
    super.initState();
  }

  autoFillFormValues(ProfileStudentModel? profileData) {
    setState(() {
      nameController.text = profileData!.stName!;
      fatherNameController.text = profileData.fatherName!;
      motherNameController.text = profileData.motherName!;
      phoneController.text = profileData.mobileNo!;
      guardianPhoneController.text = profileData.guardianMobileNo!;
      emailController.text = profileData.email!;
      aadharNoController.text = profileData.studentAadharNo!;
      fatherAadharNoController.text = profileData.fatherAadharNo!;
      motherAadharNoController.text = profileData.motherAadharNo!;
      presentAddressController.text = profileData.prsntAddress!;
      presentPinCodeController.text = profileData.presZip!;
      permanentAddressController.text = profileData.permanentAddress!;
      permanentPinCodeController.text = profileData.permanentPin!;
      _pickedImage = File(profileData.studentImage!);
      print("_pickedImage ${_pickedImage!.path}");
      print("profileData.dOB ${profileData.dOB!.split(" ").last.trimLeft()}");
      // print(
      //     "profileData ${profileData.dOB!.split(" ")[0] + " " + profileData.dOB!.split(" ")[1]}");
      //

      // String monthAlpha = profileData.dOB!.split(" ")[0].split("-")[1];
      //
      // String monthNumber = monthAlpha.contains("Jan")
      //     ? "1"
      //     : monthAlpha.contains("Feb")
      //         ? "2"
      //         : monthAlpha.contains("March")
      //             ? "3"
      //             : monthAlpha.contains("April")
      //                 ? "4"
      //                 : monthAlpha.contains("May")
      //                     ? "5"
      //                     : monthAlpha.contains("Jun")
      //                         ? "6"
      //                         : monthAlpha.contains("July")
      //                             ? "7"
      //                             : monthAlpha.contains("Aug")
      //                                 ? "8"
      //                                 : monthAlpha.contains("Sept")
      //                                     ? "9"
      //                                     : monthAlpha.contains("Oct")
      //                                         ? "10"
      //                                         : monthAlpha.contains("Nov")
      //                                             ? "11"
      //                                             : "12";
      //
      selectedDate = DateTime(
          int.parse(profileData.dOB!.split(" ")[0].split("-")[2]),
          int.parse(profileData.dOB!.split(" ")[0].split("-")[1]),
          int.parse(profileData.dOB!.split(" ")[0].split("-")[0]));
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    phoneController.dispose();
    guardianPhoneController.dispose();
    emailController.dispose();
    aadharNoController.dispose();
    fatherAadharNoController.dispose();
    motherAadharNoController.dispose();
    presentAddressController.dispose();
    presentPinCodeController.dispose();
    permanentAddressController.dispose();
    permanentPinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Edit Request Details"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileEditRequestCubit, ProfileEditRequestState>(
            listener: (context, state) {
              if (state is ProfileEditRequestLoadInProgress) {
                setState(() => showLoader = true);
              }
              if (state is ProfileEditRequestLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() => showLoader = false);
                }
              }
              if (state is ProfileEditRequestLoadSuccess) {
                setState(() => showLoader = false);
                Navigator.pop(context);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Form(
            key: __formKey,
            child: Column(
              children: [
                buildImageUpload(context),
                buildTextFields(
                  label: "Name",
                  controller: nameController,
                  // validator: FieldValidators.passwordValidator,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabels('DOB'),
                      SizedBox(height: 8),
                      buildDateSelector(),
                    ],
                  ),
                ),
                buildTextFields(
                  label: "Father Name",
                  controller: fatherNameController,
                  // validator: FieldValidators.passwordValidator,
                ),
                buildTextFields(
                  label: "Mother Name",
                  controller: motherNameController,
                  // validator: FieldValidators.passwordValidator,
                ),
                buildTextFields(
                    label: "Mobile Number",
                    controller: phoneController,
                    validator: FieldValidators.mobileNoValidator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ]),
                buildTextFields(
                    label: "Guardian Mobile Number",
                    controller: guardianPhoneController,
                    validator: FieldValidators.mobileNoValidator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ]),
                buildTextFields(
                  label: "Email Id",
                  controller: emailController,
                  validator: FieldValidators.emailValidator,
                  keyboardType: TextInputType.emailAddress,
                ),
                buildTextFields(
                    label: "Student Aadhar No",
                    controller: aadharNoController,
                    validator: FieldValidators.aadharValidator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12)
                    ]),
                buildTextFields(
                    label: "Father's Aadhar No",
                    controller: fatherAadharNoController,
                    validator: FieldValidators.aadharValidator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12)
                    ]),
                buildTextFields(
                    label: "Mother's Aadhar No",
                    controller: motherAadharNoController,
                    validator: FieldValidators.aadharValidator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12)
                    ]),
                buildTextFields(
                  label: "Present Address",
                  controller: presentAddressController,
                  // validator: FieldValidators.passwordValidator,
                ),
                buildTextFields(
                    label: "Present Pin Code",
                    controller: presentPinCodeController,
                    validator: FieldValidators.pinCodeValidator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6)
                    ]),
                buildTextFields(
                  label: "Permanent Address",
                  controller: permanentAddressController,
                  // validator: FieldValidators.passwordValidator,
                ),
                buildTextFields(
                    label: "Permanent Pin Code",
                    controller: permanentPinCodeController,
                    validator: FieldValidators.pinCodeValidator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6)
                    ]),
                if (showLoader)
                  Center(child: CircularProgressIndicator())
                else
                  buildSubmitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildTextFields(
      {String? label,
      int? maxLength,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      TextEditingController? controller,
      String? Function(String?)? validator}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabels(label!),
          SizedBox(height: 10.0),
          Container(
            child: TextFormField(
              // obscureText: !obscureText ? false : true,
              inputFormatters: inputFormatters ?? null,

              controller: controller,
              validator: validator,
              keyboardType: keyboardType ?? null,
              maxLength: maxLength ?? null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                hintStyle: TextStyle(color: Color(0xffA5A5A5), fontSize: 12),
                counterText: "",
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
          ),
          // Container(
          //   child: TextFormField(
          //     // obscureText: !obscureText ? false : true,
          //     controller: controller,
          //     validator: validator,
          //     autovalidateMode: AutovalidateMode.onUserInteraction,
          //     style: TextStyle(color: Colors.black),
          //     decoration: InputDecoration(
          //       hintText: "type here",
          //       hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          //       contentPadding:
          //           const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Text buildLabels(String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
    );
  }

  Padding buildImageUpload(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => showUploadSheet(),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 48,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 46,
                backgroundImage: _pickedImage != null
                    ? _pickedImage!.path.contains("http")
                        ? NetworkImage(_pickedImage!.path) as ImageProvider
                        : FileImage(_pickedImage!)
                    : AssetImage(AppImages.dummyImage),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => showUploadSheet(),
                child: Text(
                  "change",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (_pickedImage != null)
                InkWell(
                  onTap: () => setState(() => _pickedImage = null),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "remove",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red[400],
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Center(
          //   child: GestureDetector(
          //     onTap: () => showUploadSheet(),
          //     child: Container(
          //       height: 120,
          //       width: 120,
          //       decoration: new BoxDecoration(
          //         color: Color(0xffFAFAFA),
          //         border: Border.all(
          //             width: 1,
          //             style: BorderStyle.solid,
          //             color: Color(0xffECECEC)),
          //       ),
          //       child: _pickedImage != null
          //           ? GestureDetector(
          //               onTap: () => showUploadSheet(),
          //               child: Stack(
          //                 children: [
          //                   Container(
          //                     height: 150,
          //                     width: 150,
          //                     child:
          //                         Image.file(_pickedImage!, fit: BoxFit.cover),
          //                   ),
          //                   Positioned(
          //                     bottom: 0,
          //                     child: Container(
          //                       height: 30,
          //                       width: 150,
          //                       color: Colors.black54,
          //                       padding:
          //                           const EdgeInsets.symmetric(vertical: 2),
          //                       alignment: Alignment.center,
          //                       child: FittedBox(
          //                           child: Text(
          //                         "Change",
          //                         style: TextStyle(color: Colors.white70),
          //                       )),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             )
          //           : Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Icon(Icons.upload_file,
          //                     color: Theme.of(context).accentColor, size: 28),
          //                 FittedBox(
          //                   child: Text(
          //                     "Upload",
          //                     // textScaleFactor: 1.0,
          //                     style:
          //                         TextStyle(fontSize: 18, color: Colors.black),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
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

  Container buildSubmitButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: TextButton(
        onPressed: () async {
          if (__formKey.currentState!.validate()) {
            final uid = await UserUtils.idFromCache();
            final token = await UserUtils.userTokenFromCache();
            final userData = await UserUtils.userTypeFromCache();
            final editData = {
              'UserId': uid!,
              'Token': token!,
              'OrgId': userData!.organizationId!,
              'SchoolID': userData.schoolId!,
              'SessionId': userData.currentSessionid!,
              'StudentId': userData.stuEmpId!,
              'Name': nameController.text,
              'Dob': DateFormat('dd MMM yyyy').format(selectedDate!) !=
                      DateFormat('dd MMM yyyy').format(DateTime.now())
                  ? DateFormat('dd MMM yyyy').format(selectedDate!).toString()
                  : '',
              'FatherName': fatherNameController.text,
              'MotherName': motherNameController.text,
              'EmailId': emailController.text,
              'GuardianMobileNo': guardianPhoneController.text,
              'MobileNo': phoneController.text,
              'StudentAadharNo': aadharNoController.text,
              'FatherAadharNo': fatherAadharNoController.text,
              'MotherAadharNo': motherAadharNoController.text,
              'Address': presentAddressController.text,
              'PinNo': presentPinCodeController.text,
              'PermanentAddress': permanentAddressController.text,
              'PermanentPinNo': permanentPinCodeController.text,
              'Gender': '',
              'Category': '',
              'Caste': widget.profileData!.caste!,
              'Religion': '',
              'Nationality': '',
              'fileTitle': '',
              'BloodGroup': '',
            };
            print("Sending Profile Edit Data => $editData");
            if (_pickedImage!.path == widget.profileData!.studentImage!) {
              setState(() => _pickedImage = null);
            }
            context
                .read<ProfileEditRequestCubit>()
                .profileEditRequestCubitCall(editData, _pickedImage);
          }
        },
        child: Text(
          "SEND EDIT REQUEST",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// class ProfileEditRequest extends StatefulWidget {
//   static const routeName = "/profile-edit-request";
//   @override
//   _ProfileEditRequestState createState() => _ProfileEditRequestState();
// }

// class _ProfileEditRequestState extends State<ProfileEditRequest> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController dobController = TextEditingController();
//   TextEditingController fatherNameController = TextEditingController();
//   TextEditingController motherNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController guardianPhoneController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController addressController = TextEditingController();

//   String? _selectedGender = "Select";
//   String? _selectedCategory = "Select";
//   String? _selectedNationality = "Select";
//   String? _selectedReligion = "Select";
//   String? _selectedBloodGroup = "Select";

//   bool editButton = false;

//   InkWell buildDateSelector() {
//     return InkWell(
//       onTap: () => _selectDate(context),
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         decoration: BoxDecoration(
//           border: Border.all(color: Color(0xffECECEC)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width / 4,
//               child: Text(
//                 "${selectedDate.toLocal()}".split(' ')[0],
//                 overflow: TextOverflow.visible,
//                 maxLines: 1,
//               ),
//             ),
//             Icon(Icons.today, color: Theme.of(context).primaryColor)
//           ],
//         ),
//       ),
//     );
//   }

//   DateTime selectedDate = DateTime.now();

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//       helpText: "SELECT START DATE",
//     );
//     if (picked != null && picked != selectedDate)
//       setState(() {
//         selectedDate = picked;
//       });
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     dobController.dispose();
//     fatherNameController.dispose();
//     motherNameController.dispose();
//     emailController.dispose();
//     guardianPhoneController.dispose();
//     phoneController.dispose();
//     addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: commonAppBar(
//         context,
//         title: "My Profile",
//         icon: !editButton
//             ? buildEditbutton(
//                 title: "EDIT REQUEST",
//                 icon: Icons.edit,
//                 onTap: () => setState(() {
//                       editButton = !editButton;
//                     }))
//             : buildEditbutton(
//                 title: "SEND",
//                 icon: Icons.check,
//                 size: 26,
//                 onTap: () => setState(() {
//                       editButton = !editButton;
//                     })),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.width / 2.5,
//               width: MediaQuery.of(context).size.width,
//               child: Container(
//                 margin: const EdgeInsets.symmetric(
//                     horizontal: 20.0, vertical: 20.0),
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 10.0, vertical: 10.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Theme.of(context).primaryColor),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                         height: MediaQuery.of(context).size.width / 3.5,
//                         width: MediaQuery.of(context).size.width / 3.5,
//                         color: Colors.grey),
//                     Container(
//                       height: MediaQuery.of(context).size.width / 3.5,
//                       width: MediaQuery.of(context).size.width / 1.75,
//                       // color: Colors.green,
//                       child: Center(
//                         child: ListTile(
//                           title: Padding(
//                             padding: const EdgeInsets.only(bottom: 18.0),
//                             child: Text(
//                               "Akshay Syal",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w700),
//                             ),
//                           ),
//                           subtitle: RichText(
//                             text: TextSpan(
//                               text: "Class XI-B",
//                               style:
//                                   TextStyle(color: Colors.grey, fontSize: 18),
//                               children: <TextSpan>[
//                                 TextSpan(
//                                   text: " | ",
//                                   style: TextStyle(
//                                       color: Colors.grey, fontSize: 18),
//                                   children: <TextSpan>[
//                                     TextSpan(
//                                       text: "Adm no: 04",
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 18),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             buildTextFields(
//               label: "Name",
//               controller: nameController,
//               // validator: FieldValidators.passwordValidator,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: buildDropDown(
//                     title: "Gender",
//                     selectedValue: _selectedGender,
//                     dropDownList: genderDropdownList,
//                     flag: 0,
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       buildLabels('DOB'),
//                       SizedBox(height: 8),
//                       buildDateSelector(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             buildTextFields(
//               label: "Father Name",
//               controller: fatherNameController,
//               // validator: FieldValidators.passwordValidator,
//             ),
//             buildTextFields(
//               label: "Mother Name",
//               controller: motherNameController,
//               // validator: FieldValidators.passwordValidator,
//             ),
//             buildTextFields(
//               label: "Mobile Number",
//               controller: phoneController,
//               // validator: FieldValidators.passwordValidator,
//             ),
//             buildTextFields(
//               label: "Guardian Mobile Number",
//               controller: guardianPhoneController,
//               // validator: FieldValidators.passwordValidator,
//             ),
//             buildTextFields(
//               label: "Email Id",
//               controller: emailController,
//               // validator: FieldValidators.passwordValidator,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: buildDropDown(
//                     title: "Category",
//                     selectedValue: _selectedCategory,
//                     dropDownList: categoryDropdownList,
//                     flag: 1,
//                   ),
//                 ),
//                 Expanded(
//                   child: buildDropDown(
//                       title: "Nationality",
//                       selectedValue: _selectedNationality,
//                       dropDownList: nationalityDropdownList,
//                       flag: 2),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: buildDropDown(
//                       title: "Religion",
//                       selectedValue: _selectedReligion,
//                       dropDownList: religionDropdownList,
//                       flag: 3),
//                 ),
//                 Expanded(
//                   child: buildDropDown(
//                       title: "Blood Group",
//                       selectedValue: _selectedBloodGroup,
//                       dropDownList: bloodGroupDropdownList,
//                       flag: 4),
//                 ),
//               ],
//             ),
//             Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: Text(
//                 "Present Address",
//                 style: Theme.of(context).textTheme.headline1,
//               ),
//             ),
//             buildTextFields(
//               label: "Address",
//               controller: dobController,
//               // validator: FieldValidators.passwordValidator,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Container buildDropDown(
//       {String? title,
//       List<String>? dropDownList,
//       String? selectedValue,
//       int? flag}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           buildLabels(title ?? ""),
//           Container(
//             margin: const EdgeInsets.only(top: 6),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               border: Border.all(color: Color(0xffECECEC)),
//             ),
//             child: DropdownButton<String>(
//               isDense: true,
//               value: selectedValue,
//               key: UniqueKey(),
//               isExpanded: true,
//               underline: Container(),
//               items: dropDownList!
//                   .map((item) =>
//                       DropdownMenuItem<String>(child: Text(item), value: item))
//                   .toList(),
//               onChanged: (val) {
//                 setState(() {
//                   if (flag == 0)
//                     _selectedGender = val;
//                   else if (flag == 1)
//                     _selectedCategory = val;
//                   else if (flag == 2)
//                     _selectedNationality = val;
//                   else if (flag == 3)
//                     _selectedReligion = val;
//                   else if (flag == 4) _selectedBloodGroup = val;

//                   print("_selectedValue: $val");
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Container buildTextFields(
//       {String? label,
//       TextEditingController? controller,
//       String Function(String?)? validator}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           buildLabels(label!),
//           buildTextField(
//             controller: controller,
//             validator: validator,
//           ),
//         ],
//       ),
//     );
//   }

//   Text buildLabels(String label) {
//     return Text(
//       label,
//       style: TextStyle(
//         // color: Theme.of(context).primaryColor,
//         color: Color(0xff313131),
//       ),
//     );
//   }

//   Container buildTextField({
//     String Function(String?)? validator,
//     @required TextEditingController? controller,
//   }) {
//     return Container(
//       child: TextFormField(
//         // obscureText: !obscureText ? false : true,
//         controller: controller,
//         validator: validator,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         style: TextStyle(color: Colors.black),
//         decoration: InputDecoration(
//           hintText: "type here",
//           hintStyle: TextStyle(color: Color(0xffA5A5A5)),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
//           // suffixIcon: suffixIcon
//           //     ? InkWell(
//           //         onTap: () {
//           //           setState(() {
//           //             _showPassword = !_showPassword;
//           //           });
//           //         },
//           //         child: !_showPassword
//           //             ? Icon(Icons.remove_red_eye_outlined)
//           //             : Icon(Icons.remove_red_eye),
//           //       )
//           //     : null,
//         ),
//       ),
//     );
//   }

//   InkWell buildEditbutton(
//       {String? title, IconData? icon, void Function()? onTap, double? size}) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18.0),
//         ),
//         child: Center(
//           child: Row(
//             children: [
//               Icon(
//                 icon,
//                 color: Theme.of(context).primaryColor,
//                 size: size ?? 18,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0),
//                 child: Text(
//                   title!,
//                   style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// List<String>? genderDropdownList = ["Select", "Male", "Female", "Other"];

// List<String> categoryDropdownList = [
//   "Select",
//   "BC",
//   "BC-A",
//   "GEN",
//   "OBC",
//   "SC",
//   "ST",
//   "SBC",
//   "BC-B"
// ];

// List<String>? nationalityDropdownList = ["Select", "INDIAN", "NEPALI"];

// List<String>? religionDropdownList = [
//   "Select",
//   "HINDU",
//   "MUSLIAN",
//   "CHRISTIAN",
//   "SIKH",
//   "None"
// ];

// List<String>? bloodGroupDropdownList = [
//   "Select",
//   "A+",
//   "A-",
//   "B+",
//   "B-",
//   "AB+",
//   "AB-",
//   "O+",
//   "O-"
// ];
