import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_test_2/navigation/paths.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';

class TabRouterDelegate extends RouterDelegate<NavigationPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationPath> {
  final List<NavigationPath> stack;
  final bool Function() maybePopPage;
  final NavigationPath root;

  TabRouterDelegate({
    // this.stack,
    this.maybePopPage,
    this.root,
  }): this.stack = [root];
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        for (NavigationPath path in stack)
          CupertinoPage(
            key: ValueKey(path),
            child: path.builder(context),
            fullscreenDialog: path.fullScreenDialog,
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
  Future<void> setNewRoutePath(NavigationPath path) async {}
}
