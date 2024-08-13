import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/UTILS/filePicker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// import 'package:html_editor_enhanced/html_editor.dart';

class ManageNotice extends StatefulWidget {
  static const routeName = '/manage-notice';
  final Map<String, String>? prevDesc;
  const ManageNotice({this.prevDesc});

  @override
  _ManageNoticeState createState() => _ManageNoticeState();
}

class _ManageNoticeState extends State<ManageNotice> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  List<File>? selectedImage = [];

  // final HtmlEditorController controller = HtmlEditorController();


  @override
  void initState() {
    super.initState();

    if (widget.prevDesc!.isNotEmpty) {
      setState(
        () {
          titleController.text = widget.prevDesc!['title']!;
          descController.text = widget.prevDesc!['description']!;
        },
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    // controller.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Manage Notice'),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 2),
                child: Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              buildTextField(context,
                  hint: 'Title', controller: titleController, maxLines: 1),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 2),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // buildHtmlEditor(),
              // buildTextField(context,
              //     hint: 'Description', controller: descController, maxLines: 5),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
                child: Text(
                  'Add File :',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: selectedImage!.length != 0
                    ? MediaQuery.of(context).size.height * 0.00
                    : 0,
              ),
              selectedImage!.length != 0
                  ? selectedImage![0].path.split('.').last.toLowerCase() !=
                          'pdf'
                      ? Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                            ),
                            height: 150,
                            width: 150,
                            child: Image.file(
                              selectedImage![0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.21,
                            ),
                            Icon(
                              Icons.picture_as_pdf,
                              size: 30,
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.03)),
                                child: Text(
                                  '${selectedImage![0].path.split('/')[7].split('.')[0]}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        )
                  : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              selectedImage!.length == 0
                  ? GestureDetector(
                      onTap: () async {
                        List<File>? file =
                            await showFilePicker(allowMultiple: false);
                        if (file!.length > 0) {
                          setState(() {
                            selectedImage = file;
                          });
                        }
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 0.1),
                          ),
                          child: Center(
                            child: Text(
                              'Add File',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImage = [];
                          });
                        },
                        child: PhysicalModel(
                          color: Colors.white12,
                          clipBehavior: Clip.antiAlias,
                          elevation: 10,
                          child: Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      print('Hello');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30.0,
                        ),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 25.0),
                    ),
                  ),
                  child: Text(
                    'SEND',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildTextField(BuildContext context,
      {@required String? hint,
      @required TextEditingController? controller,
      int? maxLines}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        validator: FieldValidators.globalValidator,
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: '$hint',
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
        ),
      ),
    );
  }

//   Widget buildHtmlEditor() {
//     return Column(
//       children: [
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 10),
//           child: HtmlEditor(
//             controller: controller,
//             htmlEditorOptions: HtmlEditorOptions(
//               hint: 'Your text here...',
//               shouldEnsureVisible: true,
//               //initialText: "<p>text content initial, if any</p>",
//             ),
//             htmlToolbarOptions: HtmlToolbarOptions(
//               toolbarPosition: ToolbarPosition.aboveEditor, //by default
//               toolbarType: ToolbarType.nativeGrid, //by default
//               // onButtonPressed:
//               //     (ButtonType type, bool status, Function() updateStatus) {
//               //   print(
//               //       "button '${describeEnum(type)}' pressed, the current selected status is $status");
//               //   return true;
//               // },
//               onDropdownChanged: (DropdownType type, dynamic changed,
//                   Function(dynamic)? updateSelectedItem) {
//                 print("dropdown '${describeEnum(type)}' changed to $changed");
//                 return true;
//               },
//               mediaLinkInsertInterceptor: (String url, InsertFileType type) {
//                 print(url);
//                 return true;
//               },
//               mediaUploadInterceptor:
//                   (PlatformFile file, InsertFileType type) async {
//                 print(file.name); //filename
//                 print(file.size); //size in bytes
//                 print(file.extension); //file extension (eg jpeg or mp4)
//                 return true;
//               },
//             ),
//             otherOptions: OtherOptions(height: 350),
//           ),
//         ),
//       ],
//     );
//   }
// }
}