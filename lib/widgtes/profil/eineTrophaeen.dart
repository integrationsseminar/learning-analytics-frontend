import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class EineTrophaee extends StatelessWidget {
  final String text;
  final double tier;
  const EineTrophaee({Key? key, required this.text, required this.tier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
            decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                shape: BoxShape.circle),
            child: CircularPercentIndicator(
              radius: 25,
              lineWidth: 6,
              percent: tier,
              center:
                  const Icon(Icons.emoji_events, color: Colors.white, size: 20),
              backgroundColor: Colors.white,
              progressColor: Theme.of(context).primaryColorLight,
            )

            //const Icon(Icons.emoji_events, color: Colors.white, size: 30),
            ),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text(text, style: Theme.of(context).textTheme.labelSmall),
          ),
        )
      ],
    );
  }
}
