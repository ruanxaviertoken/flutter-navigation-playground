import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation_test_2/navigation/delegate/tab_router_delegate.dart';
import 'package:navigation_test_2/navigation/paths.dart';
import 'package:navigation_test_2/navigation/state/navigation_state.dart';
import 'package:navigation_test_2/screen/list/book_list_state.dart';

class BookListScreen extends StatefulWidget {
  final BookListState bookListState = BookListState();

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Books')),
      body: ListView.builder(
        itemCount: widget.bookListState.books.length,
        itemBuilder: (context, index) {
          final book = widget.bookListState.books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            onTap: () => NavigationState.instance.push(BookDetailsPath(book: book)),
          );
        },
      ),
    );
  }
}
