import 'dart:collection';

import 'package:flutter_app/common/commonStr.dart';
import 'package:flutter_app/model/banner_modul_entity.dart';
import 'package:flutter_app/util/dio/dioUtil.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_provider.dart';

class MainBloC implements BlocBase {
  BehaviorSubject<List<BannerModulData>> _banner =
      BehaviorSubject<List<BannerModulData>>();

  Sink<List<BannerModulData>> get _bannerSink => _banner.sink;

  Stream<List<BannerModulData>> get bannerStream => _banner.stream;

  @override
  void dispose() {
    _banner.close();
  }

  @override
  Future getData({String labelId, int page}) {
    return getHomeData(labelId);
  }

  @override
  Future onLoadMore({String labelId}) {
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    return getData(labelId: labelId, page: 0);
  }

  Future getHomeData(String labelId) {
    return getBanner();
  }

  Future getBanner() {
    return DioManager().requestList<BannerModulData>(
        NWMethod.GET, Constants.banner, success: (data) {
      _bannerSink.add(UnmodifiableListView<BannerModulData>(data));
    }, error: (err) {
      print("error code = ${err.code}, massage = ${err.message}");
    });
  }
}
