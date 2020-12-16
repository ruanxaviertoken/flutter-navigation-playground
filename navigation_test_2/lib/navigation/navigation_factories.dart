import 'package:flutter/cupertino.dart';
import 'package:navigation_test_2/model/book.dart';
import 'package:navigation_test_2/screen/book_details_screen.dart';
import 'package:navigation_test_2/screen/list/book_list_screen.dart';
import 'package:navigation_test_2/screen/main_container.dart';
import 'package:navigation_test_2/screen/settings_screen.dart';

abstract class NavigationFactory {
  // This way we can pass parameters to the Page widget
  final bool fullScreenDialog;

  String path;

  Widget builder(BuildContext context);

  NavigationFactory({this.fullScreenDialog = false});
}

abstract class RootNavigationFactory extends NavigationFactory {
  RouterDelegate get routerDelegate;
}

class TemporaryPath extends NavigationFactory {
  final bool fullScreenDialog;

  TemporaryPath({
    this.fullScreenDialog = false,
  });

  @override
  Widget builder(BuildContext context) => null;

  @override
  String path = "tempraryPath";
}

class MainContainerFactory extends NavigationFactory {

  MainContainerFactory();

  @override
  Widget builder(BuildContext context) => null;
}

class BookListFactory extends NavigationFactory {
  @override
  Widget builder(BuildContext context) {
    return BookListScreen();
  }
}

class SettingsFactory extends NavigationFactory {
  final bool fullScreenDialog;

  SettingsFactory({
    this.fullScreenDialog = false,
  }) : super(fullScreenDialog: fullScreenDialog);

  @override
  Widget builder(BuildContext context) {
    return SettingsScreen();
  }
}

class BookDetailsFactory extends NavigationFactory {
  final Book book;
  final int bookId;

  @override
  Widget builder(BuildContext context) {
    return BookDetailsScreen(
      book: book,
      bookId: bookId,
    );
  }

  BookDetailsFactory({this.book, this.bookId});
}
