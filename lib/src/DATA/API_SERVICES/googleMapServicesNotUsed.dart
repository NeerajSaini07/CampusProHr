import 'dart:convert';

const apiKey = "AIzaSyDvoRtb4WZ9Kb9svm1pbQSWNt6QsULBRto";

class GoogleMapsServicesApi {
  Future<String> getRouteCoordinates() async {
    // String url =
    //     "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    // print('Map URL Hit: $url');
    // http.Response response = await http.get(Uri.parse(url));
    String jsonData = jsonDecode(jsonString);
    var decodeData = jsonDecode(jsonData);
    // print("====================>>>>>>>>${values}");
    throw decodeData;
    // return values["routes"][0]["overview_polyline"]["points"];
    // return values["routes"][0]["overview_polyline"]["points"];
  }
}

String jsonString = '''
{
   "plus_code" : {
      "compound_code" : "P27Q+MC New York, NY, USA",
      "global_code" : "87G8P27Q+MC"
   },
   "results" : [
      {
         "address_components" : [
            {
               "long_name" : "279",
               "short_name" : "279",
               "types" : [ "street_number" ]
            },
            {
               "long_name" : "Bedford Avenue",
               "short_name" : "Bedford Ave",
               "types" : [ "route" ]
            },
            {
               "long_name" : "Williamsburg",
               "short_name" : "Williamsburg",
               "types" : [ "neighborhood", "political" ]
            },
            {
               "long_name" : "Brooklyn",
               "short_name" : "Brooklyn",
               "types" : [ "political", "sublocality", "sublocality_level_1" ]
            },
            {
               "long_name" : "Kings County",
               "short_name" : "Kings County",
               "types" : [ "administrative_area_level_2", "political" ]
            },
            {
               "long_name" : "New York",
               "short_name" : "NY",
               "types" : [ "administrative_area_level_1", "political" ]
            },
            {
               "long_name" : "United States",
               "short_name" : "US",
               "types" : [ "country", "political" ]
            },
            {
               "long_name" : "11211",
               "short_name" : "11211",
               "types" : [ "postal_code" ]
            }
         ],
         "formatted_address" : "279 Bedford Ave, Brooklyn, NY 11211, USA",
         "geometry" : {
            "location" : {
               "lat" : 40.7142484,
               "lng" : -73.9614103
            },
            "location_type" : "ROOFTOP",
            "viewport" : {
               "northeast" : {
                  "lat" : 40.71559738029149,
                  "lng" : -73.9600613197085
               },
               "southwest" : {
                  "lat" : 40.71289941970849,
                  "lng" : -73.96275928029151
               }
            }
         },
         "place_id" : "ChIJT2x8Q2BZwokRpBu2jUzX3dE",
         "plus_code" : {
            "compound_code" : "P27Q+MC Brooklyn, New York, United States",
            "global_code" : "87G8P27Q+MC"
         },
         "types" : [
            "bakery",
            "cafe",
            "establishment",
            "food",
            "point_of_interest",
            "store"
         ]
      },
   ],
   "status" : "OK"
}
''';
