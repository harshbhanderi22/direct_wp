import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
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
        "whatsapp://send?phone=${contactController.text}&text=${Uri.encodeComponent(messageController.text)}";
    var encoded = Uri.encodeFull(url);
    if (await canLaunchUrl(Uri.parse(encoded))) {
      await launchUrl(Uri.parse(encoded)).then((value) {
        addItemsToDocument(["+${contactController.text}"]);
      });
      setLoading(false);
    } else {
      setLoading(false);
      // Fluttertoast.showToast(
      //     msg: "Something Went Wrong\nTry Adding Country Code");
      //print("Error");
    }
  }

  void addItemsToDocument(List<dynamic> items) {
    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Define the collection and document reference
    CollectionReference collectionReference = firestore.collection('contacts');
    DocumentReference documentReference =
        collectionReference.doc('tezNVrVMavmpAD4iWuDC');

    // Update the document by adding items to the existing list
    documentReference.update({
      'contact_number': FieldValue.arrayUnion(items),
    }).then((value) {
      //print('Items added to the document successfully!');
    }).catchError((error) {
      //print('Failed to add items to the document: $error');
    });
  }
  
  


}
