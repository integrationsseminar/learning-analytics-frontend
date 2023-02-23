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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              shrinkWrap: true,
              children: [
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
                                  ? const AddFrage(
                                      initialIndex: 0,
                                      initialText: "UmfrageXY",
                                    )
                                  : const AddFrage(
                                      initialIndex: 1,
                                      initialText: "UmfrageXY",
                                    ),
                            ));
                      },
                      itemBuilder: (BuildContext bc) {
                        return [
                          PopupMenuItem(
                            child: Text("Umfrage aus Vorlage erstellen",
                                style: Theme.of(context).textTheme.titleSmall),
                            value: false,
                          ),
                          PopupMenuItem(
                            child: Text("Unterhaltung aus Vorlage erstellen",
                                style: Theme.of(context).textTheme.titleSmall),
                            value: true,
                          )
                        ];
                      }),
                  title: const Text("UmfrageXY"),
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddFrage(),
                        ));
                  },
                )
              ],
            )),
        bottomNavigationBar: BottomMenu(index: 1));
  }
}
