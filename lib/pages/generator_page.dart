import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/widgets/big_card.dart';
import 'package:flutter_app/widgets/my_animated_list.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: 
              ShaderMask
              (
                shaderCallback:  (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.black, Colors.transparent],
                    stops: [0, 0.75, 1]
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstOut,
                child: MyAnimatedList(key: appState.listKey),
              )
          ),
          Expanded(
            child: Column(children: 
              [
                BigCard(pair: pair),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        appState.toggleFavorite();
                      },
                      icon: Icon(icon),
                      label: Text('Like'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        bool isFavorite = appState.favorites.contains(pair);
                        appState.listKey.currentState!.addItem(pair.asLowerCase, isFavorite);
                        appState.getNext();
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}