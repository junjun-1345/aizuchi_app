import 'package:aizuchi_app/rearchitecture/domain/user/entity.dart';
import 'package:aizuchi_app/rearchitecture/repositiory/provider/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore.g.dart';

@Riverpod(keepAlive: true)
class FirestoreRepository extends _$FirestoreRepository {
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

  Future<UserData> getUser() async => collection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (value.data() == null) {
          throw ArgumentError('データが存在しません');
        }
        return value.data()!;
      });
}


// TODO: 再利用可能にした。余計ややこしいのか?