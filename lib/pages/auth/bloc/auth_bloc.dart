import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_intesco/commons/base_bloc.dart';
import 'package:test_intesco/commons/services/shared_preference_helper.dart';
import 'package:test_intesco/commons/utils/social_utils.dart';

class AuthBloc extends BaseBloc {
  late BehaviorSubject<bool> _isLoggingInSubject;
  late BehaviorSubject<SocialAccount?> _accountSubject;

  Stream<bool> get isLoggingInStream => _isLoggingInSubject.stream;
  Stream<SocialAccount?> get accountStream => _accountSubject.stream;
  
  SocialAccount? get user => _accountSubject.value;

  @override
  Future<void> init() async {
    super.init();
    _isLoggingInSubject = BehaviorSubject.seeded(true);
    _accountSubject = BehaviorSubject.seeded(null);
    SharedPreferenceHelper _sharedPreference =
        SharedPreferenceHelper(await SharedPreferences.getInstance());
    SocialUtils.loginGoogleSilently().then((user) async {
      if (user == null) {
        _isLoggingInSubject.add(false);
        return;
      }
      _accountSubject.add(user);
      String accessToken = await user.accessToken ?? '';
      print('@@ accessToken: $accessToken');
      await _sharedPreference.saveAuthToken(accessToken);
      _isLoggingInSubject.add(false);
    });
    
  }

  @override
  void dispose() {
    _accountSubject.close();
    super.dispose();
  }

  Future<bool> loginWithGoogle() async {
    try {
      // await SocialUtils.logout();
      final user = await SocialUtils.loginWithGoogle();
      if (user == null) return false;
      String accessToken = await user.accessToken ?? 'null';
      print('@@ accessToken: $accessToken');
      SharedPreferenceHelper _sharedPreference =
        SharedPreferenceHelper(await SharedPreferences.getInstance());
      await _sharedPreference.saveAuthToken(accessToken);
      _accountSubject.add(user);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }


  Future<bool> logout() async {
    try {
      await SocialUtils.logout();
      SharedPreferenceHelper _sharedPreference =
        SharedPreferenceHelper(await SharedPreferences.getInstance());
      await _sharedPreference.removeAuthToken();
      _accountSubject.add(null);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }


  




}