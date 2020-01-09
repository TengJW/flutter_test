import 'dart:io';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';

import 'RandomWords.dart';
import 'package:flustars/flustars.dart';

import 'SplashPage.dart';
import 'bloC/ApplicationBloc.dart';
import 'bloC/bloc_provider.dart';
import 'bloC/main_bloc.dart';
import 'package:dio/dio.dart';

void main() => init(() {
      runApp(BlocProvider<ApplicationBloc>(
        bloc: ApplicationBloc(),
        child: BlocProvider(
          child: MyApp(),
          bloc: MainBloC(),
        ),
      ));
    });

Future init(VoidCallback covariant) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  covariant();

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}


class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(primaryColor: Colors.white),
      home: new SplashPage(),
    );
  }

  @override
  void initState() {
    super.initState();
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((value) {
      setState(() {
        //修改APP有关的东西  比如主题色  系统文字
      });
    });
  }
}
