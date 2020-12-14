import 'package:flutter/cupertino.dart';
import 'package:navigation_test_2/model/book.dart';
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

  NavigationPathType type = NavigationPathType.stack;

  Widget builder(BuildContext context);

  NavigationPath({this.fullScreenDialog = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationPath &&
          runtimeType == other.runtimeType &&
          path == other.path &&
          type == other.type;

  @override
  int get hashCode => path.hashCode ^ type.hashCode;
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

  @override
  NavigationPathType type = NavigationPathType.stack;
}

class MainContainerPath extends NavigationPath {
  final NavigationState navigationState;

  MainContainerPath({this.navigationState});

  @override
  Widget builder(BuildContext context) {
    return MainContainer(
      navigationState: navigationState,
    );
  }
}

class BookListPath extends NavigationPath {
  NavigationPathType type = NavigationPathType.tab;

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
