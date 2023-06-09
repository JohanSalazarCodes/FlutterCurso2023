import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchInBrowser(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    if (!await launchUrl(
      Uri.parse(scan.valor),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch ${scan.valor}');
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
