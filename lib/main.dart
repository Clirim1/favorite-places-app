import 'package:favorite_places_app/auth/auth_repo.dart';
import 'package:favorite_places_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:favorite_places_app/bloc/favorite_places_block/favorite_places_bloc.dart';
import 'package:favorite_places_app/bloc/map_bloc/map_bloc.dart';
import 'package:favorite_places_app/navigation/app_navigation.dart';
import 'package:favorite_places_app/screens/auth_wraper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authRepo = AuthRepo();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepo: authRepo),
        ),
        BlocProvider<FavoritePlacesBloc>(
          create: (context) => FavoritePlacesBloc(),
        ),
        BlocProvider<MapBloc>(
          create: (context) => MapBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
