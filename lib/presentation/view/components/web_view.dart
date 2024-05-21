import 'package:aizuchi_app/presentation/view/components/app_appbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class WebViewPage extends HookConsumerWidget {
  const WebViewPage({required this.uri, super.key});

  final Uri uri;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useState(WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            const CircularProgressIndicator();
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(uri));
    return Scaffold(
      appBar: const AppAppBar(),
      body: WebViewWidget(controller: controller.value),
    );
  }
}
