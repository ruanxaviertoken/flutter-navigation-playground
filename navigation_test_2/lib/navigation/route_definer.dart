import 'package:flutter/widgets.dart';
import 'package:navigation_test_2/navigation/paths.dart';

class RouteDefiner {
  RouteDefiner._();
  static final RouteDefiner instance = RouteDefiner._();

  final Map<dynamic, dynamic> builderMap = Map();

  void defineRoute<T extends NavigationPath>(Widget Function(T path) builder) {
    builderMap.addAll({T: builder});
  }
}