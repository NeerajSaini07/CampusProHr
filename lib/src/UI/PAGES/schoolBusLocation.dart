import 'dart:async';
import 'dart:typed_data';
import 'package:campus_pro/src/DATA/API_SERVICES/schoolBusLiveLocationApi.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CHECK_BUS_ALLOT_CUBIT/check_bus_allot_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SCHOOL_BUS_DETAIL_CUBIT/school_bus_detail_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SCHOOL_BUS_ROUTE_CUBIT/school_bus_route_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/nearByBusesModel.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusDetailModel.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusRouteModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SchoolBusLocation extends StatefulWidget {
  static const routeName = '/school-bus-location';
  final SchoolBusListModel? busSelect;
  const SchoolBusLocation({Key? key, this.busSelect}) : super(key: key);

  @override
  _SchoolBusLocationState createState() => _SchoolBusLocationState();
}

class _SchoolBusLocationState extends State<SchoolBusLocation> {
  Timer? timer;

  String? authToken = "";
  String? currentAddress = "";
  String? busRegNo = "fetching...";

  bool showNearByBuses = false;

  String? uid = "";
  String? token = "";
  UserTypeModel? userData = UserTypeModel(ouserType: "");

  SchoolBusDetailModel? busData;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  Marker? marker;

  Circle? circle;

  StreamSubscription? _locationSubscription;
  // Location _locationTracker = Location();

  GoogleMapController? controller;
  // LatLng _lastMapPosition = LatLng(28.419420, 77.052077);

  List<LatLng> polyList = [];

  List<MarkerModel> markersList = [];

  List<NearByBusesModel> nearByBusesList = [];

  bool isCheck = false;

  @override
  void initState() {
    super.initState();
    markersList = [];
    polyList = [];
    busData = SchoolBusDetailModel(
      stopName: '',
      pickUpTime: '',
      dropOffTime: '',
      lattitude: '',
      longitude: '',
      busNo: '',
      regNo: '',
      trackingDeviceIMEI: '',
      routeName: '',
      driverName: '',
      conductorName: '',
      driverMobileNo: '',
    );
    // getDataFromCache("", "");
    checkBusAllot();
  }

