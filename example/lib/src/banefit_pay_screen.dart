import 'package:banefit_pay_flutter/banefit_pay_flutter.dart';
import 'package:flutter/material.dart';

class BanefitPayScreen extends StatefulWidget {
  final Map<String, dynamic> dictionaryMap;

  const BanefitPayScreen({
    super.key,
    required this.dictionaryMap,
  });

  @override
  State<BanefitPayScreen> createState() => _BanefitPayScreenState();
}

class _BanefitPayScreenState extends State<BanefitPayScreen> {
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
              sdkResponse.isEmpty ? " " : "SDK RESPONSE : ${sdkResponse ?? ""}",
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: TapBanefitPayWidget(
          sdkConfiguration: widget.dictionaryMap,
          onReady: () {
            debugPrint(">ON READY >>>>");
          },
          onCancel: () {
            debugPrint(">ON CANCEL >>>>");
            setState(() {
              sdkResponse = "Cancelled";
            });
          },
          onSuccess: (String? value) {
            debugPrint(">ON SUCCESS >>>> $value");
            setState(() {
              sdkResponse = value ?? "";
            });
          },
          onError: (String? error) {
            debugPrint(">ON ERROR >>>> $error");
            setState(() {
              sdkResponse = error ?? "";
            });
          },
          onClick: () {},
          onOrderCreated: (String? value) {
            debugPrint(">ON ORDER CREATED >>>> $value");
            setState(() {
              sdkResponse = value ?? "";
            });
          },
          onChargeCreated: (String? value) {
            debugPrint(">ON CHARGE CREATED >>>> $value");
            setState(() {
              sdkResponse = value ?? "";
            });
          },
        ),
      ),
    );
  }
}
