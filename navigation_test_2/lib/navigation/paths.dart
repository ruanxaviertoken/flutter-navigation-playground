import 'package:flutter/cupertino.dart';
import 'package:navigation_test_2/model/book.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';
import 'package:navigation_test_2/screen/book_details_screen.dart';
import 'package:navigation_test_2/screen/list/book_list_screen.dart';
import 'package:navigation_test_2/screen/main_container.dart';
import 'package:navigation_test_2/screen/settings_screen.dart';

abstract class NavigationPath {
  // This way we can pass parameters to the Page widget
  final bool fullScreenDialog;

  Widget builder(BuildContext context);

  NavigationPath({this.fullScreenDialog = false});
}

class TemporaryPath extends NavigationPath {
  final bool fullScreenDialog;

  TemporaryPath({
    this.fullScreenDialog = false,
  }) : super(fullScreenDialog: fullScreenDialog);

  @override
  Widget builder(BuildContext context) => null;
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
  @override
  Widget builder(BuildContext context) {
    return BookListScreen();
  }
}

class SettingsPath extends NavigationPath {
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
    return BookDetailsScreen(book: book, bookId: bookId,);
  }

  BookDetailsPath({this.book, this.bookId});
}