import 'package:flutter/cupertino.dart';
import 'package:navigation_test_2/navigation/paths.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';

Future<T> pushCupertinoDialog<T>({
  BuildContext context,
  WidgetBuilder builder,
  bool rootNavigator = true,
}) async {
  await NavigationState.instance.push(
    TemporaryPath(fullScreenDialog: true),
    rootStack: rootNavigator,
  );
  return showCupertinoDialog<T>(context: context, builder: builder);
}

void popCupertinoDialog<T extends Object>(BuildContext context, [T result]) {
  NavigationState.instance.pop();
  return Navigator.of(context).pop(result);
}
