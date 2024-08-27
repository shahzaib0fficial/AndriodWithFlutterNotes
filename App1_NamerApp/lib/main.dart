import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> MyAppState(),
      child: MaterialApp(
        title: "Namer App",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(title: "Home Page"),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var randomWord = WordPair.random();
  void nextRandom(){
      randomWord = WordPair.random();
      notifyListeners();
  }

  var favourites = <WordPair>[];

  void toggleFavourite(){
    if(favourites.contains(randomWord)){
      favourites.remove(randomWord);
    }else{
      favourites.add(randomWord);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    Widget screen;
    switch(currentScreen){
      case 0:
        screen = AddName();
        break;
      case 1:
        screen = Favourite();
        break;
      default:
        screen = Placeholder();
        break;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .primaryContainer,
          title: Text(
            widget.title,
            style: TextStyle(
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary
            ),
          ),
        ),
      body: Row(
        children: [
          SafeArea(
              child: NavigationRail(
                backgroundColor: Theme.of(context).colorScheme.primary,
                extended: false,
                destinations: [
                  NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text("Home")
                  ),
                  NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text("Favourite")
                  )
                ],
                selectedIndex: currentScreen,
                onDestinationSelected: (value){
                  setState(() {
                    currentScreen = value;
                  });
                },
              )
          ),
          Expanded(
              child: Container(
                child: screen,
              )
          )
        ],
      ),
    );
  }
}

class AddName extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    IconData icon;
    if (appState.favourites.contains(appState.randomWord)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }
    return Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                    appState.randomWord.asPascalCase,
                    style: TextStyle(
                        fontSize: 32,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .inversePrimary
                    )
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                    onPressed: appState.toggleFavourite,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme
                            .of(context)
                            .colorScheme
                            .inversePrimary
                    ),
                    icon: Icon(icon),
                    label: const Text(
                      'Like',
                      style: TextStyle(
                          fontSize: 22
                      ),
                    )
                ),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: appState.nextRandom,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme
                            .of(context)
                            .colorScheme
                            .inversePrimary
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 22
                      ),
                    )
                ),
              ],
            )
          ],
        ),
      );
  }
}

class Favourite extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    if(appState.favourites.length <= 0){
      return Center(
        child: Text("Nothing To Show"),
      );
    }
    return ListView(
      children: [
        for(var pair in appState.favourites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asPascalCase),
          )
      ],
    );
  }

}