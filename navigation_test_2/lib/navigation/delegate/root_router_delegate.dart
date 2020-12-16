import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_test_2/navigation/delegate/tab_router_delegate.dart';
import 'package:navigation_test_2/navigation/navigation_factories.dart';
import 'package:navigation_test_2/navigation/state/navigation_controller.dart';

class RootRouterDelegate extends RouterDelegate<NavigationFactory>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationFactory> {
  NavigationController navigationController;

  RootRouterDelegate({@required this.navigationController}) {
    navigationController.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        CupertinoPage(
          key: ValueKey(MainContainerFactory),
          child: Scaffold(
            body: IndexedStack(
              index: navigationController.selectedTabIndex,
              children: [
                for (TabRouterDelegate routerDelegate
                    in navigationController.tabRouterDelegates)
                  Router(
                    routerDelegate: routerDelegate,
                  )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Books',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
              currentIndex: navigationController.selectedTabIndex,
              onTap: (newIndex) {
                navigationController.selectedTabIndex = newIndex;
              },
            ),
          ),
        ),
        for (NavigationFactory factory in navigationController.rootStack)
          CupertinoPage(
            // Value key is important. It differentiates the pages so the transition animation can occur
            key: ValueKey(factory),
            child: factory.builder(context),
            fullscreenDialog: factory.fullScreenDialog,
          )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        } else {
          return navigationController.maybePopRoot();
        }
      },
    );
  }

  @override
  Future<bool> popRoute() async {
    if(navigationController.maybePop()) {
      return true;
    } else {
      return super.popRoute();
    }
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(NavigationFactory path) async {}
}
