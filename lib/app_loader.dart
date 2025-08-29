import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies_db/core/theme/app_theme.dart';
import 'package:movies_db/routes/route_manager.dart';
import 'package:movies_db/service_locator.dart';
import 'package:oktoast/oktoast.dart';

class Apploader {
  void loadApp() async {
    await GetStorage.init();
    WidgetsFlutterBinding.ensureInitialized();
    setupServiceLocator();
    await getIt.allReady();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  late final AppRouter appRouter;

  @override
  void initState() {
    appRouter = AppRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: SafeArea(
        top: false,
        child: GestureDetector(
          onTap: () {
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
            FocusScope.of(context).requestFocus(FocusNode());
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp.router(
            routerConfig: appRouter.router,
            scaffoldMessengerKey: scaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            title: 'Candidate',
            theme: AppTheme.darkTheme,
            // routerDelegate: appRouter.router.routerDelegate,
            // routeInformationParser: appRouter.router.routeInformationParser,
            // routeInformationProvider: appRouter.router.routeInformationProvider,
          ),
        ),
      ),
    );
  }
}
