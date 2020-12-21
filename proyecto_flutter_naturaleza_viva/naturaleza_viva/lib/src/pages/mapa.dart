import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatefulWidget {

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition puntoInicial = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
}