import 'package:campus_pro/src/DATA/BLOC_CUBIT/SCHOOL_BUS_INFO_CUBIT/school_bus_info_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusListModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SchoolBusInfo extends StatefulWidget {
  static const routeName = "/school-bus-info";
  final SchoolBusListModel? busSelect;
  const SchoolBusInfo({Key? key, this.busSelect}) : super(key: key);

  @override
  _SchoolBusInfoState createState() => _SchoolBusInfoState();
}

class _SchoolBusInfoState extends State<SchoolBusInfo> {
  @override
  void initState() {
    super.initState();
    getBusInfoData();
  }

  getBusInfoData() async {
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
      'BusId': widget.busSelect!.busID.toString(),
    };
    context.read<SchoolBusInfoCubit>().schoolBusInfoCubitCall(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Bus Information"),
      body: CustomPaint(
        painter: CustomPaintCall(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 60.0),
                    padding: const EdgeInsets.all(8.0),
                    width: 150,
                    // width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.yellow[600],
                      border: Border.all(
                        width: 4.0,
                        color: Colors.black,
                        // color: Color(0xffECECEC),
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: RichText(
                        text: TextSpan(
                          text: widget.busSelect!.regNo,
                          // style:
                          //     Theme.of(context).textTheme.bodyText2!.copyWith(
                          //           fontWeight: FontWeight.w900,
                          //           color: Colors.black,
                          //           // fontSize: 20,
                          //         ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              BlocConsumer<SchoolBusInfoCubit, SchoolBusInfoState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is SchoolBusInfoLoadInProgress) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SchoolBusInfoLoadSuccess) {
                    return buildBusInfoBody(context, state.busData);
                  } else if (state is SchoolBusInfoLoadFail) {
                    return noRecordFound();
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildBusInfoBody(BuildContext context, SchoolBusInfoModel? busInfo) {
    return Column(
      children: [
        buildLabelWithValue(heading: "Route No", value: busInfo!.rootNo),
        buildLabelWithValue(heading: "Driver Name", value: busInfo.driverName),
        buildLabelWithValue(heading: "Phone", value: busInfo.driverMobile),
        buildLabelWithValue(
            heading: "Conductor Name", value: busInfo.conductorName),
        buildLabelWithValue(heading: "Phone", value: busInfo.conductorMobile),
      ],
    );
  }

  Container buildLabelWithValue({String? heading, String? value}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading!,
            // style:
            //     Theme.of(context).textTheme.headline6!.copyWith(fontSize: 17),
          ),
          SizedBox(height: 4),
          Text(
            value != null ? value : "",
            // style: Theme.of(context)
            //     .textTheme
            //     .headline6!
            //     .copyWith(color: Colors.black54, fontSize: 17),
          ),
        ],
      ),
    );
  }
}

class CustomPaintCall extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = Color(0xffFF6397EE);

    var path = Path();
    path.moveTo(0, size.height * 0.90);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.87,
        size.width * 0.5, size.height * 0.91);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.95,
        size.width * 1.0, size.height * 0.91);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
