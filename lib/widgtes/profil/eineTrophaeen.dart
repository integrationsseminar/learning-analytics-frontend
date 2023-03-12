import 'package:flutter/material.dart';

class EineTrophaee extends StatelessWidget {
  final String text;
  const EineTrophaee({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
            decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                shape: BoxShape.circle),
            child:
                const Icon(Icons.emoji_events, color: Colors.white, size: 30),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(text, style: Theme.of(context).textTheme.labelSmall),
            ),
          )
        ],
      ),
    );
  }
}
