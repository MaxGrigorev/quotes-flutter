import 'dart:async';

import 'package:flutter/material.dart';
import './screens/quotes.dart';
import './screens/favorites.dart';
import './widgets/quote.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Map<String, Quote> quotes = {};
  Map<String, bool> favoriteQuotes = {};

  void _onPress(String name, bool pressed) {
    this.favoriteQuotes[name] = pressed;

    return setState(() {
      this.favoriteQuotes[name] = pressed;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      this._selectedIndex = index;
    });
  }

  @override
  void initState() {
    Timer.periodic(new Duration(seconds: 5), (timer) {
      getQuotes().then((responce) {
        setState(() {
          this.quotes = responce;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: [
          FavoritesListWidget(
              favoriteQuotes: Map.from(this.favoriteQuotes)
                ..removeWhere((k, v) => v == false),
              quotes: quotes,
              onPress: (String name, bool pressed) {
                this._onPress(name, pressed);
              }),
          QuotesListWidget(
              favoriteQuotes: this.favoriteQuotes,
              quotes: quotes,
              onPress: (String name, bool pressed) {
                this._onPress(name, pressed);
              }),
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Quotes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
