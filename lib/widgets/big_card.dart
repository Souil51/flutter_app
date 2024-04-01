import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.w100,
    );
    final secondStyle = style.copyWith(
      fontWeight: FontWeight.w900,
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Card(
        color: theme.colorScheme.primary,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text
              (
                pair.first,
                style: style,
                semanticsLabel: pair.first,
              ),
              Text
              (
                pair.second,
                style: secondStyle,
                semanticsLabel: pair.second,
              )
            ],
          ),
        ),
      ),
    );
  }
}