import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/domain/repositories/remote_config.dart';
import 'package:aizuchi_app/infrastructure/data_model.dart';
import 'package:aizuchi_app/infrastructure/enums/remote_config_key.dart';
import 'package:aizuchi_app/presentation/model/search_page_model.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/components/drawer_content.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RemoteConfigRepository remoteConfigRepository =
        ref.read(remoteConfigRepositoryProvider);

    return Scaffold(
      drawer: const HamburgerMenu(),
      drawerScrimColor: BrandColor.base,
      appBar: AppBar(
        title: const Text(
          "調べる",
          style: TextStyle(fontSize: 20, color: BrandColor.textBlack),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BrandColor.textBlack),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder<SearchData>(
            future: _fetchData(remoteConfigRepository),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return _errorContent("エラーが発生しました: ${snapshot.error}");
              } else if (!snapshot.hasData) {
                return _errorContent("データが存在しません。");
              } else if (snapshot.data == null) {
                return _errorContent("データはnullです。");
              }
              final data = snapshot.data!;
              return Column(
                children: [
                  if (data.urlsFlag)
                    _menuContent(
                      title: "カウンセリング",
                      onSearch: () => context.router.push(
                          WebViewRoute(uri: Uri.parse(data.counselingUrl))),
                    ),
                  const SizedBox(height: 16),
                  if (data.urlsFlag)
                    _menuContent(
                      title: "占い",
                      onSearch: () => context.router.push(
                          WebViewRoute(uri: Uri.parse(data.divinationUrl))),
                    ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<SearchData> _fetchData(
      RemoteConfigRepository remoteConfigRepository) async {
    final counselingUrl = await remoteConfigRepository
        .fetch<String>(RemoteConfigKey.searchPageCounselingUrl);
    final divinationUrl = await remoteConfigRepository
        .fetch<String>(RemoteConfigKey.searchPageDivinationUrl);
    final urlsFlag = await remoteConfigRepository
        .fetch<bool>(RemoteConfigKey.searchPageUrlsFlag);

    if (counselingUrl == null || divinationUrl == null || urlsFlag == null) {
      throw Exception('Failed to fetch data from RemoteConfigRepository');
    }

    return SearchData(
        counselingUrl: counselingUrl,
        divinationUrl: divinationUrl,
        urlsFlag: urlsFlag);
  }

  Widget _menuContent({
    required String title,
    required void Function() onSearch,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: BrandColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 140,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          AppButton.smallIcon(
            width: 160,
            height: 32,
            onPressed: onSearch,
            text: '探す',
            iconData: Icons.search,
            textStyle: const TextStyle(
                fontWeight: FontWeight.w800, color: BrandColor.white),
          )
        ],
      ),
    );
  }

  // エラーハンドリング用のコンテンツ
  Widget _errorContent(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 18, color: Colors.red),
      ),
    );
  }
}
