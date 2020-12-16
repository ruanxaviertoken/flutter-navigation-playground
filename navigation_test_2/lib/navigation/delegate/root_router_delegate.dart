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
  final OptionalNavigationState optionalNavigationState;
  List<TabRouterDelegate> tabRouterDelegates = [];

  RootRouterDelegate({this.optionalNavigationState}) {
    optionalNavigationState.addListener(notifyListeners);
    for(List<NavigationPath> tabStack in optionalNavigationState.stacks) {
      tabRouterDelegates.add(TabRouterDelegate(stack: tabStack, maybePopPage: optionalNavigationState.maybePop));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        CupertinoPage(
          key: ValueKey(MainContainerPath),
          // child: MainContainer(optionalNavigationState: optionalNavigationState,)
          child: Scaffold(
            body: IndexedStack(
              index: optionalNavigationState.selectedIndex,
              children: [
                for (TabRouterDelegate routerDelegate in tabRouterDelegates)
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
              currentIndex: optionalNavigationState.selectedIndex,
              onTap: (newIndex) {
                optionalNavigationState.selectedIndex = newIndex;
              },
            ),
          ),
        ),
        for (NavigationPath path in optionalNavigationState.rootStack)
          CupertinoPage(
            // Value key is important. It differentiates the pages so the transition animation can occur
            key: ValueKey(path.path),
            child: path.builder(context),
            fullscreenDialog: path.fullScreenDialog,
          )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        } else {
          return optionalNavigationState.maybePopRoot();
        }
      },
    );
  }

  @override
  Future<bool> popRoute() async {
    return optionalNavigationState.maybePopRoot();
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(NavigationPath path) async {}
}
