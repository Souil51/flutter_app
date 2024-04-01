import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);

    if(appState.favorites.isEmpty){
      return Center(
        child: Text("You have no favorite"),
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
                        appState.deleteFavorite(item);
                      },
                      color: theme.colorScheme.primary
                    ),
                    Text(item.asLowerCase)
                  ],
                )
              )
            ],
          ),
        ],
      );
    }
  }
}