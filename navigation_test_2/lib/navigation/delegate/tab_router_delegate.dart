import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_test_2/navigation/navigation_factories.dart';
import 'package:navigation_test_2/navigation/state/navigation_controller.dart';

class TabRouterDelegate extends RouterDelegate<NavigationFactory>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationFactory> {
  final List<NavigationFactory> stack;
  final NavigationFactory root;
  bool Function() maybePopPage;

  TabRouterDelegate({
    @required this.root,
    this.maybePopPage,
  }): this.stack = [root];
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        for (NavigationFactory factory in stack)
          CupertinoPage(
            key: ValueKey(factory),
            child: factory.builder(context),
            fullscreenDialog: factory.fullScreenDialog,
          )
      ],
      onPopPage: (route, result) {
        if(!route.didPop(result)) {
          return false;
        } else {
          return maybePopPage();
        }
      },
    );
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(NavigationFactory path) async {}
}
