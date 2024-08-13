// import 'package:campus_pro/src/DATA/MODELS/findGooglePlacesModel.dart';
// import 'package:campus_pro/src/UTILS/GOOGLE_MAPS/place_service.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_webservice/places.dart';
//
// // Starting point latitude
// double _originLatitude = 28.470840190933785;
// // Starting point longitude
// double _originLongitude = 76.98285732025147;
// // Destination latitude
// double _destLatitude = 28.417662989937444;
// // Destination Longitude
// double _destLongitude = 77.052211823916949;
// // Markers to show points on the map
// Map<MarkerId, Marker> markers = {};
//
// PolylinePoints polylinePoints = PolylinePoints();
// Map<PolylineId, Polyline> polylines = {};
//
// // final Set<Marker> _markers = {};
// final Set<Polyline> _polyline = {};
//
// GoogleMapController? mapController;
//
// class SchoolBusPolylinePoints extends StatefulWidget {
//   static const routeName = "/school-bus-polyline-points";
//   @override
//   State<StatefulWidget> createState() => SchoolBusPolylinePointsState();
// }
//
// class SchoolBusPolylinePointsState extends State<SchoolBusPolylinePoints>
//     with SingleTickerProviderStateMixin {
//   bool _visible = true;
//   late final AnimationController animationController;
//   // Google Maps controller
//   Completer<GoogleMapController> _controller = Completer();
//
//   // GoogleMapController? mapController;
//
//   // Configure map position and zoom
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(_originLatitude, _originLongitude),
//     zoom: 9.4746,
//   );
//
//   @override
//   void initState() {
//     animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 400),
//     );
//
//     // mapController!.animateCamera(
//     //   CameraUpdate.
//     // );
//
//     /// add origin marker origin marker
//     // _addMarker(
//     //   LatLng(_originLatitude, _originLongitude),
//     //   "origin",
//     //   BitmapDescriptor.defaultMarker,
//     // );
//
//     // setState(() {
//     //   busStopsNewList.forEach((element) {
//     //     _addMarker(
//     //       LatLng(element.latitude!, element.longitude!),
//     //       "destination",
//     //       BitmapDescriptor.defaultMarkerWithHue(90),
//     //     );
//
//     //     // _markers.add(Marker(
//     //     //   markerId: MarkerId("1"),
//     //     //   position: LatLng(element.latitude!, element.longitude!),
//     //     //   infoWindow: InfoWindow(
//     //     //     title: element.locationName,
//     //     //     snippet: 'School Bus Stop',
//     //     //   ),
//     //     //   // icon: BitmapDescriptor.fromBytes(imageData),
//     //     // ));
//     //   });
//     // });
//
//     // Add destination marker
//     _addMarker(
//       LatLng(_destLatitude, _destLongitude),
//       "destination",
//       BitmapDescriptor.defaultMarkerWithHue(90),
//     );
//
//     _getPolyline();
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           GoogleMap(
//             onTap: (_) => setState(() => _visible = !_visible),
//             mapType: MapType.normal,
//             initialCameraPosition: _kGooglePlex,
//             myLocationEnabled: true,
//             tiltGesturesEnabled: true,
//             compassEnabled: true,
//             scrollGesturesEnabled: true,
//             zoomGesturesEnabled: true,
//             polylines: Set<Polyline>.of(polylines.values),
//             // markers: Set<Marker>.of(markers.values),
//             // polylines: _polyline,
//             // markers: Set.of((marker != null) ? [marker!] : []),
//             markers: _markers,
//             onMapCreated: (GoogleMapController controller) {
//               // _controller.complete(controller);
//               setState(() {
//                 mapController = controller;
//                 busStopsNewList.forEach((element) {
//                   _markers.add(Marker(
//                     markerId: MarkerId("1"),
//                     position: LatLng(element.latitude!, element.longitude!),
//                     infoWindow: InfoWindow(
//                       title: element.locationName,
//                       snippet: 'School Bus Stop',
//                     ),
//                     icon: BitmapDescriptor.defaultMarker,
//                   ));
//                 });
//
//                 // for (var i = 0; busStopsNewList!.length; i++) {
//                 //   _markers.add(Marker(
//                 //     markerId: MarkerId("$i"),
//                 //     position: LatLng(busStopsNewList[i].latitude!, busStopsNewList[i].longitude!),
//                 //     infoWindow: InfoWindow(
//                 //       title: busStopsNewList[i].locationName,
//                 //       snippet: 'School Bus Stop',
//                 //     ),
//                 //     // icon: BitmapDescriptor.fromBytes(imageData),
//                 //   ));
//                 // }
//               });
//             },
//           ),
//           SlidingAppBar(
//             controller: animationController,
//             visible: _visible,
//           )
//         ],
//       ),
//     );
//   }
//
//   // This method will add markers to the map based on the LatLng position
//   _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
//     MarkerId markerId = MarkerId(id);
//     Marker marker =
//         Marker(markerId: markerId, icon: descriptor, position: position);
//     markers[markerId] = marker;
//   }
//
//   _addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }
//
//   void _getPolyline() async {
//     List<LatLng> polylineCoordinates = [];
//
//     // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//     //   "AIzaSyDrct9SXSb0KCV0coJ2xVMDUQbUvTOWAps",
//     //   PointLatLng(28.470840190933785, 76.98285732025147),
//     //   PointLatLng(21.806490503198894, 79.28985748046875),
//     //   // travelMode: TravelMode.driving,
//     // );
//     await polylinePoints
//         .getRouteBetweenCoordinates(
//       "AIzaSyDrct9SXSb0KCV0coJ2xVMDUQbUvTOWAps",
//       // busStopsNewList.forEach(
//       //     (element) => PointLatLng(28.470840190933785, 76.98285732025147)),
//
//       // for(var i = 0; busStopsNewList.length; i++){
//
//       // PointLatLng(28.470840190933785, 76.98285732025147),
//       // }
//
//       // 1) Amity University
//       //    latitude : 28.321154467787846
//       //    longitude : 76.9142247363925
//       // 2) Fun N Food Village
//       //    latitude : 28.527526750905366
//       //    longitude : 77.08376213908195
//
//       PointLatLng(28.321154467787846, 76.9142247363925),
//       PointLatLng(28.527526750905366, 77.08376213908195),
//       // PointLatLng(28.470840190933785, 76.98285732025147),
//       // PointLatLng(21.806490503198894, 79.28985748046874),
//     )
//         .then((value) {
//       print("result => ${value}");
//       print("result.status => ${value.status}");
//       print("result.errorMessage => ${value.errorMessage}");
//       print("result.points => ${value.points}");
//     });
//
//     // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//     //     googleAPiKey,
//     //     _originLatitude,
//     //     _originLongitude,
//     //     _destLatitude,
//     //     _destLongitude);
//     // print("result.points => ${result.points}");
//
//     // if (result.points.isNotEmpty) {
//     //   result.points.forEach((PointLatLng point) {
//     //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//     //   });
//     // } else {
//     //   print(result.errorMessage);
//     // }
//     _addPolyLine(polylineCoordinates);
//   }
// }
//
// List<NewBusStopsModel> busStopsNewList = [
//   NewBusStopsModel(locationName: "", latitude: 0, longitude: 0)
// ];
//
// Set<Marker> _markers = {};
//
// class SlidingAppBar extends StatefulWidget {
//   final AnimationController controller;
//   final bool visible;
//
//   SlidingAppBar({required this.controller, required this.visible});
//
//   @override
//   _SlidingAppBarState createState() => _SlidingAppBarState();
// }
//
// class _SlidingAppBarState extends State<SlidingAppBar> {
//   TextEditingController stopController = TextEditingController();
//   TextEditingController destinationController = TextEditingController();
//
//   double maxHeight = 5.2;
//
//   Timer? timer;
//
//   // List<NewBusStopsModel> busStopsNewList = [
//   //   NewBusStopsModel(locationName: "", latitude: 0, longitude: 0)
//   // ];
//
//   @override
//   void initState() {
//     timer = Timer.periodic(Duration(microseconds: 300), (Timer t) {
//       setMaxHeight();
//     });
//
//     super.initState();
//   }
//
//   setMaxHeight() {
//     setState(() {
//       maxHeight = busStopsNewList.length <= 1
//           ? MediaQuery.of(context).size.height / 5.2
//           : busStopsNewList.length == 2
//               ? MediaQuery.of(context).size.height / 4.0
//               : MediaQuery.of(context).size.height / 3.2;
//     });
//   }
//
//   @override
//   void dispose() {
//     stopController.dispose();
//     timer!.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     widget.visible ? widget.controller.reverse() : widget.controller.forward();
//     return SlideTransition(
//       position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
//         CurvedAnimation(parent: widget.controller, curve: Curves.fastOutSlowIn),
//       ),
//       child: ConstrainedBox(
//         constraints: new BoxConstraints(
//           // minHeight: 100,
//           // minHeight: MediaQuery.of(context).size.height / 3.5,
//           minWidth: MediaQuery.of(context).size.width,
//           maxHeight: maxHeight,
//           // maxHeight: MediaQuery.of(context).size.height / 5.2,
//           // maxHeight: MediaQuery.of(context).size.height / 4.0,
//           // maxHeight: MediaQuery.of(context).size.height / 3.2,
//           maxWidth: MediaQuery.of(context).size.width,
//         ),
//         child: new DecoratedBox(
//           decoration: new BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey,
//                 blurRadius: 5.0,
//               ),
//             ],
//           ),
//           child: SafeArea(
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 8.0, vertical: 8.0),
//                   decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColor,
//                       border: Border(
//                           top: BorderSide(width: 1, color: Colors.black12))),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           setState(() {
//                             Navigator.pop(context);
//                             // busStopsNewList = [];
//                             // busStopsNewList.add(NewBusStopsModel(
//                             //     locationName: "", latitude: 0, longitude: 0));
//                             // _markers = {};
//                           });
//                         },
//                         child: Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 10.0),
//                         child: Text(
//                           "Assign Routes",
//                           textScaleFactor: 1.5,
//                           style: GoogleFonts.quicksand(
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: ListView.separated(
//                       separatorBuilder: (context, i) => SizedBox(height: 10.0),
//                       shrinkWrap: true,
//                       itemCount: busStopsNewList.length,
//                       itemBuilder: (context, i) {
//                         var item = busStopsNewList[i];
//                         return buildStopTextField(context, i, item);
//                       },
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 8.0, vertical: 4.0),
//                   decoration: BoxDecoration(
//                       border: Border(
//                           top: BorderSide(width: 1, color: Colors.black12))),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             busStopsNewList.removeWhere(
//                                 (element) => element.locationName != "");
//                           });
//                         },
//                         child: Text(
//                           "Clear all",
//                           textScaleFactor: 1.1,
//                           style: GoogleFonts.quicksand(
//                             decoration: TextDecoration.underline,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         child: Text(
//                           "Assign Route",
//                           textScaleFactor: 1.2,
//                           style: GoogleFonts.quicksand(
//                             fontWeight: FontWeight.w500,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   GoogleMapsPlaces _places =
//       GoogleMapsPlaces(apiKey: "AIzaSyDrct9SXSb0KCV0coJ2xVMDUQbUvTOWAps");
//
//   Container buildStopTextField(
//       BuildContext context, int? index, NewBusStopsModel item) {
//     return Container(
//       child: Stack(
//         children: [
//           GestureDetector(
//             onTap: () async {
//               final placeSelected =
//                   await Navigator.pushNamed(context, FindPlacesOnMap.routeName)
//                       as Predictions;
//               print("GoogleMap - placeSelected by User : $placeSelected");
//               if (placeSelected != null && placeSelected.description != "") {
//                 setState(() {
//                   busStopsNewList[index!] = NewBusStopsModel(
//                       locationName: placeSelected.description,
//                       latitude: placeSelected.latitude,
//                       longitude: placeSelected.longitude);
//                   print("GoogleMap - busStopsNewList after : $busStopsNewList");
//                   if (busStopsNewList.last.locationName != "")
//                     busStopsNewList.add(NewBusStopsModel(
//                         locationName: "", latitude: 0, longitude: 0));
//                   print(
//                       "GoogleMap - busStopsNewList.last after : $busStopsNewList");
//
//                   _markers = {};
//                   // Set<Marker> updatedMarkers = {};
//
//                   busStopsNewList.forEach((element) {
//                     _markers.add(Marker(
//                       markerId: MarkerId("1"),
//                       position: LatLng(element.latitude!, element.longitude!),
//                       infoWindow: InfoWindow(
//                         title: element.locationName,
//                         snippet: 'School Bus Stop',
//                       ),
//                       icon: BitmapDescriptor.defaultMarker,
//                     ));
//                   });
//
//                   // mapController!.animateCamera(
//                   //     CameraUpdate.newCameraPosition(CameraPosition(
//                   //   target: LatLng(28.470840190933785, 76.98285732025147),
//                   //   zoom: 14.5,
//                   //   tilt: 50.0,
//                   // )));
//
//                   // mapController!.animateCamera(
//                   //     CameraUpdate.newCameraPosition(CameraPosition(
//                   //   target: LatLng(28.5236999290127, 76.98575656861067),
//                   //   zoom: 14.5,
//                   //   tilt: 50.0,
//                   // )));
//
//                   // MarkerUpdates.from(Set<Marker>.from(_markers),
//                   //     Set<Marker>.from(updatedMarkers));
//
//                   // _markers = updatedMarkers;
//                   // for (var i = 0; busStopsNewList.length; i++) {
//                   //   _markers.add(Marker(
//                   //     markerId: MarkerId("$i"),
//                   //     position: LatLng(busStopsNewList[i].latitude!,
//                   //         busStopsNewList[i].longitude!),
//                   //     infoWindow: InfoWindow(
//                   //       title: busStopsNewList[i].locationName,
//                   //       snippet: 'School Bus Stop',
//                   //     ),
//                   //     // icon: BitmapDescriptor.fromBytes(imageData),
//                   //   ));
//                   // }
//                 });
//               }
//             },
//             child: Container(
//               margin: const EdgeInsets.only(left: 40.0, right: 40.0),
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black12),
//               ),
//               child: Text(
//                 item.locationName != "" ? item.locationName! : "add stop",
//                 textScaleFactor: 1.2,
//                 maxLines: 1,
//                 style: GoogleFonts.quicksand(
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 6,
//             left: 10.0,
//             child: Container(
//               width: 22.0,
//               height: 22.0,
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                 border: Border.all(
//                   color: Colors.grey,
//                   width: 2.0,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   "${index! + 1}",
//                   textScaleFactor: 1.1,
//                   style: GoogleFonts.quicksand(
//                     fontWeight: FontWeight.w500,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           if (item.locationName != "")
//             Positioned(
//               top: 5,
//               right: 8.0,
//               child: InkWell(
//                 onTap: () {
//                   setState(() {
//                     busStopsNewList.removeAt(index);
//                     _markers = {};
//
//                     busStopsNewList.forEach((element) {
//                       _markers.add(Marker(
//                         markerId: MarkerId("1"),
//                         position: LatLng(element.latitude!, element.longitude!),
//                         infoWindow: InfoWindow(
//                           title: element.locationName,
//                           snippet: 'School Bus Stop',
//                         ),
//                         icon: BitmapDescriptor.defaultMarker,
//                       ));
//                     });
//                   });
//                 },
//                 child: Icon(Icons.close),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class NewBusStopsModel {
//   int? iD;
//   String? locationName;
//   double? latitude;
//   double? longitude;
//
//   NewBusStopsModel({this.iD, this.locationName, this.latitude, this.longitude});
//
//   @override
//   String toString() {
//     return "{iD : $iD, locationName : $locationName},";
//   }
// }
