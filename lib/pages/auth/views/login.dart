import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:test_intesco/commons/asset_manager.dart';
import 'package:test_intesco/commons/l10n/generated/l10n.dart';
import 'package:test_intesco/pages/auth/bloc/auth_bloc.dart';
import 'package:test_intesco/pages/home/views/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Provider.of<AuthBloc>(context, listen: false);
    _bloc.accountStream.listen((event) {
      if (event != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
      }
    });
  }

  @override
  void dispose() {
    // _bloc.dispose();
    super.dispose();
  }

  Widget _buildButtonGoogle() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
      ),
      onPressed: _loginWithGoogle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AssetManager.icGoogle),
          SizedBox(width: 24.w,),
          Text(
            S.of(context).login_with_google,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loginWithGoogle() async {
    final res = await _bloc.loginWithGoogle();    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<bool>(
          stream: _bloc.isLoggingInStream,
          builder: (context, snapshot) {
            final isInitializing = snapshot.data ?? true;
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AssetManager.icGooglePhoto,
                    width: 200.r,
                    height: 200.r,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 120.h,),
                  Container(
                    height: 60.h,
                    child: Center(
                      child: isInitializing
                          ? CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,)
                          : _buildButtonGoogle(),
                    ),
                  ),
                  SizedBox(height: 100.h,),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}