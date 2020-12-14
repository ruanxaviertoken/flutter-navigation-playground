import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_test_2/navigation/paths.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';

class TabRouterDelegate extends RouterDelegate<NavigationPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationPath> {
  NavigationState navigationState;
  final int tabIndex;
  final NavigationPath initialPath;

  TabRouterDelegate({
    this.navigationState,
    this.tabIndex,
    this.initialPath,
  }) {
    navigationState.addListener(notifyListeners);
    navigationState.initiateStack(tabIndex, initialValue: initialPath);
  }

  @override
  Widget build(BuildContext context) {
    print(navigationState.stacks);
    return Navigator(
      key: navigatorKey,
      pages: [
        for (NavigationPath path in navigationState.stackAt(tabIndex).where((path) => path is! TemporaryPath))
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
          navigationState.pop();
          notifyListeners();
          return true;
        }
      },
    );
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(NavigationPath path) async {}
}
