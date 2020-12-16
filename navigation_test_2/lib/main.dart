import 'package:flutter/material.dart';
import 'package:navigation_test_2/navigation/delegate/root_router_delegate.dart';
import 'package:navigation_test_2/navigation/delegate/tab_router_delegate.dart';
import 'package:navigation_test_2/navigation/information_parser/root_route_information_parser.dart';
import 'package:navigation_test_2/navigation/navigation_factories.dart';
import 'package:navigation_test_2/navigation/state/navigation_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: RootRouterDelegate(
        navigationController: NavigationController(
          tabRoots: <NavigationFactory>[
            BookListFactory(),
            SettingsFactory(),
          ],
        ),
      ),
      routeInformationParser: RootRouteInformationParser(),
      title: 'Navigation 2.0',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
