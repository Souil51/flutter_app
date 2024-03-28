import 'package:flutter/material.dart';

class MyAnimatedList extends StatefulWidget{
  const MyAnimatedList({Key? key}) : super(key: key);

  @override
  State<MyAnimatedList> createState() => MyAnimatedListState();
}

class MyAnimatedListState extends State<MyAnimatedList>{
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>(); 
  List<String> _items = [];
  List<String> favorites = [];

  void addItem(String item, bool favorite) { 
    final newIndex = _items.length; // Calculate the index for the new item 
    final newItem = item; // Create a new item 
  
    // Update the underlying data list 
    setState(() { 
      _items.add(newItem); 
      if (favorite){
        favorites.add(newItem);
      }
    }); 
  
    // Insert the new item into the AnimatedList 
    _listKey.currentState!.insertItem(newIndex); 
  } 

  Widget buildItem(String item, Animation<double> animation, BuildContext context) { 
    return SizeTransition( 
      sizeFactor: animation, 
      child: ListTile( 
        title: Text(item),
        leading: favorites.contains(item) ? Icon(Icons.favorite) : Icon(Icons.close)
      ), 
    ); 
  }

  @override 
  Widget build(BuildContext context) { 
    return Expanded( 
      child: AnimatedList( 
        key: _listKey, 
        initialItemCount: _items.length, 
        itemBuilder: (context, index, animation) { 
          return buildItem(_items[index], animation, context); // Build each list item 
        }, 
      ),
    ); 
  } 
}