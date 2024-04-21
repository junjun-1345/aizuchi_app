import 'package:aizuchi_app/domain/entity/enums/vertical.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:aizuchi_app/presentation/view/components/attention_dialog.dart';
import 'package:aizuchi_app/presentation/view_model/users_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class HamburgerMenu extends ConsumerWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: BrandColor.base,
          padding: const EdgeInsets.fromLTRB(16, 56, 16, 24),
          child: Column(
            children: <Widget>[
              _buildPromoSection(context),
              const SizedBox(height: 24),
              _buildFeatureSection(context),
              const SizedBox(height: 24),
              _buildAccountSection(context),
              const SizedBox(height: 24),
              _buildCustomizeSection(context),
              const SizedBox(height: 24),
              _buildServiceSection(context),
              const SizedBox(height: 36),
              _buildLogOutSection(context, ref),
              const SizedBox(height: 24),
              _buildAccountDeletionSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoSection(BuildContext context) {
    return Column(
      children: [
        _buildPromoBanner(context),
      ],
    );
  }

  Widget _buildFeatureSection(BuildContext context) {
    return _buildSectionItem(
      title: "キャラクター選択",
      icon: Icons.access_alarm,
      onTap: () {},
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return Column(
      children: [
        _buildSectionTitle("アカウント"),
        _buildSectionItem(
          title: "認証連携",
          icon: Icons.manage_accounts_sharp,
          onTap: () {},
          verticalType: VerticalType.top,
        ),
        _buildSectionItem(
          title: "プロフィール",
          icon: Icons.account_circle,
          onTap: () {},
          verticalType: VerticalType.none,
        ),
        _buildSectionItem(
          title: "加入プラン",
          icon: Icons.confirmation_number,
          onTap: () {
            context.router.push(
              const PlanRoute(),
            );
          },
          verticalType: VerticalType.bottom,
        ),
        _buildSectionItem(
          title: "メールアドレス",
          icon: Icons.mail,
          onTap: () {
            context.router.push(
              const MailConfrimRoute(),
            );
          },
          verticalType: VerticalType.none,
        ),
        _buildSectionItem(
          title: "パスワード",
          icon: Icons.lock,
          onTap: () {},
          verticalType: VerticalType.none,
        ),
      ],
    );
  }

  Widget _buildCustomizeSection(BuildContext context) {
    return Column(
      children: [
        _buildSectionTitle("カスタマイズ"),
        _buildSectionItem(
          title: "通知設定",
          icon: Icons.notifications_active,
          onTap: () {},
          verticalType: VerticalType.top,
        ),
        _buildSectionItem(
          title: "端末ロック",
          icon: Icons.lock,
          onTap: () {},
          verticalType: VerticalType.none,
        ),
        _buildSectionItem(
          title: "ヘルスケア連携",
          icon: Icons.favorite_sharp,
          onTap: () {},
          verticalType: VerticalType.bottom,
        ),
      ],
    );
  }

  Widget _buildServiceSection(BuildContext context) {
    final Uri urlContact = Uri.parse('https://aizuchi-log.studio.site/contact');
    final Uri urlTerm = Uri.parse('https://aizuchi-log.studio.site/terms');
    final Uri urlPrivacyPolicy =
        Uri.parse('https://aizuchi-log.studio.site/privacypolicy');

    return Column(
      children: [
        _buildSectionTitle("その他"),
        _buildSectionItem(
          title: "ご意見・お問い合わせ",
          icon: Icons.textsms,
          onTap: () => launchUrl(urlContact),
          verticalType: VerticalType.top,
          isLink: true,
        ),
        _buildSectionItem(
          title: "バグや障害状況（X）",
          icon: Icons.campaign,
          onTap: () => launchUrl(urlPrivacyPolicy),
          verticalType: VerticalType.bottom,
          isLink: true,
        ),
        _buildSectionItem(
          title: "FAQ",
          icon: Icons.priority_high,
          onTap: () => launchUrl(urlPrivacyPolicy),
          verticalType: VerticalType.bottom,
          isLink: true,
        ),
        _buildSectionItem(
          title: "規約",
          icon: Icons.assignment,
          onTap: () => launchUrl(urlTerm),
          verticalType: VerticalType.none,
          isLink: true,
        ),
        _buildSectionItem(
          title: "プライバシーポリシー",
          icon: Icons.error,
          onTap: () => launchUrl(urlPrivacyPolicy),
          verticalType: VerticalType.bottom,
          isLink: true,
        ),
        _buildSectionItem(
          title: "このアプリを友だちに知らせる",
          icon: Icons.arrow_circle_left,
          onTap: () => launchUrl(urlPrivacyPolicy),
          verticalType: VerticalType.bottom,
          isLink: true,
        ),
        _buildSectionItem(
          title: "Instagramをフォローする",
          icon: Icons.arrow_circle_left,
          onTap: () => launchUrl(urlPrivacyPolicy),
          verticalType: VerticalType.bottom,
          isLink: true,
        ),
        _buildSectionItem(
          title: "ライセンス",
          icon: Icons.arrow_circle_left,
          onTap: () => launchUrl(urlPrivacyPolicy),
          verticalType: VerticalType.bottom,
          isLink: true,
        ),
      ],
    );
  }

  Widget _buildLogOutSection(BuildContext context, WidgetRef ref) {
    return _buildSectionButton(
      text: "ログアウト",
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AttentionDialog(
          title: 'ログアウト',
          content: 'ログアウトします。\nよろしいですか？',
          onPressed: () {
            ref.read(userViewModelProvider).signOut();
            context.router.replace(const SignInRoute());
          },
        ),
      ),
    );
  }

  Widget _buildAccountDeletionSection(BuildContext context) {
    return _buildSectionButton(
      text: "アカウント削除",
      isAttentionColorRed: true,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AttentionDialog(
          title: 'アカウント削除',
          content: 'アカウントを削除します。\nよろしいですか？',
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: BrandColor.baseRed,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "はじめの７日間無料",
                style: TextStyle(
                    color: BrandColor.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
              ),
              AppButton.base(
                width: 200,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(200),
                  foregroundColor: BrandColor.baseRed,
                  backgroundColor: BrandColor.white,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  context.router.push(const PurchaseRoute());
                },
                text: 'プレミアム　>',
                textStyle: TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "プレミアムプランでは、無制限でのチャット、無制限のストレス測定など豊富な機能をおつかいいただけます。",
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSectionItem({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
    VerticalType verticalType = VerticalType.all,
    bool isLink = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.black.withOpacity(0.2),
        highlightColor: Colors.black.withOpacity(0.1),
        borderRadius: VerticalExtension.verticalValues[verticalType],
        child: Ink(
          decoration: BoxDecoration(
            color: BrandColor.white,
            borderRadius: VerticalExtension.verticalValues[verticalType],
          ),
          height: 40,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon),
                  const SizedBox(width: 4),
                  Text(title),
                ],
              ),
              Icon(
                isLink ? Icons.north_east : Icons.arrow_forward_ios,
                color: BrandColor.baseRed,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildSectionButton(
      {required String text,
      required VoidCallback onPressed,
      bool isAttentionColorRed = false}) {
    return Container(
      decoration: BoxDecoration(
        color: BrandColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: isAttentionColorRed ? BrandColor.red : BrandColor.black,
          ),
        ),
      ),
    );
  }
}
