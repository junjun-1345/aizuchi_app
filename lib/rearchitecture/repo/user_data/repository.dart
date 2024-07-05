import 'package:aizuchi_app/rearchitecture/domain/user_data/entity.dart';
import 'package:aizuchi_app/rearchitecture/provider/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository.g.dart';

@Riverpod(keepAlive: true)
class UserDataRepo extends _$UserDataRepo {
  FirebaseFirestore get db => ref.read(firestoreProvider);
  CollectionReference<UserData> get collection => ref
      .read(firestoreProvider)
      .collection(UserData.collectionName)
      .withConverter<UserData>(
        fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson(),
      );

  @override
  void build() {}

  Future<UserData> getCurrentUserData() async => collection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (value.data() == null) {
          throw ArgumentError('データが存在しません');
        }
        return value.data()!;
      });
}
