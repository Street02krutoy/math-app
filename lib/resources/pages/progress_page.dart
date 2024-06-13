import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/networking/api_service.dart';
import 'package:flutter_app/resources/widgets/progress_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressPage extends NyStatefulWidget {
  static const path = '/progress';

  ProgressPage({super.key}) : super(path, child: _ProgressPageState());
}

class _ProgressPageState extends NyState<ProgressPage> {
  Future fetch() async {
    dump("s");
    _future = ApiService().getUserProgress();
  }

  @override
  init() async {
    fetch();
  }

  static Future<dynamic>? _future;

  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }
  List<DoughnutData>? dataSource;

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget view(BuildContext context) {
    fetch();
    return Scaffold(
      appBar: AppBar(title: Text("progress.page_name".tr())),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              fetch();
            });
            await _future;
          },
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                dataSource = List.generate(snapshot.data!.length, (int index) {
                  return DoughnutData(
                      name: snapshot.data[index]["name"],
                      count: snapshot.data[index]["solved_tasks"],
                      color: fromHex(snapshot.data[index]["color"]));
                });
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 300,
                          child: SfCircularChart(
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              format: "point.x",
                            ),
                            series: [
                              DoughnutSeries<DoughnutData, String>(
                                //explode: true,
                                dataSource: dataSource,
                                pointColorMapper: (datum, int index) =>
                                    datum.color,
                                xValueMapper: (datum, int index) => datum.name,
                                yValueMapper: (datum, int index) => datum.count,
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  showZeroValue: false,
                                  showCumulativeValues: true,
                                  textStyle: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List<Widget>.generate(
                            snapshot.data!.length,
                            (int index) {
                              return ProgressWidget(
                                  color: fromHex(snapshot.data[index]["color"]),
                                  title: snapshot.data[index]["name"],
                                  done: DoneLevels(
                                      easy: snapshot.data[index]
                                          ["easy_solved_tasks"],
                                      hard: snapshot.data[index]
                                          ["hard_solved_tasks"],
                                      medium: snapshot.data[index]
                                          ["medium_solved_tasks"],
                                      all: snapshot.data[index]
                                          ["solved_tasks"]));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: Column(
                  children: [Spacer(), CircularProgressIndicator(), Spacer()],
                ),
              );
            },
            future: _future,
          ),
        ),
      ),
    );
  }
}

class DoughnutData {
  DoughnutData({required this.name, required this.count, required this.color});

  final String name;
  final int count;
  final Color color;
}
