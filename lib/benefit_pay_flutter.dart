import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TapBenefitPayWidget extends StatefulWidget {
  /// SDK Configuration is required
  final Map<String, dynamic> sdkConfiguration;

  /// Some void callbacks
  final Function()? onReady, onClick, onCancel;

  /// Some callbacks with a optional String return type
  final Function(String?)? onSuccess, onError, onOrderCreated, onChargeCreated;

  const TapBenefitPayWidget({
    super.key,
    required this.sdkConfiguration,
    this.onReady,
    this.onClick,
    this.onSuccess,
    this.onError,
    this.onCancel,
    this.onChargeCreated,
    this.onOrderCreated,
  });

  @override
  State<TapBenefitPayWidget> createState() => _TapBenefitPayWidgetState();
}

class _TapBenefitPayWidgetState extends State<TapBenefitPayWidget> {
  /// These Functions we are using to sending callbacks values to the example application or the users of this sdk
  /// So with these we can send them back what we are receiving from the response
  late Function()? onReadyFunction;
  late Function()? onClickFunction;
  late Function()? onCancelFunction;
  late Function(String?)? onSuccessFunction;
  late Function(String?)? onErrorFunction;
  late Function(String?)? onChargeCreatedFunction;
  late Function(String?)? onOrderCreatedFunction;

  /// Method Channel
  static const MethodChannel _channel = MethodChannel('benefit_pay_flutter');

  /// Even Channel
  static const EventChannel _eventChannel = EventChannel('benefit_pay_event');

  /// Function to receive stream
  void streamTimeFromNative() {
    _eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  /// On event function to handle callbacks realtime
  void _onEvent(dynamic event) {
    handleCallbacks(event);
  }

  /// On error function in stream
  void _onError(dynamic event) {
    developer.log("ERROR >> $event");
  }

  /// Init state of the widget
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      streamTimeFromNative();
      startBenefitPaySDK();
    });
    super.initState();
  }

  //// Here we are starting the sdk using configuration from example or users app
  Future<dynamic> startBenefitPaySDK() async {
    try {
      developer
          .log(">>> Configuration => ${jsonEncode(widget.sdkConfiguration)}");
      Map<String, dynamic> configurations = widget.sdkConfiguration;
      configurations["paymentMethod"] = "benefitpay";
      dynamic result = await _channel.invokeMethod(
        'start',
        {
          "configuration": configurations,
        },
      );
      handleCallbacks(result);
      _startBenefitPaySDK2();
      // return responseData;
    } catch (ex) {
      developer.log("Start SDK Exception >>>>>> $ex");
    }
  }

  /// This function we have created as private to handle real time multiple callbacks from native sdks
  Future<dynamic> _startBenefitPaySDK2() async {
    try {
      dynamic result = await _channel.invokeMethod(
        'start2',
        {
          "configuration": widget.sdkConfiguration,
        },
      );

      handleCallbacks(result);
      _startBenefitPaySDK2();
      //  return responseData;
    } catch (ex) {
      developer.log("Exception >>>>>> $ex");
    }
  }

  /// Handle Callbacks Function
  /// Here we can handle each and every callback and send the result to the example or user app
  handleCallbacks(dynamic result) {
    developer.log(">>>> RESULT >>>> $result}");
    if (result.containsKey("onReady")) {
      developer.log("On ready callback fired");
      onReadyFunction = widget.onReady;
      onReadyFunction!();
    }

    if (result.containsKey("onClick")) {
      developer.log("On Click callback fired");
      onReadyFunction = widget.onReady;
      onReadyFunction!();
    }

    if (result.containsKey("onSuccess")) {
      developer.log("On Success callback fired");
      var resultOfSuccess = jsonDecode(result["onSuccess"]);
      onSuccessFunction = widget.onSuccess;
      onSuccessFunction!(resultOfSuccess.toString());
    }

    if (result.containsKey("onError")) {
      developer.log("On Error Callback Fired>>>>> ${result["onError"]} ");
      var resultOfError = jsonDecode(result["onError"]);
      onErrorFunction = widget.onError;
      onErrorFunction!(resultOfError.toString());
    }

    if (result.containsKey("onOrderCreated")) {
      developer.log("On Order Created Callback Fired>>>>>");
      var resultOfOnOrderCreated = jsonDecode(result["onOrderCreated"]);
      onOrderCreatedFunction = widget.onOrderCreated;
      onOrderCreatedFunction!(resultOfOnOrderCreated.toString());
    }

    if (result.containsKey("onCancel")) {
      developer.log("On Cancel Callback Fired>>>>>");
      onCancelFunction = widget.onCancel;
      onCancelFunction!();
    }

    if (result.containsKey("onChargeCreated")) {
      developer.log("On Charge Created Callback Fired>>>>>");
      var resultOfOnChargeCreated = jsonDecode(result["onChargeCreated"]);
      onChargeCreatedFunction = widget.onChargeCreated;
      onChargeCreatedFunction!(resultOfOnChargeCreated.toString());
    }
  }

  /// Widget to display Native View
  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return SizedBox(
        height: 60,
        child: Center(
          child: AndroidView(
            viewType: "plugin/benefit_pay_view",
            creationParams: widget.sdkConfiguration,
            creationParamsCodec: const StandardMessageCodec(),
            layoutDirection: TextDirection.ltr,
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 60,
        child: Center(
          child: UiKitView(
            viewType: "plugin/benefit_pay_view",
            creationParams: widget.sdkConfiguration,
            layoutDirection: TextDirection.ltr,
            creationParamsCodec: const StandardMessageCodec(),
          ),
        ),
      );
    }
  }
}
