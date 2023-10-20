import 'package:banefit_pay_flutter_example/src/banefit_pay_screen.dart';
import 'package:banefit_pay_flutter_example/src/utils/utils.dart';
import 'package:banefit_pay_flutter_example/src/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigSettingsScreen extends StatefulWidget {
  const ConfigSettingsScreen({super.key});

  @override
  State<ConfigSettingsScreen> createState() => _ConfigSettingsScreenState();
}

class _ConfigSettingsScreenState extends State<ConfigSettingsScreen> {
  /// Bool Selection
  /// Variable Declaration
  bool editable = true;
  bool acceptanceBadge = true;
  bool scanner = true;
  bool nfc = false;
  bool saveCard = true;
  bool autoSaveCard = true;
  bool cardHolder = true;
  bool cvv = true;
  bool loader = true;

  /// Text Form Fields
  /// Variable Declaration
  TextEditingController publicKeyController = TextEditingController(
    text: "pk_live_0zHLeUTOXBNEyJ8p6csbK52m",
  );
  TextEditingController hashStringKeyController = TextEditingController(
    text: "pk_live_0zHLeUTOXBNEyJ8p6csbK52m",
  );

  TextEditingController transactionReferenceController = TextEditingController(
    text: "",
  );
  TextEditingController transactionIdController = TextEditingController();
  TextEditingController transactionContractIdController =
      TextEditingController();
  TextEditingController orderIdController = TextEditingController();
  TextEditingController orderAmountController =
      TextEditingController(text: "1");
  TextEditingController orderCurrencyController = TextEditingController(
    text: "KWD",
  );
  TextEditingController orderDescriptionController = TextEditingController(
    text: "Authentication description",
  );
  TextEditingController linkToAnInvoiceController = TextEditingController();
  TextEditingController merchantIdController = TextEditingController();
  TextEditingController customerIdController = TextEditingController();
  TextEditingController nameOnCardController = TextEditingController(
    text: "TAP PAYMENTS",
  );

  /// Scope
  /// List of scope for the user selection
  /// List & Variable Declaration

  String selectedScopeValue = "AuthenticatedToken";
  List<String> scopeList = [
    "Token",
    "AuthenticatedToken",
    "SaveToken",
    "SaveAuthenticatedToken",
  ];

  /// Purpose
  /// List of purpose for the user selection
  /// List & Variable Declaration

  String selectedPurposeValue = "Transaction";
  List<String> purposeList = [
    "Transaction",
    "Save Card",
    "Verify Cardholder",
    "Order Transaction",
    "Subscription Transaction",
    "Billing Transaction",
    "Installment Transaction",
    "Milestone Transaction",
    "Maintain Card"
  ];

  /// Locale
  /// List of locale for the user selection
  /// List & Variable Declaration
  String selectedLocaleValue = "en";
  List<String> localeList = ["en", "ar"];

  /// Theme
  /// List of theme for the user selection
  /// List & Variable Declaration
  String selectedThemeValue = "light";
  List<String> themeList = ["light", "dark"];

  /// Edges
  /// List of edges for the user selection
  /// List & Variable Declaration
  String selectedEdgesValue = "curved";
  List<String> edgesList = ["curved", "flat"];

  /// Card Direction
  /// List of card direction for the user selection
  /// List & Variable Declaration
  String selectedCardDirectionValue = "dynamic";
  List<String> cardDirectionList = ["ltr", "rtl", "dynamic"];

  /// Color style
  /// List of color style for the user selection
  /// List & Variable Declaration
  String selectedColorStyleValue = "monochrome";

