import 'package:hive_flutter/adapters.dart';
import 'package:tasaktii/core/models/task_model.dart';

class AppLocalStorage {
  static late Box userbox;
  static late Box taskbox;

  static String kimage = "image";
  static String kname = "name";
  static String kisuplode = "isuplode";
  static String kisdarkmode = "isdarkmode";

  static init() {
    userbox = Hive.box('userbox');
    taskbox = Hive.box("taskbox");
  }

  static cacheData(String key, value) {
    userbox.put(key, value);
  }

  static getcachedata(String key) {
    return userbox.get(key);
  }

  static cacheTaskData(String key, TaskModel value) {
    taskbox.put(key, value);
  }

  static TaskModel? getcacheTaskdata(String key) {
    return taskbox.get(key);
  }
}
