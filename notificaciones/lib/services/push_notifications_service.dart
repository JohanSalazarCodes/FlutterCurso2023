//SHA1: 1F:CD:AD:66:25:2F:6D:A5:31:74:32:C8:9D:1C:E2:2A:F3:44:6F:21

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.onBackgroundMessage(_onMessageHandler);
    FirebaseMessaging.onMessage.listen(_backgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStreams() {
    _messageStream.close();
  }
}


/*
> Task :app:signingReport
Variant: debug
Config: debug
Store: C:\Users\jsalazar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: C1:16:69:75:65:2D:FA:4D:26:80:07:C5:AB:6A:8E:3C
SHA1: 1F:CD:AD:66:25:2F:6D:A5:31:74:32:C8:9D:1C:E2:2A:F3:44:6F:21
SHA-256: 99:7F:92:2E:5A:A7:CA:E3:81:C2:CD:7A:F1:F7:5B:4B:42:7C:26:E8:7E:21:25:99:5B:C0:8A:95:A4:63:89:8E
Valid until: Tuesday, April 22, 2053
----------
Variant: release
Config: debug
Store: C:\Users\jsalazar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: C1:16:69:75:65:2D:FA:4D:26:80:07:C5:AB:6A:8E:3C
SHA1: 1F:CD:AD:66:25:2F:6D:A5:31:74:32:C8:9D:1C:E2:2A:F3:44:6F:21
SHA-256: 99:7F:92:2E:5A:A7:CA:E3:81:C2:CD:7A:F1:F7:5B:4B:42:7C:26:E8:7E:21:25:99:5B:C0:8A:95:A4:63:89:8E
Valid until: Tuesday, April 22, 2053
----------
Variant: profile
Config: debug
Store: C:\Users\jsalazar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: C1:16:69:75:65:2D:FA:4D:26:80:07:C5:AB:6A:8E:3C
SHA1: 1F:CD:AD:66:25:2F:6D:A5:31:74:32:C8:9D:1C:E2:2A:F3:44:6F:21
SHA-256: 99:7F:92:2E:5A:A7:CA:E3:81:C2:CD:7A:F1:F7:5B:4B:42:7C:26:E8:7E:21:25:99:5B:C0:8A:95:A4:63:89:8E
Valid until: Tuesday, April 22, 2053
----------
Variant: debugAndroidTest
Config: debug
Store: C:\Users\jsalazar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: C1:16:69:75:65:2D:FA:4D:26:80:07:C5:AB:6A:8E:3C
SHA1: 1F:CD:AD:66:25:2F:6D:A5:31:74:32:C8:9D:1C:E2:2A:F3:44:6F:21
SHA-256: 99:7F:92:2E:5A:A7:CA:E3:81:C2:CD:7A:F1:F7:5B:4B:42:7C:26:E8:7E:21:25:99:5B:C0:8A:95:A4:63:89:8E
Valid until: Tuesday, April 22, 2053
----------

> Task :firebase_core:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\jsalazar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: C1:16:69:75:65:2D:FA:4D:26:80:07:C5:AB:6A:8E:3C
SHA1: 1F:CD:AD:66:25:2F:6D:A5:31:74:32:C8:9D:1C:E2:2A:F3:44:6F:21
SHA-256: 99:7F:92:2E:5A:A7:CA:E3:81:C2:CD:7A:F1:F7:5B:4B:42:7C:26:E8:7E:21:25:99:5B:C0:8A:95:A4:63:89:8E
Valid until: Tuesday, April 22, 2053
----------

> Task :firebase_messaging:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\jsalazar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: C1:16:69:75:65:2D:FA:4D:26:80:07:C5:AB:6A:8E:3C
SHA1: 1F:CD:AD:66:25:2F:6D:A5:31:74:32:C8:9D:1C:E2:2A:F3:44:6F:21
SHA-256: 99:7F:92:2E:5A:A7:CA:E3:81:C2:CD:7A:F1:F7:5B:4B:42:7C:26:E8:7E:21:25:99:5B:C0:8A:95:A4:63:89:8E
Valid until: Tuesday, April 22, 2053
----------
 */