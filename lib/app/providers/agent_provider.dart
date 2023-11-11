import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grace_product_buyer/app/models/agent.dart';
import 'package:grace_product_buyer/app/utils/api.dart';
import 'package:grace_product_buyer/app/utils/request.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class AgentProvider extends ChangeNotifier {
  List<Agent> _agents = [];
  Set<Marker> _agentMarkers = {};
  bool _isLoading = false;

  List<Agent> get agents => _agents;
  bool get isLoading => _isLoading;
  Set<Marker> get agentMarkers => _agentMarkers;

  Future<void> getAgents() async {
    _isLoading = true;
    notifyListeners();

    try {
      LocationData locationData = await getLocationData();

      var endpoint =
          "${Api.agents}?latitude=${locationData.latitude}&longitude=${locationData.longitude}";

      http.Response response = await Request.get(endpoint);

      _isLoading = false;

      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);

        List<Agent> agents = getAgentsFromjson(apiResponse['data']);

        _agents = agents;

        setAgentMarkers();
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  void setAgentMarkers() {
    Set<Marker> markers = {};
    if (_agents.isNotEmpty) {
      for (var agent in _agents) {
        Marker marker = Marker(
          markerId: MarkerId("${agent.id}"),
          icon: BitmapDescriptor.defaultMarker,
          position: const LatLng(0, 0),
          infoWindow: InfoWindow(
            title: agent.name,
          ),
        );

        markers.add(marker);
      }
    }

    _agentMarkers = markers;
  }

  Future<LocationData> getLocationData() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    locationData = await location.getLocation();

    return locationData;
  }
}
