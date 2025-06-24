import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp_lmhung/router/router.dart';
import 'package:todoapp_lmhung/screen/home_page/homepage_choosetheme.dart';
import 'package:todoapp_lmhung/screen/home_page/home_screen2.dart';
import 'package:todoapp_lmhung/router/router.dart';
import 'app_bloc/bloc.dart';

void main() {
  runApp(
          const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<App_Bloc>( create: (context) => App_Bloc(),),
      ],
      child: MaterialApp.router(
        routerConfig:AppRouter.router,
        // home: HomepageChoosetheme(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


