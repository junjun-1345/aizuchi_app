import 'package:aizuchi_app/rearchitecture/domain/message/entity.dart';
import 'package:aizuchi_app/rearchitecture/domain/user_data/entity.dart';
import 'package:aizuchi_app/rearchitecture/provider/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository.g.dart';

@Riverpod(keepAlive: true)
class MessageRepo extends _$MessageRepo {
  FirebaseFirestore get db => ref.read(firestoreProvider);
  CollectionReference<Message> get collection => ref
      .read(firestoreProvider)
      .collection(UserData.collectionName)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(Message.collectionName)
      .withConverter<Message>(
        fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson(),
      );

  @override
  void build() {}

  Future<List<Message>> getMessages() async => [
        ...await collection
            .limit(10)
            .get()
            .then((value) => value.docs.map((e) => e.data()).toList()),
      ];
}
