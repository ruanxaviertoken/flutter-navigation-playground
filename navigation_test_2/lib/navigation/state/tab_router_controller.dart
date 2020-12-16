import 'package:navigation_test_2/navigation/delegate/tab_router_delegate.dart';
import 'package:navigation_test_2/navigation/navigation_factories.dart';

class TabRouterController {
  List<TabRouterDelegate> _routerDelegates = [];

  set routerDelegates(List<NavigationFactory> value) {
    _routerDelegates = value
        .map((factory) =>
            TabRouterDelegate(root: factory, maybePopPage: maybePop))
        .toList();
  }

  List<TabRouterDelegate> get tabRouterDelegates =>
      List.unmodifiable(_routerDelegates);

  int selectedTabIndex = 0;

  Future<void> push(NavigationFactory navigationFactory) async {
    _routerDelegates[selectedTabIndex].stack.add(navigationFactory);
  }

  bool maybePop() {
    try {
      if (_routerDelegates[selectedTabIndex].stack.length > 1) {
        _routerDelegates[selectedTabIndex].stack.removeLast();
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }
}