  List<String> colorStyleList = ["colored", "monochrome"];

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showSingleValueSelectionActionSheet({
    required BuildContext context,
    required List<String> items,
    bool? scopeSelection,
    bool? purposeSelection,
    bool? localeSelection,
    bool? themeSelection,
    bool? edgesSelection,
    bool? cardDirectionSelection,
    bool? colorStyleSelection,
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
                  if (scopeSelection == true) {
                    setState(() {
                      selectedScopeValue = e;
                    });
                  }

                  if (purposeSelection == true) {
                    setState(() {
                      selectedPurposeValue = e;
                    });
                  }
                  if (localeSelection == true) {
                    setState(() {
                      selectedLocaleValue = e;
                    });
                  }
                  if (themeSelection == true) {
                    setState(() {
                      selectedThemeValue = e;
                    });
                  }
                  if (edgesSelection == true) {
                    setState(() {
                      selectedEdgesValue = e;
                    });
                  }
                  if (cardDirectionSelection == true) {
                    setState(() {
                      selectedCardDirectionValue = e;
                    });
                  }
                  if (colorStyleSelection == true) {
                    setState(() {
                      selectedColorStyleValue = e;
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
          ).toList()),
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
            gapH24,
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
            gapH24,
            const LabelTextWidget(label: "Order"),
            gapH4,
            CustomInputFieldWidget(
              fieldName: 'order id',
              controller: orderIdController,
              hintText: "Enter your order id",
            ),
            const CustomDividerWidget(),
            CustomInputFieldWidget(
              fieldName: 'reference',
              controller: transactionReferenceController,
            ),
            const CustomDividerWidget(),
            CustomInputFieldWidget(
              fieldName: 'order amount',
              controller: orderAmountController,
            ),
            const CustomDividerWidget(),
            CustomInputFieldWidget(
              fieldName: 'order currency',
              controller: orderCurrencyController,
            ),
            const CustomDividerWidget(),
            CustomInputFieldWidget(
              fieldName: 'order description',
              controller: orderDescriptionController,
            ),
            gapH24,
            const LabelTextWidget(label: "Invoice"),
            gapH4,
            CustomInputFieldWidget(
              fieldName: 'Link to an invoice',
              controller: linkToAnInvoiceController,
              hintText: "Enter your invoice id",
            ),
            gapH24,
            const LabelTextWidget(label: "Merchant"),
            gapH4,
            CustomInputFieldWidget(
              fieldName: 'merchant id',
              controller: merchantIdController,
              hintText: "Enter your merchant id",
            ),
            gapH24,
            const LabelTextWidget(label: "Customer"),
            gapH4,
            CustomInputFieldWidget(
              fieldName: 'Customer id',
              controller: customerIdController,
              hintText: "Enter customer's id",
            ),
            gapH24,
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
              keyName: 'theme',
              selectedValueName: selectedThemeValue,
              onTap: () {
                _showSingleValueSelectionActionSheet(
                  context: context,
                  items: themeList,
                  themeSelection: true,
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
            const CustomDividerWidget(),
            SwitchListTileWidget(
              title: "loader",
              value: loader,
              onChange: (value) {
                setState(() {
                  loader = value!;
                });
              },
            ),
            const CustomDividerWidget(),
            SingleValueSelectionWidget(
              keyName: 'colorStyle',
              selectedValueName: selectedColorStyleValue,
              onTap: () {
                _showSingleValueSelectionActionSheet(
                  context: context,
                  items: colorStyleList,
                  colorStyleSelection: true,
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
                      builder: (context) => BanefitPayScreen(
                        dictionaryMap: {
                          "post": const {"url": ""},
                          "customer": {
                            "id": customerIdController.text,
                            "name": const [
                              {
                                "first": "TAP",
                                "middle": "",
                                "lang": "en",
                                "last": "PAYMENTS"
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
                          "merchant": {
                            "id": merchantIdController.text,
                          },
                          "interface": {
                            "colorStyle": selectedColorStyleValue,
                            "theme": selectedThemeValue,
                            "locale": selectedLocaleValue,
                            "edges": selectedEdgesValue,
                            "loader": loader,
                          },
                          "operator": {
                            "publicKey": publicKeyController.text,
                            "hashString": ""
                          },
                          "order": {
                            "description": orderDescriptionController.text,
                            "currency": orderCurrencyController.text,
                            "amount": orderAmountController.text,
                            "id": orderIdController.text,
                            "reference": transactionReferenceController.text,
                            "metadata": const {"a": "abc"}
                          },
                          "invoice": {
                            "id": linkToAnInvoiceController.text,
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
