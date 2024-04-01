import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();

    if(appState.favorites.isEmpty){
      return Center(
        child: Text("You have no favorite"),
      );
    }else{
      return Center(
        child: ListView
              (
                shrinkWrap: true,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text('You ${appState.favorites.length} have favorites:'),
                    ),
                  ),
                  for(var item in appState.favorites)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite),
                            SizedBox(width: 10),
                            Text(item.asLowerCase)
                          ],)
                        // ListTile
                        // (
                        //   leading: Icon(Icons.favorite),
                        //   title: Center(child: Text(item.asLowerCase)),
                        // ),
                      ],
                    )
                ], // liste.map((x) => Text(x)).toList(),
              ),
      );
    }
  }
}