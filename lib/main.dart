import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/favoris.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/widgets/my_animated_list.dart';
import 'package:flutter_app/pages/generator_page.dart';
import 'package:flutter_app/pages/favorites_page.dart';
import 'package:flutter_app/services/api_service.dart' as api_service;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  late Future<List<Favoris>> futureFavoris;
  final GlobalKey<MyAnimatedListState> listKey = GlobalKey<MyAnimatedListState>();
  var service = api_service.ApiService();

  MyAppState(){
    loadFavorites();
  }

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void addFavorite() async {
    if (favorites.contains(current)){
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    await service.addFavoris(Favoris(id: 0, valeur: current.asLowerCase));
    loadFavorites();
    notifyListeners();
  }

  void deleteFavorite(Favoris fav) async {
    var pairs = favorites.where((x) => x.asLowerCase == fav.valeur).toList();
    if (pairs.isNotEmpty) {
      favorites.remove(pairs[0]);
    }
    await service.deleteFavoris(fav);
    loadFavorites();
    notifyListeners();
  }

  void loadFavorites(){
    futureFavoris = service.fetchFavoris();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = Favorites();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraint) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraint.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState((){
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}