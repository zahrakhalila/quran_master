import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:quran_master/app_routes.dart';
import 'package:quran_master/cubits/bookmarks/cubit.dart';
import 'package:quran_master/cubits/chapter/cubit.dart';
import 'package:quran_master/cubits/juz/cubit.dart';
import 'package:quran_master/models/ayah/ayah.dart';
import 'package:quran_master/models/chapter/chapter.dart';
import 'package:quran_master/models/juz/juz.dart';
import 'package:quran_master/providers/app_provider.dart';
import 'package:quran_master/providers/onboarding_provider.dart';
import 'package:quran_master/screens/bookmarks/bookmarks_screen.dart';
import 'package:quran_master/screens/home/home_screen.dart';
import 'package:quran_master/screens/juz/juz_index_screen.dart';
import 'package:quran_master/screens/onboarding/onboarding.dart';
import 'package:quran_master/screens/share_app/share_app.dart';
import 'package:quran_master/screens/splash/splash.dart';
import 'package:quran_master/screens/surah/surah_index_screen.dart';

import 'configs/core_theme.dart' as theme;

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

// hive
  await Hive.initFlutter();

  Hive.registerAdapter<Juz>(JuzAdapter());
  Hive.registerAdapter<Ayah>(AyahAdapter());
  Hive.registerAdapter<Chapter>(ChapterAdapter());

  await Hive.openBox('app');
  await Hive.openBox('data');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => JuzCubit()),
        BlocProvider(create: (_) => ChapterCubit()),
        BlocProvider(create: (_) => BookmarkCubit()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: ((context, value, child) {
          return MaterialChild(
            value: value,
          );
        }),
      ),
    );
  }
}

class MaterialChild extends StatelessWidget {
  final AppProvider? value;
  const MaterialChild({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'They Holy Qur\'an',
      debugShowCheckedModeBanner: false,
      theme: theme.themeLight,
      darkTheme: theme.themeDark,
      themeMode: value!.themeMode,
      home: Builder(
        builder: (context) => HomeScreen(
          maxSlide: MediaQuery.of(context).size.width * 0.835,
        ),
      ),
      initialRoute: AppRoutes.splash,
      routes: <String, WidgetBuilder>{
        AppRoutes.juz: (context) => const JuzIndexScreen(),
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.surah: (context) => const SurahIndexScreen(),
        AppRoutes.shareApp: (context) => const ShareAppScreen(),
        AppRoutes.bookmarks: (context) => const BookmarksScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.home: (context) =>
            HomeScreen(maxSlide: MediaQuery.of(context).size.width * 0.835),
      },
    );
  }
}
