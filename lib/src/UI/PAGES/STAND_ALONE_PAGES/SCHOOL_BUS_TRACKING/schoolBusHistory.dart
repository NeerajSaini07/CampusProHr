import 'dart:async';


import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_BUS_HISTORY_CUBIT/get_bus_history_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SCHOOL_BUS_ROUTE_CUBIT/school_bus_route_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusListModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class SchoolBusHistory extends StatefulWidget {
  static const routeName = "/school-bus-history";
  final SchoolBusListModel? busNo;
  const SchoolBusHistory({Key? key, this.busNo}) : super(key: key);

  @override
  _SchoolBusHistoryState createState() => _SchoolBusHistoryState();
}

class _SchoolBusHistoryState extends State<SchoolBusHistory> {
  DateTime _selectedDate = DateTime.now();

  Timer? timer;

  String? authToken = "";

  final Set<Marker> _markers = {};
  Set<Polyline> _polyline = {};

  Marker? marker;

  Circle? circle;

  GoogleMapController? controller;

  List<LatLng> polyList = [];

  List<PointerModel> pointerList = [];

  List<MarkerModel> markersList = [];

  getSchoolBusHistory({String? date}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "Schoolid": userData!.schoolId,
      "OrgId": userData.organizationId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "BusNo": widget.busNo!.busNo.toString(),
      "Date": date != null
          ? date
          : DateFormat("dd-MMM-yyyy").format(DateTime.now()),
    };
    print("Sending data for busHistory$sendingData");

    context.read<GetBusHistoryCubit>().getBusHistoryCubit(sendingData);
  }

  @override
  void initState() {
    super.initState();
    // getSchoolBusHistory(date: "28-Dec-2021");
    getSchoolBusHistory();
  }

  BitmapDescriptor? mapMarker;

  @override
  void dispose() {
    controller == null ? null : controller!.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0, backgroundColor: Colors.white),
      bottomNavigationBar: InkWell(
        onTap: () {
          showAdvanceFilters();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today_rounded),
                  SizedBox(width: 8),
                  Text(DateFormat("dd-MMM-yyy").format(_selectedDate),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Text(
                "change",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          BlocConsumer<GetBusHistoryCubit, GetBusHistoryState>(
            listener: (context, state) {
              if (state is GetBusHistoryLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {}
              }

              if (state is GetBusHistoryLoadSuccess) {
                // state.history.forEach((element) {
                //   print("${element.lat}");
                // });
                // print("Done");
                // state.history.forEach((element) {
                //   print("${element.lng}");
                // });
                // // log("All history is ${state.history}");
                state.history.forEach((element) {
                  print(element.lat);
                  print(element.lng);
                  if (mounted) {
                    this.setState(() {
                      polyList.add(
                        LatLng(
                          double.parse(element.lat!),
                          double.parse(element.lng!),
                        ),
                      );
                    });
                    setState(() {
                      _polyline.add(Polyline(
                        polylineId: PolylineId('Pickup'),
                        visible: true,
                        points: polyList,
                        width: 4,
                        color: Colors.black,
                      ));
                    });
                  }

                  if (controller != null) {
                    controller!.animateCamera(
                        CameraUpdate.newCameraPosition(new CameraPosition(
                      bearing: 192.8334901395799,
                      target: LatLng(
                        polyList[0].latitude,
                        polyList[0].longitude,
                      ),
                      tilt: 0,
                      zoom: 17.0,
                      // zoom: 1,
                    )));
                  }
                });
              }
            },
            builder: (context, state) {
              if (state is SchoolBusRouteLoadInProgress) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SchoolBusRouteLoadSuccess) {
                return buildGoogleMaps(context);
              } else if (state is SchoolBusRouteLoadFail) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: "No Record For Today"));
                return buildGoogleMaps(context);
              } else {
                return buildGoogleMaps(context);
              }
            },
          ),
          Positioned(
            left: 10.0,
            top: 10.0,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Card(
                color: Colors.blue.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(28.4176942467881, 77.05248943254999),
    zoom: 14.4746,
  );

  GoogleMap buildGoogleMaps(BuildContext context) {
    return GoogleMap(
      polylines: _polyline,
      markers: _markers,
      zoomControlsEnabled: true,
      onMapCreated: _onMapCreated,
      initialCameraPosition: initialLocation,
      //minMaxZoomPreference: MinMaxZoomPreference(13, 19),
      zoomGesturesEnabled: true,
      mapType: MapType.normal,
      compassEnabled: true,
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) async {
    Future.delayed(Duration(seconds: 1));

    setState(() {
      controller = controllerParam;

      for (int i = 0; i < 2; i++) {
        Future.delayed(
          Duration(seconds: 2),
        ).then((value) {
          if (polyList.length > 0) {
            print("polyList $polyList");
            print("polyList ${polyList[0].longitude}");
            if (controller != null) {
              controller!.animateCamera(
                CameraUpdate.newCameraPosition(
                  new CameraPosition(
                    bearing: 192.8334901395799,
                    target: LatLng(
                      polyList[0].latitude,
                      polyList[0].longitude,
                    ),
                    tilt: 0,
                    zoom: 17,
                  ),
                ),
              );
            }
          }
        });
      }
    });
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load(AppImages.busStopIcon);
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List> getBusMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load(AppImages.busIcon);
    return byteData.buffer.asUint8List();
  }

  showAdvanceFilters() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return datePickerCustom();
      },
    );
  }

  Widget datePickerCustom() {
    return Wrap(
      children: [
        buildTopBar(context, "Select Date"),
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
        DatePickerWidget(
          looping: false, // default is not looping
          firstDate: DateTime(1990, 01, 01),
          lastDate: DateTime(2030, 1, 1),
          initialDate: _selectedDate,
          dateFormat: "dd-MMM-yyyy",
          locale: DatePicker.localeFromString('en'),
          onChange: (DateTime newDate, _) => _selectedDate = newDate,
          pickerTheme: DateTimePickerTheme(
            backgroundColor: Colors.transparent,
            itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
            dividerColor: Colors.grey,
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff2ab57d)),
              ),
              onPressed: () async {
                print("_selectedDate : $_selectedDate");
                setState(() {
                  _selectedDate = _selectedDate;
                });
                setState(() {
                  polyList = [];
                  _polyline = {};
                });
                getSchoolBusHistory(
                    date: DateFormat("dd-MMM-yyyy").format(_selectedDate));
                Navigator.pop(context);
              },
              child: Text(
                "Search History",
                style: GoogleFonts.quicksand(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding buildTopBar(BuildContext context, String? title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(title!,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
    );
  }
}

//Todo:

class MarkerModel {
  LatLng? latLong;
  String? stopName;

  MarkerModel({this.latLong, this.stopName});
}

class PointerModel {
  double? lat;
  double? lng;

  PointerModel({this.lat, this.lng});
}
