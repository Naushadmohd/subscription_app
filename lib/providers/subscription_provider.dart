// import 'package:flutter/material.dart';

// class SubscriptionProvider with ChangeNotifier {
//   String _amount = '';
//   bool _isLoading = false;

//   String get amount => _amount;
//   bool get isLoading => _isLoading;

//   void setAmount(String value) {
//     _amount = value;
//     notifyListeners();
//   }

//   bool validateAmount(BuildContext context) {
//     if (_amount.isEmpty ||
//         double.tryParse(_amount) == null ||
//         double.parse(_amount) <= 0) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Please enter a valid amount')));
//       return false;
//     }
//     return true;
//   }
// }

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionProvider with ChangeNotifier {
  late Razorpay _razorpay;
  String _amount = '';

  String get amount => _amount;

  void setAmount(String value) {
    _amount = value;
    notifyListeners();
  }

  void initRazorpay(BuildContext context) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Successful: ${response.paymentId}")),
      );
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Failed: ${response.message}")),
      );
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Wallet Selected: ${response.walletName}")),
      );
    });
  }

  void openCheckout(BuildContext context) {
    final doubleAmount = double.tryParse(_amount);
    if (doubleAmount == null || doubleAmount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter a valid amount')));
      return;
    }

    var options = {
      'key': 'rzp_test_ne8WGPosJBjDuM',
      'amount': (doubleAmount * 100).toInt(),
      'name': 'Premium Subscription',
      'description': 'Subscribe to Premium',
      'prefill': {'contact': '9644435960', 'email': 'naushadmohd74@gmil.com'},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Razorpay error: $e');
    }
  }

  void disposeRazorpay() {
    _razorpay.clear();
  }
}
