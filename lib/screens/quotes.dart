import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/quote.dart';

Future<Map<String, Quote>> getQuotes() async {
  http.Response response = await http.get(
      Uri.https("poloniex.com", "/public", {'command': 'returnTicker'}),
      headers: {"Accept": "application/json"});
  var result = json.decode(response.body) as Map<String, dynamic>;
  Map<String, Quote> quotes = {};

  quotes = {
    for (var k in result.keys)
      '$k': Quote(k, result[k]['last'], result[k]['percentChange'])
  };

  return quotes;
}

class QuotesListWidget extends StatelessWidget {
  QuotesListWidget(
      {Key key, this.favoriteQuotes, this.quotes, @required this.onPress})
      : super(key: key);
  final Map<String, bool> favoriteQuotes;
  final Map<String, Quote> quotes;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
      ),
      body: Container(
          child: (() {
        if (quotes.length != 0) {
          return ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (BuildContext context, int index) {
                String key = quotes.keys.elementAt(index);
                return QuoteWidget(
                    quote: quotes[key],
                    onPress: onPress,
                    favorite: (favoriteQuotes[key] ?? false));
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }())),
    );
  }
}
