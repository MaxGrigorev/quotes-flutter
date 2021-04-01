import 'package:flutter/material.dart';
import './quotes.dart';

class FavoritesListWidget extends StatelessWidget {
  FavoritesListWidget({Key key, this.favoriteQuotes}) : super(key: key);
  final List<Quote> favoriteQuotes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: this.favoriteQuotes.length,
            itemBuilder: (BuildContext context, int index) =>
                QuoteWidget(quote: this.favoriteQuotes[index])),
      ),
    );
  }
}
