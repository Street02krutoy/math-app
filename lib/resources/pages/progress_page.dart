import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/progress_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressPage extends NyStatefulWidget {
  static const path = '/progress';

  ProgressPage({super.key}) : super(path, child: _ProgressPageState());
}

class _ProgressPageState extends NyState<ProgressPage> {
  @override
  init() async {}

  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }
  List<DoughnutData>? dataSource;

  @override
  Widget view(BuildContext context) {
    dataSource = [
      DoughnutData(name: "name", count: 98),
      DoughnutData(name: "name", count: 12),
    ];
    return Scaffold(
      appBar: AppBar(title: Text("progress.page_name".tr())),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                child: SfCircularChart(
                  legend: Legend(isVisible: true),
                  series: [
                    DoughnutSeries<DoughnutData, String>(
                      //explode: true,

                      dataSource: dataSource,
                      xValueMapper: (datum, int index) =>
                          "${datum.name} - ${datum.count}",
                      yValueMapper: (datum, int index) => datum.count,
                      //dataLabelSettings: DataLabelSettings(isVisible: true)
                    ),
                  ],
                ),
              ),
              Column(
                children: List<Widget>.generate(10, (int index) {
                  return ProgressWidget(title: "title", done: index);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DoughnutData {
  DoughnutData({required this.name, required this.count});
  final String name;
  final int count;
}
