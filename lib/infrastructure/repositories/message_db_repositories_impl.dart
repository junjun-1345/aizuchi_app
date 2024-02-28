import 'package:aizuchi_app/domain/entity/enums/message.dart';
import 'package:aizuchi_app/domain/entity/models/message.dart';
import 'package:aizuchi_app/domain/repositories/message_db_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageDBRepositoryImpl implements MessageDBRepository {
  static final id = FirebaseAuth.instance.currentUser?.uid ?? '';
  @override
  Future<void> create(MessageEntity entity) async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection("messages")
          .doc()
          .set(
        {
          "id": entity.id,
          "createdAt": Timestamp.fromDate(entity.createdAt),
          "content": entity.content,
          "type": entity.type.value,
        },
      );
    } on FirebaseException catch (e) {
      // Firestoreからデータを取得する際にFirebaseExceptionが発生した場合の処理
      print(e.message);
      throw Exception('Firestoreにデータを作成できませんでした。');
    } catch (e) {
      // その他の例外が発生した場合の処理
      print(e.toString());
      throw Exception('データの作成中に未知のエラーが発生しました。');
    }
  }

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<MessageEntity>> readAll() async {
    final id = FirebaseAuth.instance.currentUser?.uid ?? '';
    try {
      final List<MessageEntity> messages = [];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection("messages")
          .orderBy("createdAt")
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          final newMessage = MessageEntity(
              id: doc['id'].toString(),
              createdAt: doc['createdAt'].toDate(),
              content: doc['content'].toString(),
              type: MessageTypeExtension.from(doc['type']));
          messages.add(newMessage);
        }
      });

      return messages;
    } on FirebaseException catch (e) {
      // Firestoreからデータを取得する際にFirebaseExceptionが発生した場合の処理
      print(e.message);
      throw Exception('Firestoreからデータを取得できませんでした。');
    } catch (e) {
      // その他の例外が発生した場合の処理
      print(e.toString());
      throw Exception('データの取得中に未知のエラーが発生しました。');
    }
  }

  @override
  Future<void> update(MessageEntity form) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('messages')
          .get()
          .then((querySnapshot) {
        for (var document in querySnapshot.docs) {
          batch.delete(document.reference);
        }
      });
      await batch.commit();
    } on FirebaseException catch (e) {
      print(e.message);
      throw Exception('Firestoreのコレクションを削除できませんでした。');
    } catch (e) {
      print(e.toString());
      throw Exception('データの削除中に未知のエラーが発生しました。');
    }
  }
}
