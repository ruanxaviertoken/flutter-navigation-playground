import 'package:flutter/foundation.dart';
import 'package:navigation_test_2/navigation/paths.dart';

class OptionalNavigationState extends ChangeNotifier {
  List<List<NavigationPath>> _paths;

  OptionalNavigationState({@required List<NavigationPath> roots})
      : this._paths = [
          for (var path in roots) [path]
        ],
        assert(roots != null && roots.length > 0);

  List<List<NavigationPath>> get paths => _paths;
  int _selectedIndex = 0;

  List<NavigationPath> get rootStack => _paths.first;

  List<NavigationPath> get currentStack => _paths[_selectedIndex];

  List<NavigationPath> get tabs => _paths.map((e) => e.first).toList();

  void pushDialog() {}

  Future<void> navigateTo(NavigationPath path) async {
    switch (path.type) {
      case NavigationPathType.tab:
        int index = tabs.indexOf(path);
        if (index > -1) {
          // TODO: navigar
        } else {
          // TODO: tratar 404
        }
        break;
      case NavigationPathType.stack:
        // TODO: pushar pro _selectedIndex.
        break;
    }
  }
}

class NavigationState extends ChangeNotifier {
  NavigationState._() {
    _stacks.addAll({-1: []});
  }

  static final NavigationState instance = NavigationState._();

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
  }

  Map<int, List<NavigationPath>> _stacks = Map();

  Map<int, List<NavigationPath>> get stacks => _stacks;

  List<NavigationPath> stackAt(int index) {
    assert(index > -1 && index <= _stacks.keys.last + 1);
    if (!_stacks.keys.contains(index)) {
      // If the index doesn't exist, we create a new one along with a new stack
      final int latestIndex = _stacks.keys.last + 1;
      _stacks.addAll({latestIndex: []});
      return _stacks[latestIndex];
    } else {
      return _stacks[index];
    }
  }

  List<NavigationPath> get rootStack => _stacks[-1];

  List<NavigationPath> get currentStack => _stacks[_selectedIndex];

  Future<void> push(NavigationPath navigationPath,
      {bool rootStack = false}) async {
    if (rootStack) {
      _stacks[-1].add(navigationPath);
    } else {
      _stacks[_selectedIndex].add(navigationPath);
    }
    print(_stacks);
    notifyListeners();
  }

  Future<void> pop() async {
    if (_stacks[-1].length > 1) {
      _stacks[-1].removeLast();
    } else {
      _stacks[_selectedIndex].removeLast();
    }
    print(_stacks);
    notifyListeners();
  }

  void initiateStack(int index, {NavigationPath initialValue}) {
    assert(index > -1, "The -1 index is for the root stack");
    if (!_stacks.containsKey(index)) {
      _stacks.addAll({
        index: initialValue != null ? [initialValue] : []
      });
    }
  }

  // Just a mock method to test deeplink navigation
  void navigateTo(NavigationPath path) {
    if (path is SettingsPath) {
      _selectedIndex = 1;
      if (path.fullScreenDialog) {
        _stacks[-1].add(path);
      }
      notifyListeners();
    }
  }
}
