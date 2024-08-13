import 'package:campus_pro/src/DATA/BLOC_CUBIT/SEARCH_STUDENT_FROM_RECORDS_COMMON_CUBIT/search_student_from_records_common_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/searchStudentFromRecordsCommonModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchStudentFromRecordsCommon extends StatefulWidget {
  static const routeName = "/search-student-from-records-common";
  const SearchStudentFromRecordsCommon({Key? key}) : super(key: key);

  @override
  _SearchStudentFromRecordsCommonState createState() =>
      _SearchStudentFromRecordsCommonState();
}

class _SearchStudentFromRecordsCommonState
    extends State<SearchStudentFromRecordsCommon> {
  TextEditingController searchController = TextEditingController();

  String? uid;
  String? token;
  UserTypeModel? userData;

  String? userId = "";

  List<SearchStudentFromRecordsCommonModel>? searchDataList = [];

  @override
  void initState() {
    getDataFromLocal();
    super.initState();
  }

  getDataFromLocal() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Search Student"),
      body: Column(
        children: [
          buildTextField(),
          Expanded(
            child: Container(
              child: BlocConsumer<SearchStudentFromRecordsCommonCubit,
                  SearchStudentFromRecordsCommonState>(
                listener: (context, state) {
                  if (state is SearchStudentFromRecordsCommonLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                  if (state is SearchStudentFromRecordsCommonLoadSuccess) {
                    setState(() => searchDataList = state.searchData);
                  }
                },
                builder: (context, state) {
                  if (state is SearchStudentFromRecordsCommonLoadInProgress) {
                    return buildProgressWidget();
                  } else if (state
                      is SearchStudentFromRecordsCommonLoadSuccess) {
                    return buildSearchStudentResults(context);
                  } else if (state is SearchStudentFromRecordsCommonLoadFail) {
                    return Center(
                        child: Text(
                      state.failReason,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ));
                  } else {
                    return Center(child: Text(""));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchStudentResults(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, i) => Divider(),
      shrinkWrap: true,
      itemCount: searchDataList!.length,
      itemBuilder: (context, i) {
        // print(
        //     "https://mobileweb.eiterp.com/api/${searchDataList![i].imageUrl}");
        var item = searchDataList![i];
        return InkWell(
          onTap: () {
            // setState(() => userId = item.studentid);
            // final studentData = {
            //   'OUserId': uid,
            //   'Token': token,
            //   'OrgId': userData!.organizationId,
            //   'Schoolid': userData!.schoolId,
            //   'SessionID': userData!.currentSessionid,
            //   'UserType': 's',
            //   'StuEmpID': userData!.stuEmpId,
            //   'StuId': item.studentid,
            //   'OUserType': userData!.ouserType,
            // };
            // print("Sending StudentDetailSearch Data => $studentData");
            // context
            //     .read<StudentDetailSearchCubit>()
            //     .studentDetailSearchCubitCall(studentData);
            Navigator.pop(context, item);
            searchDataList = [];
            searchDataList!.add(item);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(
                        // "https://mobileweb.eiterp.com/api/${item.imageUrl}",
                        "${item.imageUrl}",
                        height: 20.0,
                        width: 20.0,
                        errorBuilder: (BuildContext, Object, StackTrace) {
                      return Image.asset(AppImages.dummyImage);
                    }),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "${item.admno!} || ${item.stname!} | ${item.fathername!} | ${item.compClass!} | ${item.prsntAddress!}",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProgressWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // CircularProgressIndicator(),
        LinearProgressIndicator(),
        SizedBox(height: 12),
        Text(
          "Please wait...",
          textScaleFactor: 1.0,
        )
      ],
    );
  }

  Container buildTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextFormField(
        autofocus: true,
        controller: searchController,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(18.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
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
              color: Colors.black12,
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
          hintText: 'search...',
          hintStyle: TextStyle(color: Colors.black12),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        ),
        onChanged: (_) {
          if (searchController.text.length > 2) {
            final searchData = {
              'prefixText': searchController.text,
              'contextKey':
                  "$uid.$token.${userData!.organizationId}.${userData!.schoolId}.${userData!.currentSessionid}",
              'StuEmp': userData!.stuEmpId!,
              'UserType': userData!.ouserType!,
              'Flag': userData!.ouserType!,
            };
            print("sending Student search data => $searchData");
            context
                .read<SearchStudentFromRecordsCommonCubit>()
                .searchStudentFromRecordsCommonCubitCall(searchData);
          }
        },
      ),
    );
  }
}
