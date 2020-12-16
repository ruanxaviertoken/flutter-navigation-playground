import 'package:flutter/widgets.dart';
import 'package:navigation_test_2/navigation/navigation_factories.dart';

class RootRouteInformationParser
    extends RouteInformationParser<NavigationFactory> {
  @override
  Future<NavigationFactory> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return BookListFactory();
  }
}
