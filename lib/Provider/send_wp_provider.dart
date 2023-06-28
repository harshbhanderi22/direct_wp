import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppProvider with ChangeNotifier {
  bool _loading = false;

  bool get isLoading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  TextEditingController contactController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  void launchWp() async {
    setLoading(true);

    String url =
        "https://wa.me/${contactController.text}?text=${messageController.text}";
var encoded = Uri.encodeFull(url);
    if (await canLaunchUrl(Uri.parse(encoded))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      setLoading(false);
    } else {
      setLoading(false);
      // Fluttertoast.showToast(
      //     msg: "Something Went Wrong\nTry Adding Country Code");
      print("Error");
    }
  }
}