  getDataFromCache(String vehicleId, String deviceId) async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    if (userData!.ouserType!.toLowerCase() == "s" ||
        userData!.ouserType!.toLowerCase() == "f") {
      getSchoolBusRoute(vehicleId, deviceId);
      getCurrentLocation(vehicleId.replaceAll(" ", "").toUpperCase(), deviceId);
      // final busData = {
      //   'OUserId': uid,
      //   'Token': token,
      //   'OrgId': userData!.organizationId,
      //   'Schoolid': userData!.schoolId,
      //   'UserType': userData!.ouserType,
      //   'StuEmpId': userData!.stuEmpId,
      //   'SessionId': userData!.currentSessionid,
      // };
      // print("Sending NearByBuses Data => $busData");
      // context.read<NearByBusesCubit>().notificationCubitCall(busData);
    } else {
      print("getSchoolBusRoute else");
      setState(() {
        busRegNo = widget.busSelect!.regNo!.replaceAll(" ", "").toUpperCase();
      });
      getCurrentLocation(
          widget.busSelect!.busNo!.replaceAll(" ", "").toUpperCase(),
          widget.busSelect!.trackingDeviceIMEI);
    }
  }

  getSchoolBusRoute(String vehicleId, String deviceId) async {
    final busData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "StudentID": userData!.stuEmpId,
      "SessionId": userData!.currentSessionid,
      "UserType": userData!.ouserType,
      "VehicleNo": vehicleId,
      "DeviceId": deviceId,
    };
    print("Sending SchoolBusRoute Data => $busData");
    context.read<SchoolBusRouteCubit>().schoolBusRouteCubitCall(busData);
  }

  getSchoolBusDetails() async {
    final busData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "StudentID": userData!.stuEmpId,
      "SessionId": userData!.currentSessionid,
      "UserType": userData!.ouserType,
    };
    print("Sending SchoolBusDetail Data => $busData");
    context.read<SchoolBusDetailCubit>().schoolBusDetailCubitCall(busData);
  }

  void getCurrentLocation(
      String? vehicleNumber, String? trackingDeviceIMEI) async {
    try {
      Uint8List imageData = await getBusMarker();

      // var location = await _locationTracker.getLocation();
      var location = LatLng(28.7041, 77.1025);

      print("location latitude : ${location.latitude}");
      print("location longitude : ${location.longitude}");
      print("First time sending vehicle number $vehicleNumber");
      print("First time sending vehicle number $trackingDeviceIMEI");

      updateMarkerAndCircle(
          location.latitude, location.longitude, "192", imageData, []);
      fetchBusLocation(vehicleNumber, trackingDeviceIMEI, imageData);

      if (_locationSubscription != null) {
        _locationSubscription!.cancel();
      }

      timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
        if (mounted) {
          fetchBusLocation(vehicleNumber, trackingDeviceIMEI, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  fetchBusLocation(String? vehicleNumber, String? trackingDeviceIMEI,
      Uint8List imageData) async {
    final mapData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData!.schoolId!,
      "StuEmpId": userData!.stuEmpId!,
      "UserType": userData!.ouserType!,
      "SessionId": userData!.currentSessionid!,
      "Vehicleno": vehicleNumber!,
      "TrackingDeviceId": trackingDeviceIMEI!,
    };
    print("Sending SchoolBusLiveLocation data : $mapData");
    SchoolBusLiveLocationApi.liveLocation(mapData).then((liveLocation) async {
      if (controller != null) {
        controller!
            .animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(
            // 28.4186776,
            // 77.0523078,
            double.parse(liveLocation.latitude!),
            double.parse(liveLocation.longitude!),
          ),
          tilt: 0,
          zoom: 17.0,
          // zoom: 14.4746,
        )));
        // updateMarkerAndCircle(28.4186776, 77.0523078, imageData);
        updateMarkerAndCircle(
            double.parse(liveLocation.latitude!),
            double.parse(liveLocation.longitude!),
            liveLocation.orientation!,
            imageData,
            liveLocation.otherBuses);

        // final coordinates = new Coordinates(
        //     double.parse(liveLocation.latitude!),
        //     double.parse(liveLocation.longitude!));
        //
        // //GeoCoder
        // var addresses =
        //     await Geocoder.local.findAddressesFromCoordinates(coordinates);

        print("vehicle number ${liveLocation.vehicleNumber}");
        setState(() {
          busRegNo =
              "${liveLocation.vehicleNumber!.replaceAll(' ', '').toUpperCase()}";
          // currentAddress = addresses.first.addressLine;
          currentAddress = "";
        });
      } else {
        setState(() {
          busRegNo = "fetching...";
          currentAddress = "";
        });
      }
    }).onError((error, stackTrace) {
      if (mounted) {
        setState(() {
          busRegNo = "fetching...";
          currentAddress = "";
        });
      }
    });
  }

  void updateMarkerAndCircle(double latitude, double longitude,
      String? direction, Uint8List imageData, List? otherBuses) async {
    LatLng latlng = LatLng(latitude, longitude);
    Uint8List imageDataNew = await getBusMarkerNoDirection();

    Uint8List imageDataNew2 = await getBusMarkerNoDirection2();

    print("setting marker and circless");

    if (mounted) {
      this.setState(() {
        _markers.add(
          Marker(
              markerId: MarkerId("live_location"),
              position: latlng,
              rotation: direction != "" && direction != null
                  ? double.parse(direction)
                  : 192,
              draggable: false,
              zIndex: 2,
              flat: true,
              anchor: Offset(0.5, 0.5),
              icon: BitmapDescriptor.fromBytes(
                  direction != "" && direction != null
                      ? imageData
                      : imageDataNew)),
        );

        //Todo:Added testing markers convert this markers into near by buses
        if (otherBuses!.length > 0) {
          for (int i = 0; i < otherBuses.length; i++) {
            LatLng latLng = LatLng(double.parse(otherBuses[i]["Latitude"]),
                double.parse(otherBuses[i]["Longitude"]));
            _markers.add(
              Marker(
                markerId: MarkerId("home$i"),
                position: latLng,
                rotation: otherBuses[i]["orientation"] != ""
                    ? double.parse(otherBuses[i]["orientation"])
                    : 192,
                draggable: false,
                zIndex: 2,
                flat: true,
                anchor: Offset(0.5, 0.5),
                icon: BitmapDescriptor.fromBytes(imageDataNew2),
                infoWindow: InfoWindow(
                    title: "${otherBuses[i]["vehicle_number"]}",
                    snippet: "Bus"),
              ),
            );
          }
        }
        // // LatLng latLng2 = LatLng(28.418664, 77.0523227);
        // // _markers.add(
        // //   Marker(
        // //       markerId: MarkerId("home1"),
        // //       position: latLng2,
        // //       rotation: 192,
        // //       draggable: false,
        // //       zIndex: 2,
        // //       flat: true,
        // //       anchor: Offset(0.5, 0.5),
        // //       icon: BitmapDescriptor.fromBytes(imageDataNew2)),
        // // );
        // // LatLng latLng3 = LatLng(28.418769, 77.0523237);
        // // _markers.add(
        // //   Marker(
        // //       markerId: MarkerId("home2"),
        // //       position: latLng3,
        // //       rotation: 192,
        // //       draggable: false,
        // //       zIndex: 2,
        // //       flat: true,
        // //       anchor: Offset(0.5, 0.5),
        // //       icon: BitmapDescriptor.fromBytes(imageDataNew2)),
        // // );
        // // LatLng latLng4 = LatLng(28.418874, 77.0523247);
        // // _markers.add(
        // //   Marker(
        // //       markerId: MarkerId("home3"),
        // //       position: latLng4,
        // //       rotation: 192,
        // //       draggable: false,
        // //       zIndex: 2,
        // //       flat: true,
        // //       anchor: Offset(0.5, 0.5),
        // //       icon: BitmapDescriptor.fromBytes(imageDataNew2)),
        // // );
        // // LatLng latLng5 = LatLng(28.418979, 77.0523257);
        // // _markers.add(
        // //   Marker(
        // //       markerId: MarkerId("home4"),
        // //       position: latLng5,
        // //       rotation: 192,
        // //       draggable: false,
        // //       zIndex: 2,
        // //       flat: true,
        // //       anchor: Offset(0.5, 0.5),
        // //       icon: BitmapDescriptor.fromBytes(imageDataNew2)),
        // // );
        //
        // ///Till here
        //
        // // marker = Marker(
        // //     markerId: MarkerId("home"),
        // //     position: latlng,
        // //     rotation: newLocalData.heading!,
        // //     draggable: false,
        // //     zIndex: 2,
        // //     flat: true,
        // //     anchor: Offset(0.5, 0.5),
        // //     icon: BitmapDescriptor.fromBytes(imageData));
        // // circle = Circle(
        // //     circleId: CircleId("bus"),
        // //     radius: newLocalData.accuracy!,
        // //     zIndex: 1,
        // //     strokeColor: Colors.blue,
        // //     center: latlng,
        // //     fillColor: Colors.blue.withAlpha(70));
      });
    }
  }

  checkBusAllot() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "Schoolid": userData!.schoolId,
      "OrgId": userData.organizationId,
      "StudentId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "SessionId": userData.currentSessionid,
    };

    print("sending data for checkBusAllot$sendingData");

    context.read<CheckBusAllotCubit>().checkBusAllotCubitCall(sendingData);
  }

  //
  LatLng? currentLocation = LatLng(0, 0);

  Future<Position> locateUser() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
    return position;
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(28.4176942467881, 77.05248943254999),
    zoom: 14.4746,
  );

  BitmapDescriptor? mapMarker;

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), AppImages.busIcon);
  }

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }
    timer?.cancel();
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        title: 'Bus Tracker',
        // icon: userData!.ouserType!.toLowerCase() == "s"
        //     ? GestureDetector(
        //         onTap: () {
        //           controller!.dispose();
        //           timer?.cancel();
        //           getDataFromCache("", "");
        //         },
        //         child: Padding(
        //           padding: const EdgeInsets.only(right: 8.0),
        //           child: Icon(Icons.home),
        //         ),
        //       )
        //     : null,
      ),
      body: MultiBlocListener(
          listeners: [
            // BlocListener<NearByBusesCubit, NearByBusesState>(
            //   listener: (context, state) {
            //     if (state is NearByBusesLoadFail) {
            //       if (state.failReason == "false") {
            //         UserUtils.unauthorizedUser(context);
            //       } else {
            //         setState(() {
            //           nearByBusesList = [];
            //         });
            //       }
            //     }
            //     if (state is NearByBusesLoadSuccess) {
            //       setState(() {
            //         nearByBusesList = state.nearByBusesList;
            //       });
            //       // getCurrentLocation(
            //       //     state.nearByBusesList[0].vehicleNo!.replaceAll(' ', '').toUpperCase(),
            //       //     state.nearByBusesList[0].deviceId);
            //     }
            //   },
            // ),
            BlocListener<SchoolBusDetailCubit, SchoolBusDetailState>(
              listener: (context, state) {
                if (state is SchoolBusDetailLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
                if (state is SchoolBusDetailLoadSuccess) {
                  getCurrentLocation(
                      state.busData.busNo!.replaceAll(' ', '').toUpperCase(),
                      state.busData.trackingDeviceIMEI!);
                }
              },
            ),
            BlocListener<SchoolBusRouteCubit, SchoolBusRouteState>(
              listener: (context, state) async {
                if (state is SchoolBusRouteLoadSuccess) {
                  Uint8List imageData = await getMarker();
                  setState(() {
                    getSchoolBusDetails();
                    List<BusStopModel>? busStopList =
                        state.busRouteData.busStop!;

                    /// Todo: This is marker drawing part
                    busStopList.forEach((element) {
                      if (mounted) {
                        this.setState(() {
                          if (element.lattitude != null &&
                              element.longitude != null &&
                              element.lattitude != "" &&
                              element.longitude != "") {
                            markersList.add(
                              MarkerModel(
                                latLong: LatLng(
                                    double.parse(element.lattitude!),
                                    double.parse(element.longitude!)),
                                stopName: element.stopName,
                              ),
                            );
                          }
                        });
                      }
                      print("markersList.length => $markersList");
                    });

                    markersList.forEach((element) {
                      print("markersList items => ${element.latLong}");
                    });
                    setState(() {
                      markersList.forEach((element) {
                        if (element.latLong != null && element.latLong != "") {
                          _markers.add(Marker(
                            markerId: MarkerId(element.stopName!),
                            position: element.latLong!,
                            infoWindow: InfoWindow(
                              title: element.stopName,
                              snippet: 'School Bus Stop',
                            ),
                            icon: BitmapDescriptor.fromBytes(imageData),
                          ));
                        }
                      });
                    });

                    ///
                  });

                  ///

                  ///Todo: This is polyline drawing part by using random coordinates

                  List<BusRoutePolylineModel>? busRoutePolylineList =
                      state.busRouteData.polyline!;

                  busRoutePolylineList.forEach((element) {
                    if (mounted) {
                      this.setState(() {
                        polyList.add(LatLng(element.lat!, element.lng!));
                      });
                    }
                  });

                  ///

                  ///  Todo: This is polyline drawing part by using Google Direction Api
                  // // print("Times it called ${markersList.length}");
                  // LatLng origin = LatLng(state.busRouteData.polyline![0].lat!,
                  //     state.busRouteData.polyline![0].lng!);
                  // LatLng destination = LatLng(
                  //     state.busRouteData.polyline!.last.lat!,
                  //     state.busRouteData.polyline!.last.lng!);
                  //
                  // Directions dir = await DirectionsRepository()
                  //     .getDirections(origin: origin, destination: destination);
                  //
                  // print("dir from api only for polylines ${dir.polylinePoints}");
                  //
                  // setState(() {
                  //   // polyList = dir.polylinePoints!;
                  // });
                  //
                  // // List<BusRoutePolylineModel>? busRoutePolylineList =
                  // //     state.busRouteData.polyline!;
                  //
                  // dir.polylinePoints!.forEach((element) {
                  //   if (mounted) {
                  //     this.setState(() {
                  //       polyList.add(LatLng(element.latitude, element.longitude));
                  //     });
                  //   }
                  // });

                  ///
                  //Todo: just for testing purpose this will be deleted and after this will be activated
                  //
                  // dir.polylinePoints!.forEach((element) {
                  //   if (mounted) {
                  //     this.setState(() {
                  //       markersList.add(
                  //         MarkerModel(
                  //             latLong:
                  //                 LatLng(element.latitude, element.longitude),
                  //             stopName: element.longitude.toString()),
                  //       );
                  //     });
                  //   }
                  // });
                  // //Uint8List imageData = await getMarker();
                  // setState(() {
                  //   markersList.forEach((element) {
                  //     _markers.add(Marker(
                  //       markerId: MarkerId(element.stopName!),
                  //       position: element.latLong!,
                  //       infoWindow: InfoWindow(
                  //         title: element.stopName,
                  //         snippet: 'School Bus Stop',
                  //       ),
                  //       icon: BitmapDescriptor.fromBytes(imageData),
                  //     ));
                  //   });
                  // });

                  ///
                }
              },
            ),
            BlocListener<CheckBusAllotCubit, CheckBusAllotState>(
                listener: (context, state) async {
              if (state is CheckBusAllotLoadSuccess) {
                final userData = await UserUtils.userTypeFromCache();
                print(userData!.ouserType);
                if (state.result == "YY") {
                  setState(() {
                    isCheck = true;
                  });
                  getDataFromCache("", "");
                } else if (state.result == "YN") {
                  if (userData.ouserType!.toLowerCase() == "s" ||
                      userData.ouserType!.toLowerCase() == "f") {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(
                              child: Text(
                                "Alert",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                            content: Text(
                              "Bus is not running at this time",
                            ),
                            actions: [
                              Center(
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                    Color(0xff2ab57d),
                                  )),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   commonSnackBar(title: "Bus is not running at this time"),
                    // );
                  } else {
                    setState(() {
                      isCheck = true;
                    });
                    getDataFromCache("", "");
                  }
                } else {
                  if (userData.ouserType!.toLowerCase() == "s" ||
                      userData.ouserType!.toLowerCase() == "f") {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   commonSnackBar(title: "Bus is not assigned"),
                    // );
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(
                              child: Text(
                                "Alert",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                            content: Text(
                              "Bus is not assigned",
                            ),
                            actions: [
                              Center(
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                    Color(0xff2ab57d),
                                  )),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  } else {
                    setState(() {
                      isCheck = true;
                    });
                    getDataFromCache("", "");
                  }
                }
              } else if (state is CheckBusAllotLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {}
              }
            }),
          ],
          child: isCheck == true
              ? Stack(
                  children: [
                    buildGoogleMaps(context),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  busRegNo!,
                                  textScaleFactor: 1.5,
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.green,
                                  highlightColor: Colors.grey[100]!,
                                  enabled: true,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 6.0,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Live",
                                        textScaleFactor: 1.2,
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (currentAddress != "")
                              Column(
                                children: [
                                  Divider(),
                                  Text(
                                    currentAddress!,
                                    textScaleFactor: 1.2,
                                  ),
                                ],
                              ),
                            // Divider(),
                            // if (userData!.ouserType!.toLowerCase() == "s")
                            //   GestureDetector(
                            //     onTap: () async {
                            //       setState(
                            //           () => showNearByBuses = !showNearByBuses);
                            //       // getDataFromCache("", "");
                            //     },
                            //     child: Container(
                            //       width: MediaQuery.of(context).size.width,
                            //       // color: Colors.amber,
                            //       child: Center(
                            //         child: Text(
                            //           !showNearByBuses
                            //               ? "See Near by Buses"
                            //               : "Hide All",
                            //           textScaleFactor: 1.1,
                            //           style: GoogleFonts.quicksand(
                            //             decoration: TextDecoration.underline,
                            //             fontWeight: FontWeight.bold,
                            //             color: Theme.of(context).primaryColor,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // if (showNearByBuses)
                            //   Padding(
                            //     padding: const EdgeInsets.only(top: 10.0),
                            //     child: GridView.builder(
                            //       shrinkWrap: true,
                            //       physics: NeverScrollableScrollPhysics(),
                            //       itemCount: nearByBusesList.length,
                            //       gridDelegate:
                            //           SliverGridDelegateWithFixedCrossAxisCount(
                            //         crossAxisCount: 2,
                            //         crossAxisSpacing: 4.0,
                            //         mainAxisSpacing: 1.0,
                            //         childAspectRatio: 3.0,
                            //         // crossAxisCount: 3,
                            //         // crossAxisSpacing: 6.0,
                            //         // mainAxisSpacing: 10.0,
                            //         // childAspectRatio: 1.0,
                            //       ),
                            //       itemBuilder: (context, i) {
                            //         var item = nearByBusesList[i];
                            //         return InkWell(
                            //           onTap: () {
                            //             controller!.dispose();
                            //             timer?.cancel();
                            //             setState(() =>
                            //                 showNearByBuses = !showNearByBuses);
                            //             print(
                            //                 "vehicleNo : ${item.vehicleNo!.replaceAll(" ", "")} & deviceId : ${item.deviceId!}");
                            //             getDataFromCache(
                            //                 item.vehicleNo!.replaceAll(" ", ""),
                            //                 item.deviceId!);
                            //           },
                            //           child: Container(
                            //             decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               border: Border.all(
                            //                   color: Color(0xffECECEC)),
                            //               // borderRadius: BorderRadius.circular(8.0),
                            //               // boxShadow: [
                            //               //   BoxShadow(
                            //               //     color: Colors.grey,
                            //               //     blurRadius: 5.0,
                            //               //   ),
                            //               // ],
                            //             ),
                            //             padding: const EdgeInsets.all(4.0),
                            //             margin: const EdgeInsets.all(4.0),
                            //             child: Center(
                            //               child: Column(
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.center,
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.start,
                            //                 mainAxisSize: MainAxisSize.min,
                            //                 children: [
                            //                   Text(
                            //                     item.vehicleNo!,
                            //                     textScaleFactor: 0.7,
                            //                     maxLines: 2,
                            //                     overflow: TextOverflow.ellipsis,
                            //                     textAlign: TextAlign.center,
                            //                     style: GoogleFonts.quicksand(
                            //                         color: Colors.black,
                            //                         fontSize: 20,
                            //                         // fontSize: MediaQuery.of(context).size.height * 0.01,
                            //                         fontWeight:
                            //                             FontWeight.bold),
                            //                   ),
                            //                   Text(
                            //                     "${double.parse((double.parse(item.distance!) / 1000).toStringAsFixed(2))} km",
                            //                     textScaleFactor: 0.7,
                            //                     maxLines: 2,
                            //                     overflow: TextOverflow.ellipsis,
                            //                     textAlign: TextAlign.center,
                            //                     style: GoogleFonts.quicksand(
                            //                         color: Colors.grey,
                            //                         fontSize: 20,
                            //                         // fontSize: MediaQuery.of(context).size.height * 0.01,
                            //                         fontWeight:
                            //                             FontWeight.bold),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //   ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Container()),
    );
  }

  DraggableScrollableSheet buildBottomLabel(BuildContext context,
      {SchoolBusDetailModel? busData}) {
    return DraggableScrollableSheet(
        initialChildSize: 0.1,
        minChildSize: 0.1,
        maxChildSize: 0.5,
        builder: (BuildContext context, ScrollController myScrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: ListView.builder(
                shrinkWrap: true,
                controller: myScrollController,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.expand_less, size: 28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.yellow[600],
                                border: Border.all(
                                  color: Colors.black,
                                  // color: Color(0xffECECEC),
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  text: busData!.regNo,
                                  // style: Theme.of(context)
                                  //     .textTheme
                                  //     .bodyText2!
                                  //     .copyWith(
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.black,
                                  //       // color: Colors.black54,
                                  //     ),
                                ),
                              ),
                            ),
                            // Container(
                            //   padding: const EdgeInsets.only(left: 24.0),
                            //   decoration: BoxDecoration(
                            //     border: Border(
                            //         left: BorderSide(color: Color(0xffECECEC))),
                            //   ),
                            //   child: Column(
                            //     children: [
                            //       RichText(
                            //         text: TextSpan(
                            //           text: "Pick up",
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .bodyText2!
                            //               .copyWith(
                            //                 fontWeight: FontWeight.bold,
                            //                 color: Colors.black,
                            //               ),
                            //         ),
                            //       ),
                            //       RichText(
                            //         text: TextSpan(
                            //           text: busData.pickUpTime,
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .bodyText2!
                            //               .copyWith(
                            //                 fontWeight: FontWeight.bold,
                            //                 color: Colors.black54,
                            //               ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Divider(),
                        buildLabelWithValue(
                            heading: "Stop Name", value: busData.stopName),
                        buildLabelWithValue(
                            heading: "Route No", value: busData.routeName),
                        buildLabelWithValue(
                            heading: "Driver Name", value: busData.driverName),
                        buildLabelWithValue(
                            heading: "Mobile No",
                            value: busData.driverMobileNo),
                        buildLabelWithValue(
                            heading: "Conductor Name",
                            value: busData.conductorName),
                      ],
                    ),
                  );
                }),
          );
        });
  }

  Container buildLabelWithValue({String? heading, String? value}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading!,
            // style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 4),
          Text(
            value != null ? value : "",
            // style: Theme.of(context)
            //     .textTheme
            //     .headline6!
            //     .copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  GoogleMap buildGoogleMaps(BuildContext context) {
    return GoogleMap(
      polylines: _polyline,
      markers: _markers,
      // circles: ,
      zoomControlsEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: currentLocation!, zoom: 17),
      buildingsEnabled: true,
      //minMaxZoomPreference: MinMaxZoomPreference(100, 2000),
      zoomGesturesEnabled: true,
      mapType: MapType.normal,
      myLocationEnabled: true,
      compassEnabled: true,
      // trafficEnabled: true,
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) async {
    Future.delayed(Duration(seconds: 1));
    Uint8List imageData = await getMarker();

    print("marker length${markersList.length}");
    markersList.forEach((element) {
      print("markersList items 2 => ${element.stopName}");
    });

    setState(() {
      controller = controllerParam;
//       controller!.setMapStyle('''
//       [
//   {
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#f5f5f5"
//       }
//     ]
//   },
//   {
//     "featureType": "road",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#ffffff"
//       }
//     ]
//   },
//   {
//     "featureType": "water",
//     "elementType": "geometry",
//     "stylers": [
//       {
//         "color": "#c9c9c9"
//       }
//     ]
//   },
//   {
//     "featureType": "water",
//     "elementType": "labels.text.fill",
//     "stylers": [
//       {
//         "color": "#9e9e9e"
//       }
//     ]
//   }
// ]
//
//       ''');

      ///
      // if (markersList.length > 0) {
      //   markersList.forEach((element) {
      //     _markers.add(Marker(
      //       markerId: MarkerId(element.stopName!),
      //       position: element.latLong!,
      //       infoWindow: InfoWindow(
      //         title: element.stopName,
      //         snippet: 'School Bus Stop',
      //       ),
      //       icon: BitmapDescriptor.fromBytes(imageData),
      //     ));
      //   });
      // }

      _polyline.add(Polyline(
        polylineId: PolylineId('Pickup'),
        visible: true,
        points: polyList,
        width: 4,
        color: Colors.black,
      ));
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

  Future<Uint8List> getBusMarkerNoDirection() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load(AppImages.busIcon);
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List> getBusMarkerNoDirection2() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load(AppImages.busIcon3);
    return byteData.buffer.asUint8List();
  }
}

class LocalPolylineModel {
  double? lat;
  double? lng;

  LocalPolylineModel({this.lat, this.lng});
}

class MarkerModel {
  LatLng? latLong;
  String? stopName;

  MarkerModel({this.latLong, this.stopName});
}