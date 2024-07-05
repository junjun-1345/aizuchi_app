import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final firebaseAuthProvider = Provider((ref) => auth.FirebaseAuth.instance);
