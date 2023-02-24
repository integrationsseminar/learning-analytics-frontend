import 'package:flutter/material.dart';
import '../widgtes/shared/bottom_menu.dart';
import './add_fragen_view.dart';

class AddFrageTemplate extends StatefulWidget {
  const AddFrageTemplate({Key? key}) : super(key: key);

  @override
  State<AddFrageTemplate> createState() => _AddFrageTemplateState();
}

class _AddFrageTemplateState extends State<AddFrageTemplate> {
  var selectedItem = true;
  var templates = [
    "Die Vorlesung am ... findet ... statt.",
    "Haben Sie die Unterlagen erhalten?",
    "Wie fanden Sie die letzte Vorlesung?",
    "Brauchen Sie weitere Hilfe für die Vorbereitung auf die anstehende Prüfungsleistung?"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text("Vorlagen",
                          style: Theme.of(context).textTheme.titleLarge)),
                ),
                for (var template in templates)
                  ListTile(
                    leading: PopupMenuButton(
                        icon: const Icon(Icons.arrow_drop_down_outlined),
                        onSelected: (bool value) async {
                          setState(() {
                            selectedItem = value;
                          });
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => selectedItem
                                    ? AddFrage(
                                        initialIndex: 0,
                                        initialText: template,
                                      )
                                    : AddFrage(
                                        initialIndex: 1,
                                        initialText: template,
                                      ),
                              ));
                        },
                        itemBuilder: (BuildContext bc) {
                          return [
                            PopupMenuItem(
                              child: Text("Umfrage aus Vorlage erstellen",
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              value: false,
                            ),
                            PopupMenuItem(
                              child: Text("Unterhaltung aus Vorlage erstellen",
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              value: true,
                            )
                          ];
                        }),
                    title: Text(template),
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddFrage(
                                initialIndex: 0, initialText: template),
                          ));
                    },
                  )
              ],
            )),
        bottomNavigationBar: BottomMenu(index: 1));
  }
}
