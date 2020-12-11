import 'package:flutter/material.dart';
import 'package:navigation_test_2/navigation/delegate/root_router_delegate.dart';
import 'package:navigation_test_2/navigation/information_parser/root_route_information_parser.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NavigationState navigationState = NavigationState.instance;
  RootRouterDelegate _routerDelegate;
  RootRouteInformationParser _informationParser = RootRouteInformationParser();

  @override
  void didChangeDependencies() {
    _routerDelegate = RootRouterDelegate(
      navigationState: navigationState,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _routerDelegate,
      routeInformationParser: _informationParser,
      title: 'Navigation 2.0',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
