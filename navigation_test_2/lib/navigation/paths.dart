import 'package:flutter/cupertino.dart';
import 'package:navigation_test_2/model/book.dart';
import 'package:navigation_test_2/navigation/delegate/tab_router_delegate.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';
import 'package:navigation_test_2/screen/book_details_screen.dart';
import 'package:navigation_test_2/screen/list/book_list_screen.dart';
import 'package:navigation_test_2/screen/main_container.dart';
import 'package:navigation_test_2/screen/settings_screen.dart';

enum NavigationPathType { tab, stack }

abstract class NavigationPath {
  // This way we can pass parameters to the Page widget
  final bool fullScreenDialog;

  String path;

  Widget builder(BuildContext context);

  NavigationPath({this.fullScreenDialog = false});
}

abstract class RootNavigationPath extends NavigationPath {
  RouterDelegate get routerDelegate;
}

class TemporaryPath extends NavigationPath {

  final bool fullScreenDialog;

  TemporaryPath({
    this.fullScreenDialog = false,
  });

  @override
  Widget builder(BuildContext context) => null;

  @override
  String path = "tempraryPath";
}

class MainContainerPath extends NavigationPath {
  final OptionalNavigationState navigationState;

  MainContainerPath({this.navigationState});

  @override
  Widget builder(BuildContext context) {
    return MainContainer(
      optionalNavigationState: navigationState,
    );
  }
}

class BookListPath extends NavigationPath {
  @override
  Widget builder(BuildContext context) {
    return BookListScreen();
  }
}

class SettingsPath extends NavigationPath {
  NavigationPathType type = NavigationPathType.tab;

  final bool fullScreenDialog;

  SettingsPath({
    this.fullScreenDialog = false,
  }) : super(fullScreenDialog: fullScreenDialog);

  @override
  Widget builder(BuildContext context) {
    return SettingsScreen();
  }
}

class BookDetailsPath extends NavigationPath {
  final Book book;
  final int bookId;

  @override
  Widget builder(BuildContext context) {
    return BookDetailsScreen(
      book: book,
      bookId: bookId,
    );
  }

  BookDetailsPath({this.book, this.bookId});
}
