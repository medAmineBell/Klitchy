import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PaymentDialog extends StatefulWidget {
  final double amount;
  const PaymentDialog({
    super.key,
    required this.amount,
  });
  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  String? payment;

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> generatePayment() async {
    String payUrl = "";
    const url = 'https://developers.flouci.com/api/generate_payment';

    final Map<String, dynamic> body = {
      'app_token': 'c78b6f5d-36fb-4372-996c-1c70b3a22c26',
      'app_secret': '928215e8-76cc-43d6-93cb-65737cdefe2a',
      'amount': '30500',
      'accept_card': 'true',
      'session_timeout_secs': 1200,
      'success_link': 'https://example.website.com/success',
      'fail_link': 'https://example.website.com/fail',
      'developer_tracking_id': 'klitchy1app',
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print(url);
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      print('Response body: ${response.body}');
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      payUrl = extractedData["result"]["link"];
      _launchInWebViewOrVC(Uri.parse(payUrl));
    } else {
      // If the server returns an unsuccessful response code, throw an exception.
      throw Exception('Failed to create payment.');
    }
  }

  Future<void> payWithFlouci() async {
    String payUrl = "";
    final response = await http.post(
        Uri.parse("https://developers.flouci.com/api/generate_payment"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            "app_token": "c78b6f5d-36fb-4372-996c-1c70b3a22c26",
            "app_secret": "928215e8-76cc-43d6-93cb-65737cdefe2a",
            "accept_card": "true",
            "amount": "${widget.amount}",
            "success_link": "https://example.website.com/success",
            "fail_link": "https://example.website.com/fail",
            "session_timeout_secs": 1200,
            "developer_tracking_id": "klitchy1"
          },
        ));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      payUrl = extractedData["result"]["link"];
      _launchInWebViewOrVC(Uri.parse(payUrl));
    }

    //return payUrl;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: TextStyle(
          color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          child: Icon(
            Icons.close,
            size: 27,
            color: Colors.red,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      content: Container(
        height: 300,
        child: Column(
          // shrinkWrap: true,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Choose payment method",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            RadioListTile(
                title: Text("Cash"),
                value: "cash",
                groupValue: payment,
                onChanged: (String? val) {
                  setState(() {
                    payment = val;
                  });
                }),
            RadioListTile(
                title: Text("Credit Card"),
                value: "card",
                groupValue: payment,
                onChanged: (String? val) {
                  setState(() {
                    payment = val;
                  });
                }),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: InkWell(
                onTap: () async {
                  // await generatePayment();
                  // if (payment == "card") {
                  //   await payWithFlouci();
                  // }
                  Navigator.of(context).pop(payment);
                },
                child: Container(
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF006C81),
                  ),
                  child: Center(
                    child: Text(
                      "PAY",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
