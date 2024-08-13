import 'package:campus_pro/src/DATA/BLOC_CUBIT/SCHOOL_BUS_STOPS_CUBIT/school_bus_stops_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusStopsModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchoolBusStops extends StatefulWidget {
  static const routeName = "/school-bus-stops";
  final SchoolBusListModel? busSelect;
  const SchoolBusStops({Key? key, this.busSelect}) : super(key: key);

  @override
  _SchoolBusStopsState createState() => _SchoolBusStopsState();
}

class _SchoolBusStopsState extends State<SchoolBusStops> {
  List<SchoolBusStopsModel>? schoolBusStopsList = [];

  @override
  void initState() {
    super.initState();
    getBusStops();
  }

  getBusStops() async {
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
      'RouteId': widget.busSelect!.rootNo!,
    };
    context.read<SchoolBusStopsCubit>().schoolBusStopsCubitCall(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Bus Stops"),
      body: BlocConsumer<SchoolBusStopsCubit, SchoolBusStopsState>(
        listener: (context, state) {
          if (state is SchoolBusStopsLoadSuccess) {
            setState(() {
              schoolBusStopsList = state.busData;
            });
          }
        },
        builder: (context, state) {
          if (state is SchoolBusStopsLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SchoolBusStopsLoadSuccess) {
            return buildBusStops(context);
          } else if (state is SchoolBusStopsLoadFail) {
            return noRecordFound();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  ListView buildBusStops(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: schoolBusStopsList!.length,
      itemBuilder: (context, i) {
        var bus = schoolBusStopsList![i];
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 40),
              padding: const EdgeInsets.only(left: 20),
              // decoration: BoxDecoration(
              //   border: Border(left: BorderSide(width: 4, color: Colors.black)),
              // ),
              child: ListTile(
                title: Text(
                  bus.stopName!,
                  style: GoogleFonts.quicksand(
                    color: Color(0xff3A3A3A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "Pickup : ${bus.pickUpTime!}\nDrop : ${bus.dropOffTime!}",
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30.0,
              top: 12.0,
              child: Image.asset(
                AppImages.busStopIcon,
                width: 24,
              ),
            ),
          ],
        );
      },
    );
  }
}
