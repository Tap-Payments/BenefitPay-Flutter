import 'package:benefit_pay_flutter_example/src/src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigSettingsScreen extends StatefulWidget {
  const ConfigSettingsScreen({super.key});

  @override
  State<ConfigSettingsScreen> createState() => _ConfigSettingsScreenState();
}

class _ConfigSettingsScreenState extends State<ConfigSettingsScreen> {
  /// Text Form Fields
  /// Variable Declaration
  TextEditingController publicKeyController = TextEditingController(
    text: "pk_test_Wa4ju8UC1zoi0HhST9yO3M6n",
  );
  TextEditingController hashStringKeyController = TextEditingController(
    text: "",
  );

  /// Transaction Text Controllers
  TextEditingController transactionAmountController =
      TextEditingController(text: "1");
  TextEditingController transactionCurrencyController = TextEditingController(
    text: "BHD",
  );

  /// Post URL Controller
  TextEditingController postURLController = TextEditingController(
    text: "",
  );

  /// Merchant ID Controller
  TextEditingController merchantIdController = TextEditingController();

  /// Customer ID Controller

  TextEditingController customerIdController = TextEditingController();

  /// Locale
  /// List of locale for the user selection
  /// List & Variable Declaration
  String selectedLocaleValue = "en";
  List<String> localeList = ["en", "ar"];

  /// Edges
  /// List of edges for the user selection
  /// List & Variable Declaration
  String selectedEdgesValue = "curved";
  List<String> edgesList = ["curved", "flat"];

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showSingleValueSelectionActionSheet({
    required BuildContext context,
    required List<String> items,
    bool? localeSelection,
    bool? edgesSelection,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: CupertinoColors.activeBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: items.map(
          (e) {
            return CupertinoActionSheetAction(
              onPressed: () {
                if (localeSelection == true) {
                  setState(() {
                    selectedLocaleValue = e;
                  });
                }

                if (edgesSelection == true) {
                  setState(() {
                    selectedEdgesValue = e;
                  });
                }

                Navigator.pop(context);
              },
              child: Text(
                e,
                style: TextStyle(
                  color: CupertinoColors.activeBlue,
                  fontWeight:
                      e == "Cancel" ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Configurations"),
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
      ),
      body: RawScrollbar(
        thumbVisibility: true,
        child: ListView(
          children: [
            gapH16,
            const LabelTextWidget(label: "Operator"),
            gapH4,
            CustomInputFieldWidget(
              fieldName: 'Public Key',
              controller: publicKeyController,
            ),
            const CustomDividerWidget(),
            CustomInputFieldWidget(
              fieldName: 'Hash String',
              controller: hashStringKeyController,
            ),
            gapH16,
            const LabelTextWidget(label: "Transaction"),
            gapH4,
            CustomInputFieldWidget(
              fieldName: 'transaction amount',
              controller: transactionAmountController,
            ),
            const CustomDividerWidget(),
            CustomInputFieldWidget(
              fieldName: 'transaction currency',
              controller: transactionCurrencyController,
            ),
            gapH16,
            const LabelTextWidget(label: "Merchant"),
            gapH4,
            CustomInputFieldWidget(
              fieldName: 'merchant id',
              controller: merchantIdController,
              hintText: "Enter your merchant id",
            ),
            gapH16,
            const LabelTextWidget(label: "Post URL"),
            gapH4,
            CustomInputFieldWidget(
              fieldName: 'Post url',
              controller: postURLController,
              hintText: "post url",
            ),
            gapH16,
            const LabelTextWidget(label: "Customer"),
            gapH4,
            CustomInputFieldWidget(
              fieldName: 'Customer id',
              controller: customerIdController,
              hintText: "Enter customer's id",
            ),
            gapH16,
            const LabelTextWidget(label: "Interface"),
            gapH4,
            const CustomDividerWidget(),
            SingleValueSelectionWidget(
              keyName: 'locale',
              selectedValueName: selectedLocaleValue,
              onTap: () {
                _showSingleValueSelectionActionSheet(
                  context: context,
                  items: localeList,
                  localeSelection: true,
                );
              },
            ),
            const CustomDividerWidget(),
            SingleValueSelectionWidget(
              keyName: 'edges',
              selectedValueName: selectedEdgesValue,
              onTap: () {
                _showSingleValueSelectionActionSheet(
                  context: context,
                  items: edgesList,
                  edgesSelection: true,
                );
              },
            ),
            gapH40,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BenefitPayScreen(
                        dictionaryMap: {
                          "post": const {"url": ""},
                          "operator": {
                            "publicKey": publicKeyController.text,
                            "hashString": ""
                          },
                          "transaction": {
                            "amount": transactionAmountController.text,
                            "currency": transactionCurrencyController.text,
                          },
                          "merchant": {
                            "id": merchantIdController.text,
                          },
                          "customer": {
                            "id": customerIdController.text,
                            "names": const [
                              {
                                "first": "TAP",
                                "middle": "",
                                "last": "PAYMENTS",
                                "lang": "en",
                              }
                            ],
                            "contact": const {
                              "email": "tap@tap.company",
                              "phone": {
                                "countryCode": "+965",
                                "number": "88888888"
                              }
                            },
                          },
                          "interface": {
                            "locale": selectedLocaleValue,
                            "edges": selectedEdgesValue,
                          },
                        },
                      ),
                    ),
                  );
                },
                child: const Text("Next"),
              ),
            ),
            gapH40,
          ],
        ),
      ),
    );
  }
}
