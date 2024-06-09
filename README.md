



# BenefitPay-Flutter

Integrating Flutter BenefitPay SDK in your application

# Introduction[](https://developers.tap.company/docs/benefit_pay_flutter#introduction)

Before diving into the development process, it's essential to establish the prerequisites and criteria necessary for a successful build. In this step, we'll outline the specific iOS/Android requirements, including the minimum SDK version and other important details you need to consider. Let's ensure your project is set up for success from the very beginning.

# Sample Demo

![enter image description here](https://raw.githubusercontent.com/Tap-Payments/BenefitPay-iOS/main/ezgif.com-optimize-3.gif)



# Step 1: Requirements[](https://developers.tap.company/docs/benefit-pay-flutter#step-1-requirements)

- We support from iOS 13.0+
- Dart 3.0.0+
- Java version 11
- A minimum  [Android SDK/API level](https://developer.android.com/guide/topics/manifest/uses-sdk-element#ApiLevels) of 24
- in order to accept online payments on your application, you will need to add at least the Internet permission in the manifest file.
```xml    
<uses-permission android:name="android.permission.INTERNET" /> //get internet access to complete online payments   
```   

# Step 2: Get Your Public Keys[](https://developers.tap.company/docs/card-sdk-flutter#step-2-get-your-public-keys)

While you can certainly use the sandbox keys available within our sample app which you can get by following the  [installation](https://developers.tap.company/docs/android-card-sdk#step-3-installation-using-gradle) process, however, we highly recommend visiting our  [onboarding](https://register.tap.company/ae/en/sell) page, there you'll have the opportunity to register your package name and acquire your essential Tap Key for activating Card-Flutter integration. If you will support both iOS and Android, you will need to have two different keys for each app.

# Step 3: Installation[](https://developers.tap.company/docs/benefit_pay_flutter#step-3-installation)
In the  `pubspec.yaml` of your flutter project, add the following dependency:

dependencies:

```benefit_pay_flutter: ^0.0.2```


# Step 4: Integrating BenefitPay-Flutter[](https://developers.tap.company/docs/benefit_pay_flutter#step-4--integrating-benefit-pay-flutter)

## Integration Flow[](https://developers.tap.company/docs/benefit_pay_flutter#integration-flow)

Noting that in Flutter, you will use our button like any other widget. While creating, the widget you will also need to pass the parameters & listen to the callbacks based on your needs.

1. You will have to create a variable of type TapBenefitPayWidget
2. While intialising the widget:
    - Pass the parameters to the widget.
    - Implement the provided interfaces/callbacks
3. Our button widget is a stateful one, depends on stateful variable to listen to all callbacks.

### Using Code to create the TapBenefitPayWidget[](https://developers.tap.company/docs/benefit_pay_flutter#using-code-to-create-the-TapBenefitPayWidget)

-   **Creating the TapBenefitPayWidget from code**
1. Head to your controller where you want to display the `TapBenefitPayWidget` as a widget.
    2. Import `TapBenefitPayWidget` as follows  
       `import 'package:benefit_pay_flutter/benefit_pay_flutter.dart';`.
    4. In the coming code sample, we will show how to embed the button form within your widget tree.
```dart    
 TapBenefitPayWidget(    
   sdkConfiguration: const {},  
 ),   
```   

### Configuring the BenefitPay-Flutter SDK[](https://developers.tap.company/docs/benefit_pay_flutter#configuring-the-benefit-pay-flutter-sdk)

While creating the widget as previously mentioned, it is time to pass the parameters needed for the SDK to work as expected and serve your need correctly.

1. Pass these parameters to the TapBenefitPayWidget widget
```dart // We provide the button view the needed parameters. TapBenefitPayWidget(    
 sdkConfiguration: const {    
    "post": const {"url": ""},    
    "operator": {    
       "publicKey": "pk_test_HJN863LmO15EtDgo9cqK7sjS",    
       "hashString": ""    
    },    
    "transaction": {    
       "amount": 1.0,    
       "currency": "BHD",    
     },
    "reference" : const { "transaction" : "transaction", "order" : "order" },    
    "merchant": {    
       "id": "",    
     },    
     "customer": {    
       "id": "",    
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
    "locale": "en",    
    "edges": "flat",   
}, },   
```   
**Full code snippet for creating the parameters + passing it TapBenefitPayWidget variable + Listening to callbacks**
```dart import 'dart:developer' as developer;    
 import 'package:benefit_pay_flutter/benefit_pay_flutter.dart'; import 'package:flutter/material.dart';    
 class BenefitPayScreen extends StatefulWidget {    
  final Map<String, dynamic> dictionaryMap;    
    
  const BenefitPayScreen({    
    super.key,    
    required this.dictionaryMap,    
  });    
    
  @override    
State<BenefitPayScreen> createState() => _BenefitPayScreenState(); }    
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
        padding: const EdgeInsets.only(bottom: 20),    
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
          onClick: () {    
    
          },    
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
} }   
```   

# Parameters Reference[](https://developers.tap.company/docs/benefit_pay_flutter#parameters-reference)

Below you will find more details about each parameter shared in the above tables that will help you easily integrate BenefitPay-Flutter SDK.

## operator[](https://developers.tap.company/docs/benefit_pay_flutter#operator)

1. Definition: It links the payment gateway to your merchant account with Tap, in order to know your business name, logo, etc...
2. Type: string (_required_)
3. Fields:
    - **publicKey**      
      _Definition_: This is a unique public key that you will receive after creating an account with Tap which is considered a reference to identify you as a merchant. You will receive 2 public keys, one for sandbox/testing and another one for production.
4. Example:

```dart { "operator":{"publicKey":"pk_test_YhUjg9PNT8oDlKJ1aE2fMRz7", "hashString":""}   
```   

## transaction [](https://developers.tap.company/docs/benefit_pay_flutter#transaction)

1. Definition: This defined the details of the order that you are trying to purchase, in which you need to specify some details like the reference, scope...
2. Type: Dictionary, (optional)
3. Fields:
    - **currency**      
      _Definition:_ The currency which is linked to the order being paid.
    - **amount**      
      _Definition:_ The order amount to be paid by the customer.      
      Note: Minimum amount to be added is 0.1.
4. _Example:_
 ```dart    
 "transaction": {    
  "amount": 1.0,    
"currency": "BHD", }   
```   


## customer [](https://developers.tap.company/docs/benefit_pay_flutter#customer)

1. Definition: Here, you will collect the information of the customer that is paying..

2. Type: Dictionary (_required_)

3. Fields:

    - **id**      
      _Definition:_ This is an optional field that you do not have before the charge is processed. But, after the charge, then you will receive the customer ID in the response which can be handled in the onSuccess callback function.
    - **name**      
      _Definition:_ Full Name of the customer paying.      
      _Fields:_

1. **lang**      
   Definition: Language chosen to write the customer name.  
   2. **first**      
   Definition: Customer's first name.  
   3. **middle**      
   Definition: Customer's middle name.  
   4. **last**      
   Definition: Customer's last name.
    - **contact**      
      _Definition:_ The customer's contact information like email address and phone number.      
      Note: The contact information has to either have the email address or the phone details of the customers or both but it should not be empty.      
      _Fields:_

1. **email**      
   Definition: Customer's email address      
   Note: The email is of type string.  
   2. **phone**      
   Definition: Customer's Phone number details  
   1. **countryCode**
2. **number**
4. _Example:_
```dart { "customer": {    
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
 }  
```   

## interface [](https://developers.tap.company/docs/benefit_pay_flutters#interface)

1. Definition: This will help you control the layout (UI) of the payment form, like changing the theme light to dark, the language used (en or ar), ...
2. Type: Dictionary (_optional_)
3. Fields:
    - **locale**      
      _Definition:_ The language of the pay button. Accepted values as of now are:      
      _Possible Values:_

1. **en**(for english)
2. **ar**(for arabic).

- **edges**      
  _Definition:_ Control the edges of the payment form.      
  _Possible Values:_

1. **curved**
2. **flat**

4. _Example:_
```dart {  
 "interface":  {  "locale": "en",    
  "edges": "flat",    
 }  
```   

## post [](https://developers.tap.company/docs/benefit_pay_flutter#post)

1. Definition: Here you can pass the webhook URL you have, in order to receive notifications of the results of each Transaction happening on your application.

2. Type: Dictionary (_optional_)

3. Fields:

    - **url**      
      _Definition:_ The webhook server's URL that you want to receive notifications on.      
      _Example:_
```dart { "post":{"url":""}   
```   

# Generate the hash string[](https://developers.tap.company/docs/benefit_pay_flutter#generate-the-hash-string)

1. Add the dependency ``` crypto: Latest version```
2. Copy this helper method code
```dart /**    
 This is a helper method showing how can you generate a hash string when performing live charges - Parameter publicKey:             The Tap public key for you as a merchant pk_..... - Parameter secretKey:             The Tap secret key for you as a merchant sk_..... - Parameter amount:                The amount you are passing to the SDK, ot the amount you used in the order if you created the order before. - Parameter currency:              The currency code you are passing to the SDK, ot the currency code you used in the order if you created the order before. PS: It is the capital case of the 3 iso country code ex: SAR, KWD. - Parameter post:                  The post url you are passing to the SDK, ot the post url you pass within the Charge API. If you are not using postUrl please pass it as empty string - Parameter transactionReference:  The reference.trasnsaction you are passing to the SDK(not all SDKs supports this,) or the reference.trasnsaction  you pass within the Charge API. If you are not using reference.trasnsaction please pass it as empty string */   
  String generateTapHashString(         
        String publicKey,  
 String secretKey,        double amount,      
        String currency, {      
        String postUrl = "",      
        String transactionReference = "",      
     }) {      
       // Let us generate our encryption key      
       var key = utf8.encode(secretKey);      
       // For amounts, you will need to make sure they are formatted in a way to have     the correct number of decimal points. For BHD we need them to have 3 decimal points      
       var formattedAmount = amount.toStringAsFixed(3);      
       // Let us format the string that we will hash      
       var toBeHashed = 'x_publickey$publicKey'      
       'x_amount$formattedAmount'      
       'x_currency$currency'      
       'x_transaction$transactionReference'      
       'x_post$postUrl';      
       // let us generate the hash string now using the HMAC SHA256 algorithm      
       var hmacSha256 = Hmac(sha256, key);      
       var signature = hmacSha256.convert(utf8.encode(toBeHashed));      
       var hashedString = signature.toString();      
       return hashedString;      
}   
``` 4. Call it as follows:  
```dart String hashString = generateTapHashString(publicKey: publicKey, secretKey: secretString, amount: amount, currency: currency, postUrl: postUrl);   
``` 5. Pass it within the operator model  
```dart { "operator": {"publicKey": "pk_test_HJN863LmO15EtDgo9cqK7sjS", "hashString": hashString } }   
```