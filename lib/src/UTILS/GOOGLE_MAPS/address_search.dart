// import 'package:campus_pro/src/UTILS/GOOGLE_MAPS/place_service.dart';
// import 'package:flutter/material.dart';

// class AddressSearch extends SearchDelegate<Suggestion> {
//   final sessionToken;
//   PlaceApiProvider? apiClient;

//   AddressSearch(this.sessionToken) {
//     apiClient = PlaceApiProvider(sessionToken);
//   }

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = "";
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {},
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return SizedBox.shrink();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return FutureBuilder(
//       // We will put the api call here
//       future: null,
//       builder: (context, snapshot) => query == ''
//           ? Container(
//               padding: EdgeInsets.all(16.0),
//               child: Text('Enter your address'),
//             )
//           : snapshot.hasData
//               ? ListView.builder(
//                   itemBuilder: (context, index) => ListTile(
//                     // we will display the data returned from our future here
//                     title: Text("description"),
//                     // title: Text((snapshot.data![index] as Suggestion).description),
//                     onTap: () {
//                       // close(context, snapshot.data[index]);
//                     },
//                   ),
//                   itemCount: 1,
//                   // itemCount: snapshot.data.length,
//                 )
//               : Container(child: Text('Loading...')),
//     );
//     // return FutureBuilder(
//     //   future: query == "" ? null : apiClient!.fetchSuggestions(query),
//     //   builder: (context, snapshot) => query == ""
//     //       ? Container(
//     //           child: Text("search here"),
//     //         )
//     //       : snapshot.hasData
//     //           ? ListView.builder(
//     //               itemBuilder: (context, i) => ListTile(
//     //                 title: Text((snapshot.data![i] as Suggestion).description),
//     //               ),
//     //               itemCount: snapshot.data!.length,
//     //             )
//     //           : Container(child: CircularProgressIndicator(),),
//     // );
//   }
// }
