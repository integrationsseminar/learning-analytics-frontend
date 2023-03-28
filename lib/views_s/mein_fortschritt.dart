import 'package:flutter/material.dart';
import 'package:learning_analytics/data/http_helper.dart';
import 'package:learning_analytics/data/progressValues.dart';
import 'package:learning_analytics/widgtes/customappbar.dart';
import 'package:learning_analytics/widgtes/fortschritt/angaben.dart';
import 'package:learning_analytics/widgtes/shared/divider.dart';
import 'package:learning_analytics/widgtes/shared/bottom_menu.dart';
import '../data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MeinFortschrittS extends StatefulWidget {
  const MeinFortschrittS({Key? key}) : super(key: key);

  @override
  State<MeinFortschrittS> createState() => _MeinFortschrittSState();
}

class _MeinFortschrittSState extends State<MeinFortschrittS> {
  late HttpHelper httpHelper;
  late String dropDownValue0 = "Sehr hoch";
  late String dropDownValue1 = "Sehr hoch";
  late String dropDownValue2 = "Sehr hoch";
  late String dropDownValue3 = "Sehr hoch";
  late String dropDownValue4 = "Sehr hoch";

  bool fetching = true;

  late List<ProgressValues> chartData = [];

  List<String> list = <String>[
    'Sehr hoch',
    'Hoch',
    'Mittel',
    'Gering',
    'Sehr gering'
  ];

  late TooltipBehavior tooltipBehavior;

  int tabsAmount = 2;

