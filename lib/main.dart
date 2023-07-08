import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_intesco/my_app.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]
      ).then((_) => runApp(const MyApp()));
    },
    (error, st) {
      print(error);
      print(st);
    },
  );
}
