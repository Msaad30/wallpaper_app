import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/data/remote/api_helper.dart';
import 'package:wallpaper_app/data/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/screens/home/cubit/home_cubit.dart';
import 'package:wallpaper_app/screens/home/home_screen.dart';
import 'package:wallpaper_app/screens/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/screens/search/searched_wallpaper_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
          create: (context) => HomeCubit(
              wallPaperRepository: WallPaperRepository(apiHelper: ApiHelper())
            ),
          ),
          BlocProvider(
            create: (context) => SearchCubit(
                wallPaperRepository: WallPaperRepository(
                    apiHelper: ApiHelper()
                )
            ),
          ),
        ],
        child: HomePage(),
        )
    );
  }
}

