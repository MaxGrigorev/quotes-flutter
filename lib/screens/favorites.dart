import 'package:flutter/material.dart';
import '../widgets/quote.dart';

class FavoritesListWidget extends StatelessWidget {
  FavoritesListWidget(
      {Key key, this.favoriteQuotes, this.quotes, @required this.onPress})
      : super(key: key);
  final Map<String, bool> favoriteQuotes;
  final Map<String, Quote> quotes;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: favoriteQuotes.length,
            itemBuilder: (BuildContext context, int index) {
              String key = favoriteQuotes.keys.elementAt(index);
              return QuoteWidget(
                  quote: quotes[key],
                  onPress: onPress,
                  favorite: (favoriteQuotes[key] ?? false));
            }),
      ),
    );
  }
}
