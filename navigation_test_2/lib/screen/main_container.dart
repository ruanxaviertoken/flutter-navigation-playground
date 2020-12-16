// import 'package:flutter/material.dart';
// import 'package:navigation_test_2/navigation/delegate/tab_router_delegate.dart';
// import 'package:navigation_test_2/navigation/navigation_factories.dart';
// import 'package:navigation_test_2/navigation/state/navigation_controller.dart';
//
// class MainContainer extends StatefulWidget {
//   final OptionalNavigationState optionalNavigationState;
//
//   const MainContainer({Key key, this.optionalNavigationState})
//       : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _MainContainerState();
// }
//
// class _MainContainerState extends State<MainContainer> {
//   List<TabRouterDelegate> routerDelegates = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // tabRouterDelegate1 = TabRouterDelegate(flow: widget.optionalNavigationState.flows[0], maybePopPage: widget.optionalNavigationState.maybePop);
//     // tabRouterDelegate2 = TabRouterDelegate(flow: widget.optionalNavigationState.flows[1], maybePopPage: widget.optionalNavigationState.maybePop);
//     // for(List<NavigationPath> flow in widget.optionalNavigationState.stacks) {
//     //   routerDelegates.add(TabRouterDelegate(stack: flow, maybePopPage: widget.optionalNavigationState.maybePop));
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: widget.optionalNavigationState.selectedIndex,
//         children: [
//           for (TabRouterDelegate routerDelegate
//               in widget.optionalNavigationState.tabRouterDelegates)
//             Router(routerDelegate: routerDelegate)
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Books',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         currentIndex: widget.optionalNavigationState.selectedIndex,
//         onTap: (newIndex) {
//           widget.optionalNavigationState.selectedIndex = newIndex;
//         },
//       ),
//     );
//   }
// }
