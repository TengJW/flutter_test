import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/ColorsUtil.dart';
import 'package:flutter_app/util/utils.dart';
import 'dart:async';

import 'RandomWords.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  var num = 10;
  Timer timer;
  final period = const Duration(seconds: 1);
  var isAlived = false;
  int _state = 0;

  @override
  void initState() {
    super.initState();
    if (_state == 1)
      timer = Timer.periodic(period, (timer) {
        setState(() {
          num--;
          if (num <= 0) {
            timer.cancel();
            _goHome();
          }
        });
      });
    var isFirst = SpUtil.getBool("isFirst");
    if (!isFirst) {
      setState(() {
        _state = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: _state == 0,
            child: new Container(
              child: InkWell(
                child: new Container(
                  child: new Image.asset(
                    Utils.getImgPath('logo'),
                  ),
                ),
                onTap: () {
                  SpUtil.putBool('isFirst', true);
                  _goHome();
                },
              ),
              alignment: Alignment.center,
              color: Colors.white,
            ),
          ),
          new Offstage(
            offstage: _state == 1,
            child: _getSplash(),
          ),
        ],
      ),
    );
  }

  Widget _getSplash() {
    return new Stack(
      children: <Widget>[
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: new Image.network(
              'http://n.sinaimg.cn/sports/2_img/upload/cf0d0fdd/107/w1024h683/20181128/pKtl-hphsupx4744393.jpg',
              fit: BoxFit.fitHeight,
            )),
        Positioned(
            right: 15,
            top: 25,
            child: new Container(
              alignment: AlignmentDirectional.center,
              child: new RaisedButton(
                onPressed: () {
                  setState(() {
                    _goHome();
                  });
                },
                color: ColorsUtil.hexColor(0x989B98, alpha: 0.85),
                child: new Text(
                  "跳过$num",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 13,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal),
                ),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5)),
            ))
      ],
    );
  }

  void _goHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => RandomWords()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }
}
