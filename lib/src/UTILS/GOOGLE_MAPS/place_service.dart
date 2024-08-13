// import 'dart:convert';
//
// import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
// import 'package:campus_pro/src/DATA/MODELS/findGooglePlacesModel.dart';
// import 'package:campus_pro/src/UTILS/GOOGLE_MAPS/choose_on_map.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;
//
// class FindPlacesOnMap extends StatefulWidget {
//   static const routeName = "find-places-on-map";
//   @override
//   _FindPlacesOnMapState createState() => _FindPlacesOnMapState();
// }
//
// class _FindPlacesOnMapState extends State<FindPlacesOnMap> {
//   var _controller = TextEditingController();
//   var uuid = new Uuid();
//   String? _sessionToken;
//   FindGooglePlaceModel? _placeList;
//
//   @override
//   void initState() {
//     super.initState();
//     print("initState");
//     _controller.addListener(() {
//       _onChanged();
//     });
//   }
//
//   _onChanged() {
//     if (_sessionToken == null) {
//       setState(() {
//         _sessionToken = uuid.v4();
//       });
//     }
//     getSuggestion(_controller.text);
//   }
//
//   void getSuggestion(String input) async {
//     String kPLACES_API_KEY = "AIzaSyDvoRtb4WZ9Kb9svm1pbQSWNt6QsULBRto";
//     String type = '(regions)';
//     String baseURL =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     String request =
//         '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=1234567890';
//     print("request : $request");
//     var response = await http.get(Uri.parse(request));
//     print("Google Place API response.statusCode : ${response.statusCode}");
//     if (response.statusCode == 200) {
//       if (mounted) {
//         setState(() {
//           // _placeList = json.decode(response.body)['predictions'];
//           final places = json.decode(placeListDummy);
//           _placeList = FindGooglePlaceModel.fromJson(places);
//         });
//       }
//     } else {
//       throw Exception('Failed to load predictions');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Search Places"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Align(
//               alignment: Alignment.topCenter,
//               child: TextField(
//                 controller: _controller,
//                 decoration: InputDecoration(
//                   hintText: "Seek your location here",
//                   focusColor: Colors.white,
//                   floatingLabelBehavior: FloatingLabelBehavior.never,
//                   prefixIcon: Icon(Icons.search),
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.cancel),
//                     onPressed: () => setState(() => _controller.text = ""),
//                   ),
//                 ),
//               ),
//             ),
//             if (_controller.text != "")
//               ListView.separated(
//                 separatorBuilder: (context, i) =>
//                     Divider(color: Colors.black12, height: 0.0),
//                 // physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: _placeList!.predictions!.length,
//                 itemBuilder: (context, index) {
//                   var place = _placeList!.predictions![index];
//                   return ListTile(
//                     onTap: () async {
//                       var results = await Geocoder.local
//                           .findAddressesFromQuery(place.description);
//                       Navigator.pop(
//                           context,
//                           Predictions(
//                               description: place.description,
//                               latitude: results.first.coordinates.latitude,
//                               longitude: results.first.coordinates.longitude));
//                     },
//                     leading: Icon(Icons.location_on),
//                     title: Text(place.description!),
//                   );
//                 },
//               ),
//             ListTile(
//               onTap: () async {
//                 setState(() => _controller.text = "");
//                 final predictions =
//                     await Navigator.pushNamed(context, ChooseOnMap.routeName)
//                         as Predictions;
//                 Navigator.pop(context, predictions);
//                 setState(() => _controller.text = "");
//               },
//               leading: Icon(Icons.location_on),
//               title: Text("Set location on map"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// String placeListDummy = '''
// {
//     "predictions": [
//         {
//             "description": "Paris, France",
//             "matched_substrings": [
//                 {
//                     "length": 5,
//                     "offset": 0
//                 }
//             ],
//             "place_id": "ChIJD7fiBh9u5kcRYJSMaMOCCwQ",
//             "reference": "ChIJD7fiBh9u5kcRYJSMaMOCCwQ",
//             "structured_formatting": {
//                 "main_text": "Paris",
//                 "main_text_matched_substrings": [
//                     {
//                         "length": 5,
//                         "offset": 0
//                     }
//                 ],
//                 "secondary_text": "France"
//             },
//             "terms": [
//                 {
//                     "offset": 0,
//                     "value": "Paris"
//                 },
//                 {
//                     "offset": 7,
//                     "value": "France"
//                 }
//             ],
//             "types": [
//                 "locality",
//                 "political",
//                 "geocode"
//             ]
//         },
//         {
//             "description": "Paris, America",
//             "matched_substrings": [
//                 {
//                     "length": 5,
//                     "offset": 0
//                 }
//             ],
//             "place_id": "ChIJD7fiBh9u5kcRYJSMaMOCCwQ",
//             "reference": "ChIJD7fiBh9u5kcRYJSMaMOCCwQ",
//             "structured_formatting": {
//                 "main_text": "Paris",
//                 "main_text_matched_substrings": [
//                     {
//                         "length": 5,
//                         "offset": 0
//                     }
//                 ],
//                 "secondary_text": "France"
//             },
//             "terms": [
//                 {
//                     "offset": 0,
//                     "value": "Paris"
//                 },
//                 {
//                     "offset": 7,
//                     "value": "France"
//                 }
//             ],
//             "types": [
//                 "locality",
//                 "political",
//                 "geocode"
//             ]
//         }
//     ],
//     "status": "OK"
// }
// ''';
//
// // import 'dart:convert';
// // import 'dart:io';
//
// // import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
// // import 'package:http/http.dart';
//
// // class Place {
// //   String? streetNumber;
// //   String? street;
// //   String? city;
// //   String? zipCode;
//
// //   Place({
// //     this.streetNumber,
// //     this.street,
// //     this.city,
// //     this.zipCode,
// //   });
//
// //   @override
// //   String toString() {
// //     return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
// //   }
// // }
//
// // class Suggestion {
// //   final String placeId;
// //   final String description;
//
// //   Suggestion(this.placeId, this.description);
//
// //   @override
// //   String toString() {
// //     return 'Suggestion(description: $description, placeId: $placeId)';
// //   }
// // }
//
// // class PlaceApiProvider {
// //   final client = Client();
//
// //   PlaceApiProvider(this.sessionToken);
//
// //   final sessionToken;
//
// //   static final String androidKey = googleApiKey;
// //   static final String iosKey = 'YOUR_API_KEY_HERE';
// //   final apiKey = Platform.isAndroid ? androidKey : iosKey;
//
// //   Future<List<Suggestion>> fetchSuggestions(String input) async {
// //     print('Map Search fetchSuggestions on API : $input');
// //     final request =
// //         'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=FindPlacesOnMap&language=en-US&components=country:in&key=$apiKey&sessiontoken=$sessionToken';
// //     final response = await client.get(Uri.parse(request));
//
// //     if (response.statusCode == 200) {
// //       print('Map Search fetchSuggestions Response : ${response.body}');
// //       final result = json.decode(response.body);
// //       if (result['status'] == 'OK') {
// //         // compose suggestions in a list
// //         return result['predictions']
// //             .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
// //             .toList();
// //       }
// //       if (result['status'] == 'ZERO_RESULTS') {
// //         return [];
// //       }
// //       throw Exception(result['error_message']);
// //     } else {
// //       throw Exception('Failed to fetch suggestion');
// //     }
// //   }
//
// //   Future<Place> getPlaceDetailFromId(String placeId) async {
// //     print('Map Search getPlaceDetailFromId on API : $placeId');
// //     final request =
// //         'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=FindPlacesOnMap_component&key=$apiKey&sessiontoken=$sessionToken';
// //     final response = await client.get(Uri.parse(request));
//
// //     if (response.statusCode == 200) {
// //       print('Map Search getPlaceDetailFromId Response : ${response.body}');
// //       final result = json.decode(response.body);
// //       if (result['status'] == 'OK') {
// //         final components =
// //             result['result']['FindPlacesOnMap_components'] as List<dynamic>;
// //         // build result
// //         final place = Place();
// //         components.forEach((c) {
// //           final List type = c['types'];
// //           if (type.contains('street_number')) {
// //             place.streetNumber = c['long_name'];
// //           }
// //           if (type.contains('route')) {
// //             place.street = c['long_name'];
// //           }
// //           if (type.contains('locality')) {
// //             place.city = c['long_name'];
// //           }
// //           if (type.contains('postal_code')) {
// //             place.zipCode = c['long_name'];
// //           }
// //         });
// //         return place;
// //       }
// //       throw Exception(result['error_message']);
// //     } else {
// //       throw Exception('Failed to fetch suggestion');
// //     }
// //   }
// // }
