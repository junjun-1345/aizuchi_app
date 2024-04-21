import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 50.0,
          ),
          const SizedBox(height: 10.0),
          const Text(
            'エラーが発生しました',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            // goRouterなど使っている場合、initialRouteに遷移などして対策
            // popでも良い
            onPressed: () => AutoRouter.of(context).maybePop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
