import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/favoris.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  @override
  State<Favorites> createState() => FavoritesState();
}

class FavoritesState extends State<Favorites>{
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);

    if(appState.favorites.isEmpty){
      return FutureBuilder<List<Favoris>>
              (
                future: appState.futureFavoris,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    // return Text("aze");
                    if(snapshot.data!.length > 0){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text
                            (
                              "You ${snapshot.data!.length} have favorites:"
                            ),
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: [
                              for(var fav in snapshot.data!)
                              SizedBox(
                              width: 200.0,
                              child: Row
                              (
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    tooltip: "Delete from your favorites",
                                    onPressed: () {
                                      // appState.deleteFavorite();
                                      appState.deleteFavorite(fav);
                                    },
                                    color: theme.colorScheme.primary
                                  ),
                                  Text(fav.valeur)
                                ],
                              )
                            )
                            ],
                          )
                        ],
                      );
                    } else {
                      return Center
                      (
                        child: Text("You have no favorites !"),
                      );  
                    }
                  } else {
                    return Center
                    (
                      child: Text("You have no favorites !"),
                    );
                  }
                }
              );
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text
            (
              "You ${appState.favorites.length} have favorites:"
            ),
          ),
          Wrap
          (
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              for(var item in appState.favorites)
              SizedBox(
                width: 200.0,
                child: Row
                (
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      tooltip: "Delete from your favorites",
                      onPressed: () {
                        appState.deleteFavorite(Favoris(id: 0, valeur: item.asLowerCase));
                      },
                      color: theme.colorScheme.primary
                    ),
                    Text(item.asLowerCase)
                  ],
                )
              ),
            ],
          ),
        ],
      );
    }
  }
}