  @override
  initState() {
    tooltipBehavior = TooltipBehavior(enable: true);
    getProgressValues();
    httpHelper = HttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fetching
        ? const Center(child: CircularProgressIndicator())
        : Column(children: [
            Stack(children: const [
              Positioned(
                child: SizedBox(
                    height: 160,
                    child: CustomAppBar(
                        title: "Mein Fortschritt", backToPage: "")),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultTabController(
                        length: tabsAmount,
                        initialIndex: 0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              if (tabsAmount == 2)
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 10, 8, 0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          width: 2.0,
                                          color:
                                              Theme.of(context).highlightColor,
                                          style: BorderStyle.solid),
                                    ),
                                    child: TabBar(
                                      onTap: (index) {
                                        if (index == 1) {
                                          fetching = true;
                                          getProgressValues();
                                        }
                                      },
                                      indicator: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              Theme.of(context).highlightColor),
                                      labelColor:
                                          Theme.of(context).primaryColor,
                                      unselectedLabelColor: Colors.black,
                                      tabs: [
                                        Tab(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text("Tracker",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium),
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text("Statistik",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              SizedBox(
                                height: tabsAmount == 2 ? 410 : 470,
                                child: TabBarView(children: [
                                  //Fragen
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height: 323,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: BorderSide(
                                                color: Theme.of(context)
                                                    .highlightColor,
                                                style: BorderStyle.solid,
                                                width: 3),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Lernmotivation",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                        child: DropdownButton(
                                                          value: dropDownValue0,
                                                          items: list.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              dropDownValue0 =
                                                                  value!;
                                                            });
                                                          },
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                          underline:
                                                              const SizedBox(),
                                                          icon: const Icon(Icons
                                                              .arrow_drop_down_rounded),
                                                          iconSize: 15,
                                                        ),
                                                      ),
                                                    ]),
                                                const DividerWidget(),
                                                //----------------------------------------------------
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Lernaufwand",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                        child: DropdownButton(
                                                          value: dropDownValue1,
                                                          items: list.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              dropDownValue1 =
                                                                  value!;
                                                            });
                                                          },
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                          underline:
                                                              const SizedBox(),
                                                          icon: const Icon(Icons
                                                              .arrow_drop_down_rounded),
                                                          iconSize: 15,
                                                        ),
                                                      ),
                                                    ]),
                                                const DividerWidget(),
                                                //----------------------------------------------------
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Lernerfolg",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                        child: DropdownButton(
                                                          value: dropDownValue2,
                                                          items: list.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              dropDownValue2 =
                                                                  value!;
                                                            });
                                                          },
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                          underline:
                                                              const SizedBox(),
                                                          icon: const Icon(Icons
                                                              .arrow_drop_down_rounded),
                                                          iconSize: 15,
                                                        ),
                                                      ),
                                                    ]),
                                                const DividerWidget(),
                                                //----------------------------------------------------
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Stresslevel",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                        child: DropdownButton(
                                                          value: dropDownValue3,
                                                          items: list.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              dropDownValue3 =
                                                                  value!;
                                                            });
                                                          },
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                          underline:
                                                              const SizedBox(),
                                                          icon: const Icon(Icons
                                                              .arrow_drop_down_rounded),
                                                          iconSize: 15,
                                                        ),
                                                      ),
                                                    ]),
                                                const DividerWidget(),
                                                //----------------------------------------------------
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Hochschulbindung",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                        child: DropdownButton(
                                                          value: dropDownValue4,
                                                          items: list.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              dropDownValue4 =
                                                                  value!;
                                                            });
                                                          },
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                          underline:
                                                              const SizedBox(),
                                                          icon: const Icon(Icons
                                                              .arrow_drop_down_rounded),
                                                          iconSize: 15,
                                                        ),
                                                      ),
                                                    ]),

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8.0, 40.0, 8.0, 0.0),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: MaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                      height: 32.0,
                                                      minWidth: 120.0,
                                                      color: Theme.of(context)
                                                          .highlightColor,
                                                      textColor: Colors.black,
                                                      onPressed: () => {
                                                        sendData([
                                                          dropDownValue0,
                                                          dropDownValue1,
                                                          dropDownValue2,
                                                          dropDownValue3,
                                                          dropDownValue4
                                                        ])
                                                      },
                                                      splashColor:
                                                          Colors.redAccent,
                                                      child: const Text(
                                                        "Speichern",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ), //Umfragen
                                  if (tabsAmount == 2)
                                    Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              style: BorderStyle.solid,
                                              width: 3),
                                        ),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SfCartesianChart(
                                            title: ChartTitle(
                                              text: "Fortschritt",
                                            ),
                                            legend: Legend(isVisible: true),
                                            palette: const [
                                              Color.fromRGBO(195, 0, 255, 1),
                                              Color.fromRGBO(255, 0, 195, 1),
                                              Color.fromRGBO(227, 6, 19, 1),
                                              Color.fromRGBO(255, 98, 0, 1),
                                              Color.fromRGBO(247, 158, 4, 1),
                                              Color.fromRGBO(239, 239, 1, 1),
                                              Color.fromRGBO(6, 231, 10, 1),
                                              Color.fromRGBO(1, 237, 178, 1),
                                              Color.fromRGBO(0, 73, 243, 1),
                                              Color.fromRGBO(93, 0, 255, 1),
                                              Color.fromRGBO(0, 0, 0, 1)
                                            ],
                                            tooltipBehavior: tooltipBehavior,
                                            primaryXAxis: CategoryAxis(),
                                            series: <ChartSeries>[
                                              LineSeries<ProgressValues,
                                                  String>(
                                                name: "Lernmotivation",
                                                markerSettings:
                                                    const MarkerSettings(
                                                        isVisible: true),
                                                width: 3,
                                                dataSource: chartData,
                                                xValueMapper: (ProgressValues
                                                            val,
                                                        _) =>
                                                    "${val.date.day}-${val.date.month}-${val.date.year}",
                                                yValueMapper:
                                                    (ProgressValues val, _) =>
                                                        val.lernmotivation,
                                              ),
                                              LineSeries<ProgressValues,
                                                  String>(
                                                name: "Lernaufwand",
                                                markerSettings:
                                                    const MarkerSettings(
                                                        isVisible: true),
                                                width: 3,
                                                dataSource: chartData,
                                                xValueMapper: (ProgressValues
                                                            val,
                                                        _) =>
                                                    "${val.date.day}-${val.date.month}-${val.date.year}",
                                                yValueMapper:
                                                    (ProgressValues val, _) =>
                                                        val.lernaufwand,
                                              ),
                                              LineSeries<ProgressValues,
                                                  String>(
                                                name: "Lernerfolg",
                                                markerSettings:
                                                    const MarkerSettings(
                                                        isVisible: true),
                                                width: 3,
                                                dataSource: chartData,
                                                xValueMapper: (ProgressValues
                                                            val,
                                                        _) =>
                                                    "${val.date.day}-${val.date.month}-${val.date.year}",
                                                yValueMapper:
                                                    (ProgressValues val, _) =>
                                                        val.lernerfolg,
                                              ),
                                              LineSeries<ProgressValues,
                                                  String>(
                                                name: "Stresslevel",
                                                markerSettings:
                                                    const MarkerSettings(
                                                        isVisible: true),
                                                width: 3,
                                                dataSource: chartData,
                                                xValueMapper: (ProgressValues
                                                            val,
                                                        _) =>
                                                    "${val.date.day}-${val.date.month}-${val.date.year}",
                                                yValueMapper:
                                                    (ProgressValues val, _) =>
                                                        val.stresslevel,
                                              ),
                                              LineSeries<ProgressValues,
                                                  String>(
                                                name: "Hochschulbindung",
                                                markerSettings:
                                                    const MarkerSettings(
                                                        isVisible: true),
                                                width: 3,
                                                dataSource: chartData,
                                                xValueMapper: (ProgressValues
                                                            val,
                                                        _) =>
                                                    "${val.date.day}-${val.date.month}-${val.date.year}",
                                                yValueMapper:
                                                    (ProgressValues val, _) =>
                                                        val.hochschulbindung,
                                              )
                                            ],
                                          ),
                                        )))
                                ]),
                              )
                            ])),
                  ]),
            ),
          ]);
  }

  void sendData(List<String> dropDownValues) async {
    final prefs = await SharedPreferences.getInstance();
    List<int> answers = [];
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    for (var value in dropDownValues) {
      int intValue = 0;
      switch (value) {
        case "Sehr hoch":
          intValue = 5;
          break;
        case "Hoch":
          intValue = 4;
          break;
        case "Mittel":
          intValue = 3;
          break;
        case "Gering":
          intValue = 2;
          break;
        case "Sehr gering":
          intValue = 1;
          break;
        default:
          intValue = 0;
      }
      answers.add(intValue);
    }
    Future<bool> resultPostLearningprogress =
        httpHelper.postLearningprogress(jwt, answers);

    setState(() {});
  }

  void getProgressValues() async {
    final prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("jwt");
    jwt ??=
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzQ5NjI1YzRkMjRlODlhZTJkZjg0NzUiLCJyb2xlIjoiTGVjdHVyZXIiLCJpYXQiOjE2NjY4MDkzNTksImV4cCI6MTY2NjgyMzc1OX0.hPw63fzL_GP_hYpMwuaxpYbyxqSCtw4Su91s9ge51Qk";
    List<ProgressValues> resultGetLearningprogress =
        await httpHelper.getLearningprogress(jwt);

    setState(() {
      chartData = resultGetLearningprogress;
      fetching = false;
    });
  }
}
