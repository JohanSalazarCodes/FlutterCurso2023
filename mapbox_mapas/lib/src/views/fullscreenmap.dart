import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController? mapController;
  final center = LatLng(7.936008, -72.508822);
  String selectedStyle =
      'mapbox://styles/handrew/clinvzkm801eq01p7cbl817mh/draft';
  final streetStyle = 'mapbox://styles/handrew/clinvzkm801eq01p7cbl817mh/draft';
  final oscuroStyle = 'mapbox://styles/handrew/clinvxd9w00j101qweft0d8yl';
  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset('assetImage', 'assets/custom-icon.png');
    addImageFromUrl('networkImage', 'https://via.placeholder.com/50');
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController?.addImage(name, list);
  }

  Future<void> addImageFromUrl(String name, String url) async {
    var response = await http.get(Uri.parse(url));
    return mapController?.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: BotonesFlotantes(),
    );
  }

  Column BotonesFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            mapController?.addSymbol(SymbolOptions(
                geometry: center,
                //iconSize: 3,
                iconImage: 'assetImage', //'attraction-15',
                textField: 'Montaña creada aqui',
                textOffset: const Offset(0, 2)));
          },
          child: const Icon(Icons.sentiment_very_dissatisfied),
        ),
        const SizedBox(
          height: 5,
        ),
        FloatingActionButton(
          onPressed: () {
            mapController?.animateCamera(CameraUpdate.zoomIn());
          },
          child: const Icon(Icons.zoom_in),
        ),
        const SizedBox(
          height: 5,
        ),
        FloatingActionButton(
          onPressed: () {
            mapController?.animateCamera(CameraUpdate.zoomOut());
          },
          child: const Icon(Icons.zoom_out),
        ),
        const SizedBox(
          height: 5,
        ),
        FloatingActionButton(
          child: const Icon(Icons.add_to_home_screen),
          onPressed: () {
            if (selectedStyle == oscuroStyle) {
              selectedStyle = streetStyle;
            } else {
              selectedStyle = oscuroStyle;
            }
            _onStyleLoaded();
            setState(() {});
          },
        )
      ],
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
        styleString: selectedStyle,
        accessToken:
            'sk.eyJ1IjoiaGFuZHJldyIsImEiOiJjbGludjNtYjUwMnYzM2pwZ3hsNGVpbjF1In0.RORKbYAnwjzi_p1AafdA0w',
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(zoom: 14, target: center));
  }
}
