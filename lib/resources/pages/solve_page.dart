import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/resources/widgets/custom_card_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import "package:flutter_app/app/networking/api_service.dart";

class SolvePage extends NyStatefulWidget {
  static const path = '/solve';

  SolvePage({super.key}) : super(path, child: _SolvePageState());
}

class _SolvePageState extends NyState<SolvePage> {
  final ApiService apiService = ApiService();
  final TextEditingController answerController = TextEditingController();

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  void nextTask() {
    setState(() {
      answerController.clear();
    });
  }

  @override
  init() async {}

  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }

  @override
  Widget view(BuildContext context) {
    var data = widget.data();
    Future taskf = apiService.getTask(data["id"], data["complexity"]);
    return Scaffold(
      appBar: AppBar(title: Text("math.page_name".tr())),
      body: FutureBuilder(
        future: taskf,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map task = snapshot.data;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: CustomCard(
                              title: Text("math.solve".tr(),
                                  textScaler: TextScaler.linear(1.5)),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  task["problem"],
                                  textScaler: data["id"] != 15 ? TextScaler.linear(2) : TextScaler.linear(1),
                                ),
                              ),
                              onTap: null,
                              height: data["id"] != 15 ? 100 : 150),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: answerController,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                                // Skip task
                                nextTask();
                              },
                              child: Text(
                                "math.skip".tr(),
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () async {
                                // Answer task
                                if (answerController.text.isEmpty) return;
                                if (answerController.text == task["solution"]) {
                                  await apiService.solvedTask(
                                      data["id"], data["complexity"]);
                                  print("Right!");
                                  showToastInfo(
                                      title: "general.info".tr(),
                                      description: "math.right".tr(),
                                      style:
                                          ToastNotificationStyleType.SUCCESS);
                                } else {
                                  showToastInfo(
                                      title: "math.error_title".tr(),
                                      description: "math.error".tr(arguments: {
                                        "right": task["solution"]
                                      }),
                                      style:
                                          ToastNotificationStyleType.WARNING);
                                }
                                nextTask();
                              },
                              child: Text("math.next".tr())),
                        )
                      ],
                    ),
                    Spacer(),
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
      ),
    );
  }
}
