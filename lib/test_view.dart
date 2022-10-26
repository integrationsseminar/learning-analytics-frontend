import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  final views = [
    '/',
    '/meinLernenD',
    '/meinProfilD',
    '/meineKurseD',
    '/meinFortschrittS',
    '/meinLernenS',
    '/meinProfilS',
    '/login',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('An welcher view hast du entwickelt?')),
      body: ListView.builder(
        shrinkWrap: false,
        itemCount: views.length,
        itemBuilder: (BuildContext context, int index) {
          return TextButton(
              onPressed: () => {Navigator.of(context).pushNamed(views[index])},
              child: Text(views[index].substring(1, views[index].length)));
        },
      ),
    );
  }
}
