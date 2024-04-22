// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CalenderRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CalenderPage(),
      );
    },
    LimitMessageRoute.name: (routeData) {
      final args = routeData.argsAs<LimitMessageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LimitMessagePage(
          key: args.key,
          selectedDate: args.selectedDate,
        ),
      );
    },
    LogRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LogPage(),
      );
    },
    MailConfrimRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MailConfrimPage(),
      );
    },
    MeasurementRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MeasurementPage(),
      );
    },
    MessageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MessagePage(),
      );
    },
    PlanRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PlanPage(),
      );
    },
    PurchaseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PurchasePage(),
      );
    },
    RootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RootPage(),
      );
    },
    SearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SearchPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInPage(),
      );
    },
    SignUpFormBirthDateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpFormBirthDatePage(),
      );
    },
    SignUpFormCheckRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpFormCheckPage(),
      );
    },
    SignUpFormNameRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpFormNamePage(),
      );
    },
    SignUpFormSexRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpFormSexPage(),
      );
    },
    SignUpFormSurveyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpFormSurveyPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpPage(),
      );
    },
  };
}

/// generated route for
/// [CalenderPage]
class CalenderRoute extends PageRouteInfo<void> {
  const CalenderRoute({List<PageRouteInfo>? children})
      : super(
          CalenderRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalenderRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LimitMessagePage]
class LimitMessageRoute extends PageRouteInfo<LimitMessageRouteArgs> {
  LimitMessageRoute({
    Key? key,
    required DateTime selectedDate,
    List<PageRouteInfo>? children,
  }) : super(
          LimitMessageRoute.name,
          args: LimitMessageRouteArgs(
            key: key,
            selectedDate: selectedDate,
          ),
          initialChildren: children,
        );

  static const String name = 'LimitMessageRoute';

  static const PageInfo<LimitMessageRouteArgs> page =
      PageInfo<LimitMessageRouteArgs>(name);
}

class LimitMessageRouteArgs {
  const LimitMessageRouteArgs({
    this.key,
    required this.selectedDate,
  });

  final Key? key;

  final DateTime selectedDate;

  @override
  String toString() {
    return 'LimitMessageRouteArgs{key: $key, selectedDate: $selectedDate}';
  }
}

/// generated route for
/// [LogPage]
class LogRoute extends PageRouteInfo<void> {
  const LogRoute({List<PageRouteInfo>? children})
      : super(
          LogRoute.name,
          initialChildren: children,
        );

  static const String name = 'LogRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MailConfrimPage]
class MailConfrimRoute extends PageRouteInfo<void> {
  const MailConfrimRoute({List<PageRouteInfo>? children})
      : super(
          MailConfrimRoute.name,
          initialChildren: children,
        );

  static const String name = 'MailConfrimRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MeasurementPage]
class MeasurementRoute extends PageRouteInfo<void> {
  const MeasurementRoute({List<PageRouteInfo>? children})
      : super(
          MeasurementRoute.name,
          initialChildren: children,
        );

  static const String name = 'MeasurementRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MessagePage]
class MessageRoute extends PageRouteInfo<void> {
  const MessageRoute({List<PageRouteInfo>? children})
      : super(
          MessageRoute.name,
          initialChildren: children,
        );

  static const String name = 'MessageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PlanPage]
class PlanRoute extends PageRouteInfo<void> {
  const PlanRoute({List<PageRouteInfo>? children})
      : super(
          PlanRoute.name,
          initialChildren: children,
        );

  static const String name = 'PlanRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PurchasePage]
class PurchaseRoute extends PageRouteInfo<void> {
  const PurchaseRoute({List<PageRouteInfo>? children})
      : super(
          PurchaseRoute.name,
          initialChildren: children,
        );

  static const String name = 'PurchaseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpFormBirthDatePage]
class SignUpFormBirthDateRoute extends PageRouteInfo<void> {
  const SignUpFormBirthDateRoute({List<PageRouteInfo>? children})
      : super(
          SignUpFormBirthDateRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpFormBirthDateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpFormCheckPage]
class SignUpFormCheckRoute extends PageRouteInfo<void> {
  const SignUpFormCheckRoute({List<PageRouteInfo>? children})
      : super(
          SignUpFormCheckRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpFormCheckRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpFormNamePage]
class SignUpFormNameRoute extends PageRouteInfo<void> {
  const SignUpFormNameRoute({List<PageRouteInfo>? children})
      : super(
          SignUpFormNameRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpFormNameRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpFormSexPage]
class SignUpFormSexRoute extends PageRouteInfo<void> {
  const SignUpFormSexRoute({List<PageRouteInfo>? children})
      : super(
          SignUpFormSexRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpFormSexRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpFormSurveyPage]
class SignUpFormSurveyRoute extends PageRouteInfo<void> {
  const SignUpFormSurveyRoute({List<PageRouteInfo>? children})
      : super(
          SignUpFormSurveyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpFormSurveyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
