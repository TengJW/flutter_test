import 'package:flukit/flukit.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloC/bloc_provider.dart';
import 'package:flutter_app/bloC/main_bloc.dart';
import 'package:flutter_app/common/widgets.dart';
import 'package:flutter_app/model/banner_modul_entity.dart';
import 'package:flutter_app/model/moduls.dart';
import 'package:flutter_app/model/repos_model.dart';
import 'package:flutter_app/util/ColorsUtil.dart';
import 'package:rxdart/rxdart.dart';

import '../ReposItem.dart';
import '../webview.dart';

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

    return ListView(
      children: <Widget>[
        new StreamBuilder(
          stream: bloc.bannerStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<BannerModulData>> snapshot) {
            return buildBanner(context, snapshot.data);
          },
        ),
        _getHead(),
        new StreamBuilder(
          stream: bloc.reposStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<ReposDataData>> snapshot) {
            return _getRepos(context, snapshot.data);
          },
        ),
      ],
      controller: ScrollController(),
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

              Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                return new MyWebView(
                  model.url,
                  title: model.title,
                );
              }));
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

  Widget _getHead() {
    return new ListTile(
      onTap: () {},
      title: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.library_books,
            color: Colors.blue,
            size: 18,
          ),
          Padding(
            child: new Text(
              '推荐文章',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontStyle: FontStyle.normal),
            ),
            padding: EdgeInsets.only(left: 10),
          )
        ],
      ),
      trailing: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            '更多',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          Icon(
            Icons.chevron_right,
            size: 17,
          )
        ],
      ),
    );
  }

  Widget _getRepos(BuildContext context, List<ReposDataData> list) {
    if (list == null || list.length == 0) {
      return new Container(height: 0.0);
    }
    List<Widget> children = list.map((model) {
      return new ReposItem(model, isHome: true);
    }).toList();

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
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
