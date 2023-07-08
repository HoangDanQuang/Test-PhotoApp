import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_intesco/commons/l10n/generated/l10n.dart';
import 'package:test_intesco/commons/themes/custom_theme.dart';
import 'package:test_intesco/pages/auth/bloc/auth_bloc.dart';
import 'package:test_intesco/pages/auth/views/login.dart';
import 'package:provider/provider.dart';
import 'package:test_intesco/pages/home/views/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBloc>(create: (_) => AuthBloc()),
      ],
      builder: (context, child) {
        AuthBloc _authBloc = Provider.of<AuthBloc>(context, listen: false);
        if (!_authBloc.isInitialzed) _authBloc.init();
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          builder: (context , child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Photo App',
              theme: CustomTheme.light,
              darkTheme: CustomTheme.dark,
              // TODO add userconfig
              themeMode: ThemeMode.system,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              home: child,
            );
          },
          child: const LoginPage(),
        );
      },
    );
  }
}