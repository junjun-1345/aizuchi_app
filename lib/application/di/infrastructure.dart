import 'package:aizuchi_app/application/interface/firebase/auth.dart';
import 'package:aizuchi_app/infrastructure/firebase/auth_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/firebase/firestore_imp.dart';
import '../interface/firebase/firestore.dart';

final authProvider = Provider<AuthInterface>((ref) {
  return AuthService();
});

final firestoreProvider = Provider<FirestoreInterface>((ref) {
  return FirestoreService();
});
