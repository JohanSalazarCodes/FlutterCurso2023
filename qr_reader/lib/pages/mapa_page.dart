import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null) {
      final ScanModel scan = arguments as ScanModel;

      final CameraPosition puntoInicial = CameraPosition(
        target: scan.getLatLng(),
        zoom: 17,
      );

      //Marcadores
      Set<Marker> markers = new Set<Marker>();
      markers.add(Marker(
          markerId: const MarkerId('geo-location'),
          position: scan.getLatLng()));

      return Scaffold(
        appBar: AppBar(
          title: const Text('Mapa'),
          actions: [
            IconButton(
                onPressed: () async {
                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: scan.getLatLng(), zoom: 17, tilt: 50)));
                },
                icon: const Icon(Icons.location_disabled))
          ],
        ),
        body: GoogleMap(
          mapType: mapType,
          initialCameraPosition: puntoInicial,
          markers: markers,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.layers),
          onPressed: () {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }
            setState(() {});
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('NO DATA')),
    );
  }
}
