import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
// import 'tutorialView.dart';
// import 'anotherScreen.dart';
import 'awaitScreen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Returning Data',
    home: HomeScreen(),
  ));
}

// void main() {
//   runApp(MaterialApp(
//     title: 'Named Routes Demo',
//     initialRoute: '/',
//     routes: {
//       '/': (context) => MyApp(),
//       '/another': (context) => AnotherScreen(),
//     },
//   ));
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        body: Center(
          child: RaisedButton(
            child: Text('Press'),
            onPressed: () {
              Navigator.pushNamed(context, '/another');
            },
          ),
        )
      ),
      // home: TutorialView()
    );
  }

  @override
  Widget _buildCard() => SizedBox(
    height: 210,
    child: Card(
      child: Column(
        children: [
          ListTile(
          title: Text('1625 Main Street',
            style: TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Text('My City, CA 99984'),
          leading: Icon(
            Icons.restaurant_menu,
            color: Colors.blue[500],
          ),
        ),
        Divider(),
        ListTile(
          title: Text('(408) 555-1212',
            style: TextStyle(fontWeight: FontWeight.w500)),
          leading: Icon(
            Icons.contact_phone,
            color: Colors.blue[500],
          ),
        ),
        ListTile(
          title: Text('consta@example.com'),
          leading: Icon(
            Icons.contact_mail,
            color: Colors.blue[500],
          ),
        ),
      ],
    ),
  ),
  );
}

class RandomWords extends StatefulWidget {
  @override 
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder( 
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider(); 

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite :Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
     MaterialPageRoute(
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map(
           (WordPair pair) {
            return new ListTile(
               title: new Text(
                 pair.asPascalCase,
                 style: _biggerFont,
               ),
            );
           },
        );
        final List<Widget> divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('saved suggestions'),
            ),
            body: ListView(children: divided,),
          );
        },
      ),
    );
  }
}