import 'package:aizuchi_app/application/state/firestore.dart';
import 'package:aizuchi_app/application/state/todaykey.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatWidget extends HookConsumerWidget {
  const ChatWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyKeyState = ref.watch(todaykeyNotifierProvider);

    final id = FirebaseAuth.instance.currentUser?.uid ?? '';

    print("$dailyKeyState");

    final Stream<QuerySnapshot> _fetchMessageStream = FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("messages")
        .orderBy('createdAt')
        .where("dailyKey", isEqualTo: dailyKeyState)
        .snapshots();

    final screenWidth = MediaQuery.of(context).size.width;

    //
    // ユーザーチャットコンテント
    //
    Widget userChatContent(String message) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.8,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: BrandColor.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 7,
                  horizontal: 16,
                ),
                child: Text(message
                    // style: BrandText.bodyM,
                    ),
              ),
            ),
          ),
        ),
      );
    }

    //
    // アシスタントチャットコンテント
    //
    Widget assistantChatContent(String message) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.7,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: BrandColor.baseRed,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: BrandColor.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _fetchMessageStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  if (data['role'] == "user") {
                    return userChatContent(data['content']);
                  }
                  if (data['role'] == "assistant") {
                    return assistantChatContent(data['content']);
                  }
                  return SizedBox();
                })
                .toList()
                .cast(),
          );
        } else if (snapshot.hasError) {
          return Text('Something went wrong　${snapshot.error}');
        } else {
          return Container(
            width: 64,
            height: 64,
            child: const SizedBox(
              width: 64,
              height: 64,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
