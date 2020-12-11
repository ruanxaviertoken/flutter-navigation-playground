import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_test_2/navigation/paths.dart';
import 'package:navigation_test_2/navigation/route_definer.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';

class RootRouterDelegate extends RouterDelegate<NavigationPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationPath> {
  final NavigationState navigationState;
  final RouteDefiner routeDefiner;

  RootRouterDelegate({this.navigationState, this.routeDefiner}) {
    navigationState.addListener(notifyListeners);

    navigationState.push(
      MainContainerPath(navigationState: navigationState),
      rootStack: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        for (NavigationPath path in navigationState.rootStack.where((path) => path is! TemporaryPath))
          CupertinoPage(
            key: ValueKey(path),
            child: routeDefiner.builderMap[path.runtimeType](path),
            fullscreenDialog: path.fullScreenDialog,
          )
      ],
      onPopPage: (route, result) {
        if (navigationState.rootStack.length > 1 ||
            navigationState.currentStack.length > 1) {
          navigationState.pop();
          notifyListeners();
          return route.didPop(result);
        } else {
          return false;
        }
      },
    );
  }

  @override
  Future<bool> popRoute() async {
    if (navigationState.rootStack.last is TemporaryPath) {
      navigationState.pop();
      return super.popRoute();
    } else if (navigationState.rootStack.length > 1 || navigationState.currentStack.length > 1) {
      navigationState.pop();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(NavigationPath path) async {}
}
