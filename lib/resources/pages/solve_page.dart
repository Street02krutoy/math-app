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
  ApiService apiService = ApiService();

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
                                  textScaler: TextScaler.linear(2),
                                ),
                              ),
                              onTap: null,
                              height: 100),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
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
                              onPressed: () {},
                              child: Text(
                                "math.skip".tr(),
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("math.next".tr())),
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
