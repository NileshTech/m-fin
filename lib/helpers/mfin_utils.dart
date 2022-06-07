import 'package:finance/common/index.dart';
import 'package:finance/env/user_app_env.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MFinUtils {
  static DatabaseReference userRef = FirebaseDatabase.instance.ref();

  static Future<void> updateAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      UserEnvirnment.appVersion = packageInfo.version;
    } catch (e) {
      print("== issue in updateing app version: $e ");
    }
  }

  static Future<bool> userUserInfoInDB(userObject) async {
    await userRef.ref.child('profiles/${userObject.uid}').update({
      "user-info": {
        "email": userObject.email,
        "user-id": userObject.uid,
        "last-update-datetime": DateTime.now().millisecondsSinceEpoch,
        "profile-puc-url": userObject.photoURL,
      },
      "device-info": {"app-version": UserEnvirnment.appVersion},
    });

    return true;
  }

  static Future<void> checkForAdFreeInterest(userId) async {
    // === updating profile === //
    await userRef.ref
        .child('profiles/$userId')
        .child("activity/interested-in-ad-free")
        .once()
        .then((value) => {
              if (value.snapshot.exists)
                UserEnvirnment.interestForAdsUpdated = true
              else
                UserEnvirnment.interestForAdsUpdated = false
            });
  }

  static Future<void> updateAdFreeInterest(userId, userInput) async {
    await userRef.ref.child('profiles/$userId').update({
      "activity": {"interested-in-ad-free": userInput}
    });

    // == updating inventory stats === //
    await userRef.ref
        .child('inventory/ad-free-interested')
        .update({"user-id": userId});
  }
}
