import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/view/components/drawer_content.dart';
import 'package:aizuchi_app/presentation/view/pages/calender/components/calendar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class CalenderPage extends HookConsumerWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarUsecase = ref.read(calendarUsecaseProvider);
    final currentIndexState = useState(0);
    //再描画防止
    final items = useMemoized(
      () {
        return List.generate(
            13,
            (index) => SingleChildScrollView(
                  child: Calendar(
                    key: ValueKey(index),
                    diffMonth: index,
                    isWeekStartMonday: false,
                  ),
                ));
      },
    );

    return Scaffold(
      drawer: const HamburgerMenu(),
      drawerScrimColor: BrandColor.base,
      appBar: AppBar(
        title: const Text(
          "カレンダー",
          style: TextStyle(fontSize: 20, color: BrandColor.textBlack),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BrandColor.textBlack),
      ),
      body: Column(
        children: [
          Text(
            "${calendarUsecase.calculatedDate(currentIndexState.value).year}",
            style: const TextStyle(
              color: BrandColor.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${calendarUsecase.calculatedDate(currentIndexState.value).month}",
            style: const TextStyle(
              color: BrandColor.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.6,
              reverse: true,
              onPageChanged: (index, reason) {
                currentIndexState.value = index;
              },
              enableInfiniteScroll: false,
              padEnds: true,
              viewportFraction: 1,
            ),
            items: items,
          ),
        ],
      ),
    );
  }
}
