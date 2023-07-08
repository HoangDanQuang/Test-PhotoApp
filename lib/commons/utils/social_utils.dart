import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/photoslibrary/v1.dart';

class SocialAccount {

  SocialAccount({required this.googleUser});

  factory SocialAccount.google(GoogleSignInAccount user) =>
      SocialAccount(googleUser: user);

  final GoogleSignInAccount googleUser;

  String? _idToken;
  String? _accessToken;

  FutureOr<String?> get idToken async {
    if (_idToken == null) {
      _idToken = await googleUser.authentication.then((value) => value.idToken);
    }
    return _idToken;
  }
  FutureOr<String?> get accessToken async {
    if (_accessToken == null) {
      _accessToken = await googleUser.authentication.then((value) => value.accessToken);
    }
    return _accessToken;
  }

  String? get name {
    return googleUser.displayName;
  }

  String? get userId {
    return googleUser.id;
  }

  String? get email {
    return googleUser.email;
  }

  String? get avatar {
    return googleUser.photoUrl;
  }
  
}

class SocialUtils {
  SocialUtils._();

  static GoogleSignIn? _google;



  static Future<SocialAccount?> loginWithGoogle({
    List<String> scopes = const [],
  }) async {
    try {
      _google = GoogleSignIn(
        scopes: [
          ...scopes,
          PhotosLibraryApi.photoslibraryScope,
          // 'https://www.googleapis.com/auth/photoslibrary'
        ],
        // clientId: '522698183763-cjabk1655nu5gvnb3jmv6u6qaadu0s3d.apps.googleusercontent.com',
      );
      final account = await _google!.signIn();
      if (account != null) return SocialAccount.google(account);
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<SocialAccount?> loginGoogleSilently() async {
    try {
      final isSignedIn = await GoogleSignIn().isSignedIn();
      print('@@ isSignedIn: $isSignedIn');
      if (!isSignedIn) return null;
      final account = await GoogleSignIn().signInSilently();
      if (account != null) {
        print(account.displayName);
        print(account.email);
        return SocialAccount.google(account);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<void> logout() async {
    bool? isSignedIn = await GoogleSignIn().isSignedIn();
    if (isSignedIn == true) await GoogleSignIn().disconnect.call();
    _google = null;
    return;
  }
}
