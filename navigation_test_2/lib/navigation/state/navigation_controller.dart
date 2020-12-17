import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigation_test_2/navigation/delegate/tab_router_delegate.dart';
import 'package:navigation_test_2/navigation/navigation_factories.dart';
import 'package:navigation_test_2/navigation/state/root_navigation_state.dart';
import 'package:navigation_test_2/navigation/state/tab_router_controller.dart';

class NavigationController extends ChangeNotifier {
  final RootNavigationState _rootNavigationState = RootNavigationState();
  final TabRouterController _tabRouterController = TabRouterController();

  // Temporary solution to make it singleton
  factory NavigationController({List<NavigationFactory> tabRoots}) {
    instance._tabRouterController.routerDelegates = tabRoots;
    return instance;
  }

  NavigationController._();

  static final NavigationController instance = NavigationController._();

  List<NavigationFactory> get rootStack => _rootNavigationState.stack;

  List<TabRouterDelegate> get tabRouterDelegates =>
      _tabRouterController.tabRouterDelegates;

  int get selectedTabIndex => _tabRouterController.selectedTabIndex;

  set selectedTabIndex(int index) {
    _tabRouterController.selectedTabIndex = index;
    notifyListeners();
  }

  Future<void> push(
    NavigationFactory navigationFactory, {
    bool toRoot = false,
  }) async {
    if (toRoot) {
      _rootNavigationState.push(navigationFactory);
    } else {
      _tabRouterController.push(navigationFactory);
    }
    notifyListeners();
  }

  bool maybePopRoot() {
    final bool didPop = _rootNavigationState.maybePop();
    notifyListeners();
    return didPop;
  }

  bool maybePop() {
    // If we cant pop root, then it means that there is nothing in front of
    // everything that needs to pe popped (ie. fullscreen modal)
    if (!_rootNavigationState.maybePop()) {
      final bool didPop = _tabRouterController.maybePop();
      notifyListeners();
      return didPop;
    } else {
      notifyListeners();
      return true;
    }
  }
}