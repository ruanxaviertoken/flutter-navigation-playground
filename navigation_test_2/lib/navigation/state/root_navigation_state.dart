import 'package:navigation_test_2/navigation/navigation_factories.dart';

class RootNavigationState {
  List<NavigationFactory> _stack = [];

  List<NavigationFactory> get stack => List.unmodifiable(_stack);

  Future<void> push(NavigationFactory navigationFactory) async {
    _stack.add(navigationFactory);
  }

  bool maybePop() {
    try {
      _stack.removeLast();
      return true;
    } catch (_) {
      return false;
    }
  }
}
