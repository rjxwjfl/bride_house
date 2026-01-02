
import 'dart:io';

import 'package:bride_house/bloc/item_bloc.dart';
import 'package:bride_house/bloc/management_bloc.dart';
import 'package:bride_house/configs/calendar_control_config.dart';
import 'package:bride_house/configs/theme_config.dart';
import 'package:bride_house/repository/calendar_repository.dart';
import 'package:bride_house/repository/item_repository.dart';
import 'package:bride_house/repository/management_repository.dart';
import 'package:bride_house/src/app_home.dart';
import 'package:bride_house/util/formatter.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final ItemBloc itemBloc = ItemBloc(ItemRepository());
final ManagementBloc pmBloc = ManagementBloc(ManagementRepository());
final CalendarControlConfig calendarConfig = CalendarControlConfig(CalendarRepository());

Future<void> main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await calendarConfig.getHolidayData();
  await initializeDateFormatting(getLocaleName()).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness,
        systemNavigationBarColor: Theme.of(context).colorScheme.shadow,
        systemNavigationBarDividerColor: Theme.of(context).colorScheme.shadow,
        systemNavigationBarIconBrightness: Theme.of(context).brightness,
      ),
    );
    return CalendarControllerProvider(
      controller: calendarConfig.eventController,
      child: MaterialApp(
        theme: lightTheme,
        supportedLocales: const [
          Locale('ko', 'KR'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        scrollBehavior: ScrollGlowRemover(),
        debugShowCheckedModeBanner: false,
        title: '브라이드 하우스',
        home: AppHome(),
      ),
    );
  }
}

class ScrollGlowRemover extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}