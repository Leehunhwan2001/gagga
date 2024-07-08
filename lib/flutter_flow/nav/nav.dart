import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gagga/models/institution.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';
import '/param_type.dart'; 


export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

enum ParamType {
  String,
  Int,
  Double,
  Bool,
  DateTime,
  LatLng,
  Place,
  Json,
  List, // 이 부분을 추가하세요
}

dynamic deserializeParam<T>(String param, ParamType type, {bool isList = false}) {
  switch (type) {
    case ParamType.String:
      return param;
    case ParamType.Int:
      return int.parse(param);
    case ParamType.Double:
      return double.parse(param);
    case ParamType.Bool:
      return param.toLowerCase() == 'true';
    case ParamType.DateTime:
      return DateTime.parse(param);
    case ParamType.LatLng:
      // 여기에 LatLng 관련 로직 추가
      return;
    case ParamType.Place:
      // 여기에 Place 관련 로직 추가
      return;
    case ParamType.Json:
      return jsonDecode(param);
    case ParamType.List:
      List<dynamic> jsonList = jsonDecode(param);
      // 각 아이템을 Institution 객체로 변환
      return jsonList.map((e) => Institution.fromJson(e as Map<String, dynamic>)).toList();
    default:
      throw Exception('Unknown ParamType: $type');
  }
}


GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  refreshListenable: appStateNotifier,
  errorBuilder: (context, state) => BeginWidget(),
  routes: [
    FFRoute(
      name: '_initialize',
      path: '/',
      builder: (context, params) => BeginWidget(),
    ),
    FFRoute(
      name: 'Begin',
      path: '/begin',
      builder: (context, params) => BeginWidget(),
    ),
    FFRoute(
      name: 'Detail1',
      path: '/detail1',
      builder: (context, params) => Detail1Widget(),
    ),
    FFRoute(
      name: 'Detail2',
      path: '/detail2',
      builder: (context, params) => Detail2Widget(
        filteredInstitutions: deserializeParam<List<Institution>>(
          params.getParam<String>('filteredInstitutions', ParamType.String)!,
          ParamType.List,
        ),
      ),
    ),
    FFRoute(
      name: 'Detail3',
      path: '/detail3',
      builder: (context, params) => Detail3Widget(
        filteredInstitutions: deserializeParam<List<Institution>>(
          params.getParam<String>('filteredInstitutions', ParamType.String)!,
          ParamType.List,
        ),
      ),
    ),
    FFRoute(
      name: 'Detail4',
      path: '/detail4',
      builder: (context, params) => Detail4Widget(
        filteredInstitutions: deserializeParam<List<Institution>>(
          params.getParam<String>('filteredInstitutions', ParamType.String)!,
          ParamType.List,
        ),
      ),
    ),
    FFRoute(
      name: 'Detail5',
      path: '/detail5',
      builder: (context, params) => Detail5Widget(
        filteredInstitutions: deserializeParam<List<Institution>>(
          params.getParam<String>('filteredInstitutions', ParamType.String)!,
          ParamType.List,
        ),
      ),
    ),
    FFRoute(
      name: 'Detail6',
      path: '/detail6',
      builder: (context, params) => Detail6Widget(
        filteredInstitutions: deserializeParam<List<Institution>>(
          params.getParam<String>('filteredInstitutions', ParamType.String)!,
          ParamType.List,
        ),
      ),
    ),
    FFRoute(
      name: 'Detail7',
      path: '/detail7',
      builder: (context, params) => Detail7Widget(
        filteredInstitutions: deserializeParam<List<Institution>>(
          params.getParam<String>('filteredInstitutions', ParamType.String)!,
          ParamType.List,
        ),
      ),
    ),
    FFRoute(
      name: 'Last',
      path: '/last',
      builder: (context, params) => LastWidget(
        filteredInstitutions: deserializeParam<List<Institution>>(
          params.getParam<String>('filteredInstitutions', ParamType.String)!,
          ParamType.List,
        ),
      ),
    ),
  ].map((r) => r.toRoute(appStateNotifier)).toList(),
);

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    if (param is! String) {
      return param;
    }
    return deserializeParam<T>(
      param,
      type,
      isList: isList,
    );
  }
}

  

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
