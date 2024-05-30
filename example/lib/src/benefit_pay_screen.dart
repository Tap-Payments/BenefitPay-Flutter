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
            child: Text(
              sdkResponse.isEmpty ? " " : "SDK RESPONSE : $sdkResponse",
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: TapBenefitPayWidget(
          sdkConfiguration: widget.dictionaryMap,
          onReady: () {
            developer.log(">ON READY >>>>");
          },
          onCancel: () {
            developer.log(">ON CANCEL >>>>");
            setState(() {
              sdkResponse = "Cancelled";
            });
          },
          onSuccess: (String? value) {
            developer.log(">ON SUCCESS >>>> $value");
            setState(() {
              sdkResponse = value ?? "";
            });
          },
          onError: (String? error) {
            developer.log(">ON ERROR >>>> $error");
            setState(() {
              sdkResponse = error ?? "";
            });
          },
          onClick: () {},
          onOrderCreated: (String? value) {
            developer.log(">ON ORDER CREATED >>>> $value");
            setState(() {
              sdkResponse = value ?? "";
            });
          },
          onChargeCreated: (String? value) {
            developer.log(">ON CHARGE CREATED >>>> $value");
            setState(() {
              sdkResponse = value ?? "";
            });
          },
        ),
      ),
    );
  }
}
