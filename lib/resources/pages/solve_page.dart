import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/resources/widgets/custom_card_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class SolvePage extends NyStatefulWidget {
  static const path = '/solve';

  SolvePage({super.key}) : super(path, child: _SolvePageState());
}

class _SolvePageState extends NyState<SolvePage> {
  @override
  init() async {}

  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("math.page_name".tr())),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Spacer(),
              CustomCard(
                  title: Text("math.solve".tr()),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "8+9",
                      textScaler: TextScaler.linear(2),
                    ),
                  ),
                  onTap: null,
                  height: 100),
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
      ),
    );
  }
}
