import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_test_2/navigation/delegate/root_router_delegate.dart';
import 'package:navigation_test_2/navigation/delegate/tab_router_delegate.dart';
import 'package:navigation_test_2/navigation/navigation_factories.dart';
import 'package:navigation_test_2/navigation/state/navigation_controller.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Settings'),
            CupertinoButton(
              child: Text("OPEN FULLSCREEN"),
              onPressed: () => NavigationController.instance.push(
                SettingsFactory(fullScreenDialog: true),
                toRoot: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
