import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_direct/Provider/send_wp_provider.dart';
import 'package:whatsapp_direct/Services/ads.dart';
import 'package:whatsapp_direct/View/home_screen.dart';
import 'package:whatsapp_direct/firebase_options.dart';

void main() async {
  AdMob admob = AdMob();
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  admob.loadAdUnitIds().then((value) {
    admob.loadOpenAd();
    admob.createRewardAd();
  });
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WhatsAppProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
