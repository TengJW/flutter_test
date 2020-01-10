import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/model/banner_modul_entity.dart';
import 'package:flutter_app/model/moduls.dart';

import 'commonStr.dart';

class Repository {
  Dio _dio = new Dio();

  Future<List<BannerModulData>> getBanner() async {
    Response response = await _dio.get(Constants.banner);
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        var jsonStr1 = response.data.toString();
        if (response.data is Map) {}
        var jsonMap1 = json.decode(jsonStr1);
        var jsonStr =
            '{"data":[{"desc":"享学~","id":29,"imagePath":"https://www.wanandroid.com/blogimgs/0b02cf7c-1c1f-4101-b4eb-087f832ad5b1.png","isVisible":1,"order":0,"title":"1个月，彻底修改app架构！","type":0,"url":"https://mp.weixin.qq.com/s/MXxOTc-0Z_e0nuHF23hGfw"},{"desc":"","id":6,"imagePath":"https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png","isVisible":1,"order":1,"title":"我们新增了一个常用导航Tab~","type":1,"url":"https://www.wanandroid.com/navi"},{"desc":"一起来做个App吧","id":10,"imagePath":"https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png","isVisible":1,"order":1,"title":"一起来做个App吧","type":1,"url":"https://www.wanandroid.com/blog/show/2"},{"desc":"","id":20,"imagePath":"https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png","isVisible":1,"order":2,"title":"flutter 中文社区 ","type":1,"url":"https://flutter.cn/"}],"errorCode":0,"errorMsg":""}';
        var jsonMap = jsonDecode(jsonStr);

        List<BannerModulData> list =
            new BannerModulEntity.fromJson(jsonMap).data;

        return list;
      } catch (e) {
        print(e);
      }
    }
  }
}
