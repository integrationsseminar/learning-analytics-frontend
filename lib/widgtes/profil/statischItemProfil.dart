import 'package:flutter/material.dart';

class EditirbaresItemProfil extends StatelessWidget {
  final String label;
  final String value;
  const EditirbaresItemProfil(
      {Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          width: 180,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: RichText(
                text: WidgetSpan(
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.labelSmall,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
