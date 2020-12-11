import 'package:flutter/material.dart';
import 'package:navigation_test_2/navigation/delegate/tab_router_delegate.dart';
import 'package:navigation_test_2/navigation/paths.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';

class MainContainer extends StatefulWidget {
  final NavigationState navigationState;

  const MainContainer({
    Key key,
    this.navigationState,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {

  TabRouterDelegate tabRouterDelegate1;
  TabRouterDelegate tabRouterDelegate2;

  @override
  void initState() {
    super.initState();
    tabRouterDelegate1 = TabRouterDelegate(
      navigationState: widget.navigationState,
      initialPath: BookListPath(),
      tabIndex: 0,
    );

    tabRouterDelegate2 = TabRouterDelegate(
      navigationState: widget.navigationState,
      initialPath: SettingsPath(),
      tabIndex: 1,
    );
  }

  @override
  void didUpdateWidget(covariant MainContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    tabRouterDelegate1.navigationState = widget.navigationState;
    tabRouterDelegate2.navigationState = widget.navigationState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.navigationState.selectedIndex,
        children: [
          Router(
            routerDelegate: tabRouterDelegate1,
          ),
          Router(
            routerDelegate: tabRouterDelegate2,
          ),
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
        currentIndex: widget.navigationState.selectedIndex,
        onTap: (newIndex) {
          widget.navigationState.selectedIndex = newIndex;
        },
      ),
    );
  }
}
