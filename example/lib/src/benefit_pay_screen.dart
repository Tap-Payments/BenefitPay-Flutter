import 'dart:developer' as developer;

import 'package:benefit_pay_flutter/benefit_pay_flutter.dart';
import 'package:flutter/material.dart';

class BenefitPayScreen extends StatefulWidget {
  final Map<String, dynamic> dictionaryMap;

  const BenefitPayScreen({
    super.key,
    required this.dictionaryMap,
  });

  @override
  State<BenefitPayScreen> createState() => _BenefitPayScreenState();
}

class _BenefitPayScreenState extends State<BenefitPayScreen> {
  String sdkResponse = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 50,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: SelectableText(
              sdkResponse.isEmpty ? " " : "SDK RESPONSE : $sdkResponse",
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: TapBenefitPayWidget(
          sdkConfiguration: widget.dictionaryMap,
          onReady: () {
            developer.log(">ON READY >>>>");
            setState(() {
              sdkResponse += ">ON READY >>>>\n";
            });
          },
          onCancel: () {
            developer.log(">ON CANCEL >>>>");
            setState(() {
              sdkResponse += ">ON CANCEL >>>>\n";
            });
          },
          onSuccess: (String? value) {
            developer.log(">ON SUCCESS >>>> $value");
            setState(() {
              sdkResponse += ">ON SUCCESS >>>> $value\n";
            });
          },
          onError: (String? error) {
            developer.log(">ON ERROR >>>> $error");
            setState(() {
              sdkResponse += ">ON ERROR >>>> $error\n";
            });
          },
          onClick: () {
            setState(() {
              sdkResponse += ">ON CLICK >>>>\n";
            });
          },
          onOrderCreated: (String? value) {
            developer.log(">ON ORDER CREATED >>>> $value");
            setState(() {
              sdkResponse += ">ON ORDER CREATED >>>> $value\n";
            });
          },
          onChargeCreated: (String? value) {
            developer.log(">ON CHARGE CREATED >>>> $value");
            setState(() {
              sdkResponse += ">ON CHARGE CREATED >>>> $value\n";
            });
          },
        ),
      ),
    );
  }
}
