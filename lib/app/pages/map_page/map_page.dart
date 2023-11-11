import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grace_product_buyer/app/common/loader.dart';
import 'package:grace_product_buyer/app/providers/agent_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng target = const LatLng(-6.8059136, 39.2462336);

  static late CameraPosition _kGooglePlex;

  @override
  void initState() {
    _kGooglePlex = CameraPosition(
      target: target,
      zoom: 14.4765,
    );

    init();

    super.initState();
  }

  void init() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    setState(() {
      target = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
    });

    if (_controller.isCompleted) {
      var ctrl = await _controller.future;
      ctrl.moveCamera(CameraUpdate.newLatLng(target));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final agent = Provider.of<AgentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select near shop'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SizedBox(
        child: Stack(
          children: [
            Container(
              color: page,
              width: size.width * 1,
              height: size.height * 1,
              child: GoogleMap(
                zoomControlsEnabled: false,
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                markers: agent.agentMarkers,
                onMapCreated: (GoogleMapController controller) =>
                    _controller.complete(controller),
              ),
            ),
            // Positioned(
            //   bottom: size.height * 0.2,
            //   left: 0,
            //   right: 0,
            //   child: const Shop(),
            // ),
            // const Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: Modal(),
            // ),
            agent.isLoading ? const Loader() : const SizedBox()
          ],
        ),
      ),
    );
  }
}
