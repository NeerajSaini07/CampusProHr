import 'package:campus_pro/src/DATA/MODELS/dummyData.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusListModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/SCHOOL_BUS_TRACKING/schoolBusInfo.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/SCHOOL_BUS_TRACKING/schoolBusHistory.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/SCHOOL_BUS_TRACKING/schoolBusStops.dart';
import 'package:campus_pro/src/UI/PAGES/schoolBusLocation.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../globalBlocProvidersFile.dart';

class SchoolBusList extends StatefulWidget {
  static const routeName = "/school-bus-list";
  const SchoolBusList({Key? key}) : super(key: key);

  @override
  _SchoolBusListState createState() => _SchoolBusListState();
}

class _SchoolBusListState extends State<SchoolBusList> {
  List<SchoolBusListModel>? schoolBusList = [];
  List<SchoolBusListModel> schoolBusFilterList = [];

  @override
  void initState() {
    super.initState();
    getBusListData();
  }

  getBusListData() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final data = {
      'OUserId': uid,
      'Token': token,
      'Schoolid': userData!.schoolId,
      'OrgId': userData.organizationId,
      'EmpId': userData.stuEmpId,
      'UserType': userData.ouserType,
    };
    context.read<SchoolBusListCubit>().schoolBusListCubitCall(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "School Buses"),
      body: BlocConsumer<SchoolBusListCubit, SchoolBusListState>(
        listener: (context, state) {
          if (state is SchoolBusListLoadSuccess) {
            setState(() {
              schoolBusList = state.busData;
              schoolBusFilterList = schoolBusList!;
            });
          }
        },
        builder: (context, state) {
          if (state is SchoolBusListLoadInProgress) {
            // return Center(child: CircularProgressIndicator());
            return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: LinearProgressIndicator());
          } else if (state is SchoolBusListLoadSuccess) {
            return buildBusListBody(context);
          } else if (state is SchoolBusListLoadFail) {
            return noRecordFound();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Column buildBusListBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.0),
        buildTextField(),
        SizedBox(height: 10.0),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider()),
            shrinkWrap: true,
            itemCount: schoolBusFilterList.length,
            itemBuilder: (context, i) {
              var bus = schoolBusFilterList[i];
              return ListTile(
                onTap: () {
                  print(bus.rootNo);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SchoolBusGridsOptions(busSelect: bus);
                      },
                    ),
                  );
                },
                leading: Image.asset(AppImages.busImage),
                title: Text(
                  bus.regNo!,
                  style: GoogleFonts.quicksand(
                    color: Color(0xff3A3A3A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "Route No ${bus.rootNo} ● ${bus.noofStops!} Stops",
                  style: GoogleFonts.quicksand(
                    // color: Color(0xff3A3A3A),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          ),
        ),
      ],
    );
  }

  Padding buildLabels({String? label, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label!,
        style: GoogleFonts.quicksand(
          color: color ?? Color(0xff3A3A3A),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  TextEditingController filterController = TextEditingController();

  Container buildTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: filterController,
        style: GoogleFonts.quicksand(color: Colors.black),
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
          hintText: "Search by Reg no or route no...",
          hintStyle: GoogleFonts.quicksand(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        ),
        onChanged: (val) {
          setState(() {
            if (filterController.text != "") {
              schoolBusFilterList = [];
              schoolBusList!.forEach((element) {
                if (element.regNo!.toLowerCase().contains(val.toLowerCase()) ||
                    element.rootNo!.toLowerCase().contains(val.toLowerCase()))
                  schoolBusFilterList.add(element);
              });
            } else {
              schoolBusFilterList = [];
              schoolBusFilterList = schoolBusList!;
            }
          });
        },
      ),
    );
  }
}

class SchoolBusGridsOptions extends StatefulWidget {
  static const routeName = "/school-bus-grid-options";
  final SchoolBusListModel? busSelect;
  const SchoolBusGridsOptions({Key? key, this.busSelect}) : super(key: key);

  @override
  _SchoolBusGridsOptionsState createState() => _SchoolBusGridsOptionsState();
}

class _SchoolBusGridsOptionsState extends State<SchoolBusGridsOptions> {
  String titleAppBar = "";

  @override
  void initState() {
    super.initState();
    print("${widget.busSelect}");
    titleAppBar =
        //widget.busSelect!.regNo!;
        widget.busSelect == null ? "" : widget.busSelect!.regNo!;
  }

  navigate(int? iD) {
    switch (iD) {
      case 0:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider<SchoolBusDetailCubit>(
            create: (_) => SchoolBusDetailCubit(
                SchoolBusDetailRepository(SchoolBusDetailApi())),
            child: BlocProvider<SchoolBusRouteCubit>(
                create: (_) => SchoolBusRouteCubit(
                    SchoolBusRouteRepository(SchoolBusRouteApi())),
                child: BlocProvider<CheckBusAllotCubit>(
                  create: (_) => CheckBusAllotCubit(
                      CheckBusAllotRepository(CheckBusAllotApi())),
                  child: SchoolBusLocation(busSelect: widget.busSelect),
                )),
          );
        }));
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return SchoolBusLocation(busSelect: widget.busSelect);

      // }));
      case 1:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider<SchoolBusStopsCubit>(
            create: (_) => SchoolBusStopsCubit(
                SchoolBusStopsRepository(SchoolBusStopsApi())),
            child: SchoolBusStops(busSelect: widget.busSelect),
          );
        }));
      case 2:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider<SchoolBusInfoCubit>(
            create: (_) =>
                SchoolBusInfoCubit(SchoolBusInfoRepository(SchoolBusInfoApi())),
            child: SchoolBusInfo(busSelect: widget.busSelect),
          );
        }));
      case 3:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider<GetBusHistoryCubit>(
            create: (_) =>
                GetBusHistoryCubit(GetBusHistoryRepository(GetBusHistoryApi())),
            child: SchoolBusHistory(
              busNo: widget.busSelect,
            ),
          );
        }));
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: titleAppBar),
      body: Container(
        // color: Colors.amber,
        // margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: schoolBusGridList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, i) {
            var item = schoolBusGridList[i];
            return InkWell(
              onTap: () => navigate(item.id),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(4.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        item.image!,
                        // AppImages.switchUser,
                        height: 60,
                        width: 60,
                        // color: Colors.black,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 8),
                      Text(
                        item.title!,
                        textScaleFactor: 0.7,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 20,
                            // fontSize: MediaQuery.of(context).size.height * 0.01,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
