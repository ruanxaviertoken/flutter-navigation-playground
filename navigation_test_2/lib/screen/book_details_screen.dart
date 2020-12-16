import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_test_2/model/book.dart';
import 'package:navigation_test_2/navigation/paths.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';
import 'package:navigation_test_2/screen/list/book_list_state.dart';
import 'package:navigation_test_2/screen/utils.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;
  final int bookId;

  final BookListState bookList = BookListState();

  BookDetailsScreen({Key key, this.book, this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final book = this.book ?? bookList.books[bookId];

    return Scaffold(
      appBar: AppBar(
        title: Text('Book'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(book.title, style: TextStyle(fontSize: 20)),
            Text(book.author),
            CupertinoButton(
              child: Text("OPEN DIALOG"),
              onPressed: () => showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("TEST"),
                    content: Text("Testing dialogs"),
                    actions: [
                      CupertinoDialogAction(
                        child: Text("OK"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
                },
              ),
            ),
            CupertinoButton(
              child: Text("NAVIGATE TO SETTINGS"),
              onPressed: () => OptionalNavigationState.instance.navigateTo(SettingsPath(fullScreenDialog: true)),
            ),
          ],
        ),
      ),
    );
  }
}
