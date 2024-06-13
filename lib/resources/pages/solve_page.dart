import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/custom_card_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import "package:flutter_app/app/networking/api_service.dart";
import "package:flutter_app/resources/widgets/keyboard_button_widget.dart";

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
    Future taskf =
        apiService.getTask(data["id"], data["complexity"], data["topics"]);
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                                    textScaler: data["id"] != 15
                                        ? TextScaler.linear(2)
                                        : TextScaler.linear(1),
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
                        decoration: InputDecoration(
                            labelText: "math.placeholder".tr(),
                            hintText: data["placeholder"],
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            )),
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
                                  showToastInfo(
                                      title: "math.skip_title".tr(),
                                      description: "math.error".tr(
                                        arguments: {
                                          "right": task["solution"][0]
                                        },
                                      ),
                                      style:
                                          ToastNotificationStyleType.WARNING);
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
                                  if (task["solution"]
                                      .contains(answerController.text)) {
                                    await apiService.solvedTask(
                                        data["id"], data["complexity"]);
                                    showToastInfo(
                                        title: "math.right_title".tr(),
                                        description: "math.right".tr(),
                                        style:
                                            ToastNotificationStyleType.SUCCESS);
                                  } else {
                                    showToastInfo(
                                        title: "math.error_title".tr(),
                                        description: "math.error".tr(
                                            arguments: {
                                              "right": task["solution"][0]
                                            }),
                                        style:
                                            ToastNotificationStyleType.DANGER);
                                  }
                                  nextTask();
                                },
                                child: Text("math.next".tr())),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: KeyboardButtonWidget(
                              text: ">",
                              controller: answerController,
                              context: context,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: KeyboardButtonWidget(
                              text: "≥",
                              controller: answerController,
                              context: context,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: KeyboardButtonWidget(
                              text: "≤",
                              controller: answerController,
                              context: context,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: KeyboardButtonWidget(
                              text: "<",
                              controller: answerController,
                              context: context,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: KeyboardButtonWidget(
                              text: "x",
                              controller: answerController,
                              context: context,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: KeyboardButtonWidget(
                              text: "√",
                              controller: answerController,
                              context: context,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: KeyboardButtonWidget(
                              text: "/",
                              controller: answerController,
                              context: context,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: KeyboardButtonWidget(
                              text: "∞",
                              controller: answerController,
                              context: context,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
