import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_direct/Provider/send_wp_provider.dart';
import 'package:whatsapp_direct/Services/ads.dart';
import 'package:whatsapp_direct/Utils/constant.dart';
import 'package:whatsapp_direct/Utils/Component/form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent.shade200,
          elevation: 5,
          title: const Text("Direct WP"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Welcome",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Enter WP Number & Message",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 40,
                ),
                Consumer<WhatsAppProvider>(builder: (context, value, child) {
                  return Column(
                    children: [
                      CommonField(
                        textInputType: TextInputType.phone,
                        controller: value.contactController,
                        hint: "91XXXXXXXXXX",
                        icon: Icons.phone,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonField(
                        controller: value.messageController,
                        hint: "Send Message If Want",
                        icon: Icons.chat,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          if (value.contactController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Contact number cannot be empty");
                          } else if (value.contactController.text.length < 12) {
                            Fluttertoast.showToast(
                                msg:
                                    "Please Enter Valid Number With Country Code Without + Icon");
                          } else {
                            AdMob().showRewardAd(() {
                              value.launchWp();
                            });
                            print("Clicked");
                          }
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.deepOrangeAccent.shade200),
                          child: Center(
                              child: value.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      "Send",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )),
                        ),
                      )
                    ],
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    "Instruction",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: const Text(
                      userGuidance,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: const Text(
                      "Note: Make sure whatsapp is installed in your device",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
