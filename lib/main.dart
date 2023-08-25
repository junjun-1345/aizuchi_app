import 'package:aizuchi_app/firebase_options.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Tokyo"));

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  const app = MyApp();
  const scope = ProviderScope(child: app);
  runApp(scope);
}
