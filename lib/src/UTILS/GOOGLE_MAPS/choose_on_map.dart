// import 'dart:async';
//
// import 'package:campus_pro/src/DATA/MODELS/findGooglePlacesModel.dart';
// import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:location/location.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class ChooseOnMap extends StatefulWidget {
//   static const routeName = "/chosse-on-map";
//   const ChooseOnMap({Key? key}) : super(key: key);
//
//   @override
//   _ChooseOnMapState createState() => _ChooseOnMapState();
// }
//
// class _ChooseOnMapState extends State<ChooseOnMap> {
//   List<Marker> myMarker = [];
//
//   LatLng? selectedLocationFinal;
//
//   GoogleMapController? controller;
//
//   StreamSubscription? _locationSubscription;
//   Location _locationTracker = Location();
//
//   @override
//   void initState() {
//     super.initState();
//     _handleTap(LatLng(28.470840190933785, 76.98285732025147));
//     // if (controller != null) {
//     //   controller!
//     //       .animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
//     //     bearing: 192.8334901395799,
//     //     target: LatLng(
//     //       // 28.4186776,
//     //       // 77.0523078,
//     //       28.470840190933785,
//     //       76.98285732025147,
//     //     ),
//     //     tilt: 0,
//     //     zoom: 20.0,
//     //     // zoom: 14.4746,
//     //   )));
//     // }
//   }
//
//   // void getCurrentLocation() async {
//   //   try {
//   //     var location = await _locationTracker.getLocation();
//
//   //     print("location.latitude : ${location.latitude}");
//   //     print("location.longitude : ${location.longitude}");
//
//   //     updateMarkerAndCircle(location.latitude!, location.longitude!,
//   //         location.heading!.toString());
//
//   //     if (_locationSubscription != null) {
//   //       _locationSubscription!.cancel();
//   //     }
//   //   } on PlatformException catch (e) {
//   //     if (e.code == 'PERMISSION_DENIED') {
//   //       debugPrint("Permission Denied");
//   //     }
//   //   }
//   // }
//
//   // void updateMarkerAndCircle(double latitude, double longitude,
//   //     String? direction, Uint8List imageData) async {
//   //   LatLng latlng = LatLng(latitude, longitude);
//   //   Uint8List imageDataNew = await getBusMarkerNoDirection();
//   //   if (mounted) {
//   //     this.setState(() {
//   //       _markers.add(
//   //         Marker(
//   //             markerId: MarkerId("live_location"),
//   //             position: latlng,
//   //             // rotation: 192,
//   //             rotation: direction != "" && direction != null
//   //                 ? double.parse(direction)
//   //                 : 192,
//   //             draggable: false,
//   //             zIndex: 2,
//   //             flat: true,
//   //             anchor: Offset(0.5, 0.5),
//   //             icon: BitmapDescriptor.fromBytes(
//   //                 direction != "" && direction != null
//   //                     ? imageData
//   //                     : imageDataNew)),
//   //       );
//   //     });
//   //   }
//   // }
//
//   // @override
//   // void dispose() {
//   //   _locationSubscription!.cancel();
//   //   controller!.dispose();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: commonAppBar(context, title: "Select Location"),
//       bottomNavigationBar: InkWell(
//         onTap: () async {
//           final coordinates = new Coordinates(
//             selectedLocationFinal!.latitude,
//             selectedLocationFinal!.longitude,
//           );
//
//           var addresses =
//               await Geocoder.local.findAddressesFromCoordinates(coordinates);
//
//           final currentAddress = addresses.first.addressLine;
//           print("GoogleMap - Choose on Map Location : $currentAddress");
//           Navigator.pop(
//               context,
//               Predictions(
//                   description: currentAddress,
//                   latitude: selectedLocationFinal!.latitude,
//                   longitude: selectedLocationFinal!.longitude));
//         },
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey,
//                 blurRadius: 5.0,
//               ),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               "Select",
//               textScaleFactor: 1.5,
//               style: GoogleFonts.quicksand(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//             target: LatLng(28.470840190933785, 76.98285732025147)),
//         markers: Set<Marker>.from(myMarker),
//         mapType: MapType.normal,
//         onTap: (LatLng tappedPoint) => _handleTap(tappedPoint),
//         zoomControlsEnabled: false,
//         buildingsEnabled: true,
//         minMaxZoomPreference: MinMaxZoomPreference(13, 19),
//         zoomGesturesEnabled: true,
//         myLocationEnabled: true,
//         compassEnabled: true,
//         // onMapCreated: (GoogleMapController controller) {
//         //   _controller = controller;
//         // },
//       ),
//     );
//   }
//
//   _handleTap(LatLng tappedPoint) {
//     print("tappedPoint : $tappedPoint");
//     setState(() {
//       selectedLocationFinal = tappedPoint;
//       myMarker = [];
//       myMarker.add(
//         Marker(
//           markerId: MarkerId(selectedLocationFinal.toString()),
//           position: selectedLocationFinal!,
//           draggable: true,
//           onDragEnd: (dragEndPosition) {
//             print("dragEndPosition : $dragEndPosition");
//           },
//         ),
//       );
//     });
//   }
// }
