import 'package:flutter_app/model/banner_modul_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "BannerModulEntity") {
      return BannerModulEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}