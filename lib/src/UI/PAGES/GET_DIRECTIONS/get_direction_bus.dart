import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UI/PAGES/GET_DIRECTIONS/direction_bus_modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    @required LatLng? origin,
    @required LatLng? destination,
  }) async {
    var response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin!.latitude},${origin.longitude}',
        'destination': '${destination!.latitude},${destination.longitude}',
        // 'key': "AIzaSyDvoRtb4WZ9Kb9svm1pbQSWNt6QsULBRto",
        'key': "AIzaSyDSSz6a9VozdJv0GMelqNMp2tY3UpnvSGU",
      },
    );

    print("response ${response.data}");
    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    throw NO_RECORD_FOUND;
  }
}
