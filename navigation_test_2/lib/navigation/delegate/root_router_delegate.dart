import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_test_2/navigation/delegate/tab_router_delegate.dart';
import 'package:navigation_test_2/navigation/paths.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';
import 'package:navigation_test_2/screen/main_container.dart';

class RootRouterDelegate extends RouterDelegate<NavigationPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationPath> {
  final NavigationState navigationState;
  final OptionalNavigationState optionalNavigationState;

  RootRouterDelegate({this.navigationState, this.optionalNavigationState}) {
    navigationState.addListener(notifyListeners);

    // navigationState.push(
    //   MainContainerPath(navigationState: navigationState),
    //   rootStack: true,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        // MainContainer(())
        CupertinoPage(
          child: Scaffold(
            body: IndexedStack(
              index: navigationState.selectedIndex,
              children: [
                for (var paths in optionalNavigationState.paths)
                  Router(
                    routerDelegate: TabRouterDelegate(
                      initialPath: paths.first,
                    ),
                  ),
              ],
            ),
          ),
        ),
        for (NavigationPath path in navigationState.rootStack
            .where((path) => path is! TemporaryPath))
          CupertinoPage(
            // Value key is important. It differentiates the pages so the transition animation can occur
            key: ValueKey(path.path),
            child: path.builder(context),
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
    // TemporaryPath is a fix to framework dialogs problems with android backButton
    if (navigationState.rootStack.last is TemporaryPath) {
      navigationState.pop();
      return super.popRoute();
    } else if (navigationState.rootStack.length > 1 ||
        navigationState.currentStack.length > 1) {
      navigationState.pop();
      notifyListeners();
      return true;
    } else {
      return super.popRoute();
    }
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(NavigationPath path) async {}
}
