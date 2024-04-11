import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/purchase/components/description.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/purchase/components/plan_list_contents.dart';
import 'package:aizuchi_app/presentation/view/pages/settings/purchase/components/title.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PurchasePage extends StatelessWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BrandColor.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                const PlanTitle(),
                const SizedBox(
                  height: 24,
                ),
                const PlanDescription(text: "AIキャラクターがあなたのお話を聞いてくれ、\n寄り添ってくれる"),
                const PlanDescription(text: "今日あった出来事をお話するだけで日記が完成！"),
                const PlanDescription(text: "AIに話す中で自分自身を客観視し、脳内の整理をサポート"),
                const PlanDescription(text: "定期的に自分のストレスレベルをチェックできる!"),
                const PlanDescription(text: "過去の感情がグラフに表示され、感情の分析をサポート"),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset('assets/images/mofumofu_icon_3.png'),
                ),
                const Text(
                  "AIzuchi Premium",
                  style: TextStyle(
                    color: BrandColor.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const PlanListContents(),
                // SizedBox(
                //   height: 24,
                // ),
                const Text("※無料トライアルは年額プランのみとなります。"),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
