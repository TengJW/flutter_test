import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// ignore: must_be_immutable
class FavoriteList extends StatelessWidget {
  var _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  FavoriteList(this._saved);

  @override
  Widget build(BuildContext context) {
    final titles = _saved.map((pair) {
      return new ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        onTap: (){

        },
      );
    });

    final divided =
        ListTile.divideTiles(context: context, tiles: titles).toList();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Saved Suggestions'),
      ),
      body: new ListView(
        physics: BouncingScrollPhysics(),
        children: divided,
      ),
    );
  }
}
