import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

pushNav<T>(Widget screen) => navKey.currentState!.push(MaterialPageRoute(
    builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: screen,
        )));

Future<T> pushRepNav<T>(Widget screen) async => await navKey.currentState!
    .pushReplacement(MaterialPageRoute(builder: (_) => screen));

void popNav({dynamic data}) => navKey.currentState!.pop(data);

Future<T> pushAndRemoveUntil<T>(Widget screen, String name) async =>
    await navKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
        ModalRoute.withName(name));
