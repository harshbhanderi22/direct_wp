import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:whatsapp_direct/firebase_options.dart';

class AdMob{

  AppOpenAd? openAd;
  Future<void> loadopenad() async{
    String openad = "";
    await Firebase.initializeApp(options: DefaultFirebaseOptions
        .currentPlatform,);
    FirebaseFirestore store = FirebaseFirestore.instance;
    var stream =
    await store.collection("ads").doc("p5XI1a0RarmmsgOr9HNm").get();
    Map<String, dynamic> data = stream.data() as Map<String, dynamic>;
    openad = data["open"];
    await AppOpenAd.load(
        adUnitId: openad,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded: (ad){
              //print("Open Ad Loaded");
              openAd = ad;
              openAd!.show();
            },
            onAdFailedToLoad: (ad){
              //print("Open ad failed");
            }),
        orientation: AppOpenAd.orientationPortrait);
  }

  BannerAd? bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      listener: BannerAdListener(
          onAdLoaded: (ad){
            print("Ad is loaded");
          },
          onAdFailedToLoad: (ad, error){
            ad.dispose();
            print(error);
          }
      ),
      request: const AdRequest()
  );
  
}