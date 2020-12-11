import 'package:flutter/widgets.dart';
import 'package:navigation_test_2/navigation/paths.dart';

class RootRouteInformationParser
    extends RouteInformationParser<NavigationPath> {
  @override
  Future<NavigationPath> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return BookListPath();
  }
}
