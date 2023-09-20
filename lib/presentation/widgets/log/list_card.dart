import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:aizuchi_app/presentation/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListCard extends ConsumerWidget {
  const ListCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logUsecase = ref.read(logUsecaseProvider);

    final weekDateTitleList = [];

    logUsecase.getThisWeekTitles().then(
      (value) {
        weekDateTitleList.add(value);
      },
    );

    Widget cardWidetContainer(int ci, String title) {
      final nowWeekDayList = CustomDateTime().nowWeekDays();
      return Container(
        height: 48,
        decoration: BoxDecoration(
          color: BrandColor.baseLight,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 4,
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: BrandColor.baseRed,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(nowWeekDayList[ci],
                  textAlign: TextAlign.center,
                  style: BrandText.textLBold.copyWith(color: Colors.white)),
            ),
            SizedBox(
              width: 8,
            ),
            Flexible(
              child: Container(
                child: new Text(
                  title,
                  style: new TextStyle(fontSize: 12),
                ),
              ),
            )
          ],
        ),
      );
    }

    return Container(
      alignment: Alignment.center,
      // width: screenWidth * 0.8,
      // height: screenHeight * 0.5,
      decoration: BoxDecoration(
        color: BrandColor.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < 7; i++)
              FutureBuilder(
                future: logUsecase.getThisWeekTitles(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    // エラーメッセージの取得
                    final error = snapshot.error;
                    return cardWidetContainer(i, "$error");
                    // データがある場合
                  } else if (snapshot.hasData) {
                    // getResultメソッドがreturnした値を取得
                    final result = snapshot.data!;
                    return cardWidetContainer(i, result[i]);

                    // データ取得中の場合
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
          ],
        ),
      ),
    );
  }
}
