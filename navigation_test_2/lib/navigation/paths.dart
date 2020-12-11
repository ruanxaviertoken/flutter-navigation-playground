import 'package:navigation_test_2/model/book.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';

abstract class NavigationPath {
  final bool fullScreenDialog;

  NavigationPath({this.fullScreenDialog = false});
}

class TemporaryPath extends NavigationPath {
  final bool fullScreenDialog;

  TemporaryPath({
    this.fullScreenDialog = false,
  }) : super(fullScreenDialog: fullScreenDialog);
}

class MainContainerPath extends NavigationPath {
  final NavigationState navigationState;

  MainContainerPath({this.navigationState});
}

class BookListPath extends NavigationPath {}

class SettingsPath extends NavigationPath {
  final bool fullScreenDialog;

  SettingsPath({
    this.fullScreenDialog = false,
  }) : super(fullScreenDialog: fullScreenDialog);
}

class BookDetailsPath extends NavigationPath {
  final Book book;
  final int bookId;

  BookDetailsPath({this.book, this.bookId});
}
