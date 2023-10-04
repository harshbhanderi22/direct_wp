import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMob {
  late String openAdUnitId;
  late String bannerAdUnitId =
      ""; // Make it static to avoid multiple instances of the class having different values
  late AppOpenAd openAd;
  late String rewardAdId = "";

  Future<void> loadAdUnitIds() async {
    FirebaseFirestore store = FirebaseFirestore.instance;
    try {
      var snapshot =
          await store.collection("ads").doc("p5XI1a0RarmmsgOr9HNm").get();
      var data = snapshot.data() as Map<String, dynamic>;
      print(data.toString());
      openAdUnitId = data["open"];
      bannerAdUnitId = data[
          "banner"]; // Assuming you have a banner ad unit ID in your Firebase data
      rewardAdId = data["reward"];
    } catch (e) {
      // Handle errors, e.g., data not found in Firestore
      print("Error loading ad unit IDs: $e");
    }
  }

  Future<void> loadOpenAd() async {
    if (openAdUnitId.isNotEmpty) {
      await AppOpenAd.load(
        adUnitId: openAdUnitId,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            print("Open Ad Loaded");
            openAd = ad;
            openAd.show();
          },
          onAdFailedToLoad: (ad) {
            print("Open ad failed");
          },
        ),
        orientation: AppOpenAd.orientationPortrait,
      );
    }
  }

 static RewardedAd? rewardedAd;

  void createRewardAd() {
    RewardedAd.load(
        adUnitId: rewardAdId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) {
              rewardedAd = ad;
            },
            onAdFailedToLoad: (error) {}));
  }

  void showRewardAd(Function onSuccess) {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createRewardAd();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        createRewardAd();
      }, onAdWillDismissFullScreenContent: (ad) {
        ad.dispose();
        createRewardAd();
      });
      rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        onSuccess();
      });
    } else {
      print("null");
    }
  }
}
