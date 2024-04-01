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
    final newItem = item; // Create a new item 
  
    // Update the underlying data list 
    setState(() { 
      _items.insert(0, newItem); 
      if (favorite){
        favorites.add(newItem);
      }
    }); 
  
    // Insert the new item into the AnimatedList 
    // _listKey.currentState!.insertItem(newIndex);
    _listKey.currentState!.insertItem(0);
  } 

  Widget buildItem(String item, Animation<double> animation, BuildContext context) { 
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.primary,
      fontWeight: FontWeight.w900,
      fontSize: 20
    );
    
    return Center(
      child: SizeTransition(
        sizeFactor: animation, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(favorites.contains(item))
              Icon
              (
                Icons.favorite,
                color: theme.colorScheme.primary,
                ),
            Text
            (
              item,
              style: style
              ),
        ],)
        // ListTile( 
        //   title: Text(item),
        //   leading: favorites.contains(item) ? Icon(Icons.favorite) : Icon(Icons.close)
        // ), 
      ),
    ); 
  }

  @override 
  Widget build(BuildContext context) { 
    return Column(
      children: [
        Expanded( 
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 200.0,
              child: 
                AnimatedList( 
                  reverse: true,
                  key: _listKey, 
                  initialItemCount: _items.length, 
                  itemBuilder: (context, index, animation) { 
                    return buildItem(_items[index], animation, context); // Build each list item 
                  }, 
                ),
              
            ),
          ),
        ),
      ],
    ); 
  } 
}