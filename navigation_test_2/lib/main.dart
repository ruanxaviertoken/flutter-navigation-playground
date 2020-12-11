import 'package:flutter/material.dart';
import 'package:navigation_test_2/navigation/delegate/root_router_delegate.dart';
import 'package:navigation_test_2/navigation/information_parser/root_route_information_parser.dart';
import 'package:navigation_test_2/navigation/paths.dart';
import 'package:navigation_test_2/navigation/route_definer.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';
import 'package:navigation_test_2/screen/book_details_screen.dart';
import 'package:navigation_test_2/screen/list/book_list_screen.dart';
import 'package:navigation_test_2/screen/main_container.dart';
import 'package:navigation_test_2/screen/settings_screen.dart';

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
  void initState() {
    super.initState();

    RouteDefiner.instance
      ..defineRoute<MainContainerPath>(
        (MainContainerPath path) => MainContainer(
          navigationState: path.navigationState,
        ),
      )
      ..defineRoute<BookListPath>(
        (_) => BookListScreen(),
      )
      ..defineRoute<BookDetailsPath>(
        (BookDetailsPath path) => BookDetailsScreen(
          book: path.book,
          bookId: path.bookId,
        ),
      )
      ..defineRoute<SettingsPath>(
        (_) => SettingsScreen(),
      );
  }

  @override
  void didChangeDependencies() {
    _routerDelegate = RootRouterDelegate(
      navigationState: navigationState,
      routeDefiner: RouteDefiner.instance,
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
