import 'package:flukit/flukit.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloC/bloc_provider.dart';
import 'package:flutter_app/bloC/main_bloc.dart';
import 'package:flutter_app/common/widgets.dart';
import 'package:flutter_app/model/banner_modul_entity.dart';
import 'package:flutter_app/model/moduls.dart';
import 'package:rxdart/rxdart.dart';

bool isHomeInit = true;
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final MainBloC bloc = BlocProvider.of<MainBloC>(context);
    bloc.bannerStream.listen((list) {});
    if (isHomeInit) {
      LogUtil.e("HomePage init......");
      isHomeInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.onRefresh(labelId: '');
      });
    }

    return new StreamBuilder(
      stream: bloc.bannerStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<BannerModulData>> snapshot) {
        return new ListView(
          children: <Widget>[
            buildBanner(context, snapshot.data),
          ],
        );
      },
    );
  }

  Widget buildBanner(BuildContext context, List<BannerModulData> list) {
    if (ObjectUtil.isEmpty(list)) {
      return new Container(height: 0.0);
    }
    return new AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Swiper(
        indicatorAlignment: AlignmentDirectional.topEnd,
        circular: true,
        interval: const Duration(seconds: 5),
        indicator: NumberSwiperIndicator(),
        children: list.map((model) {
          return new InkWell(
            onTap: () {
//              LogUtil.e("BannerModel: " + model.toString());
//              NavigatorUtil.pushWeb(context,
//                  title: model.title, url: model.url);
            },
            child: new Image.network(
              "${model.imagePath}",
              fit: BoxFit.fill,
            ),
//            child: new Image.network(
//              fit: BoxFit.fill,
//              loadingBuilder: (context, url) => new ProgressView(),
//              imageUrl: model.imagePath,
//
//              placeholder: (context, url) => new ProgressView(),
//              errorWidget: (context, url, error) => new Icon(Icons.error),
//            ),
          );
        }).toList(),
      ),
    );
  }
}

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.only(top: 10.0, right: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text("${++index}/$itemCount",
          style: TextStyle(color: Colors.white70, fontSize: 11.0)),
    );
  }
}
