import 'dart:convert';

import 'package:comical_music/model1/ResponseData.dart';
import 'package:comical_music/utils/net_utils1.dart';
import 'package:flutter/material.dart';
import 'package:comical_music/application.dart';
import 'package:comical_music/model1/User.dart';
import 'package:comical_music/utils/navigator_util.dart';
import 'package:comical_music/utils/net_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:comical_music/utils/utils.dart';

class UserModel with ChangeNotifier {
  User _user;

  String _token;

  User get user => _user;


  /// 初始化 User
  void initUser() {
    if (Application.sp.containsKey('user')) {
      String s = Application.sp.getString('user');
      _user = User.fromJson(json.decode(s));
    }
    if (Application.sp.containsKey('token')){
      String s = Application.sp.getString('token');
      _token=s;
    }
  }

  /// 登录
  Future<User> login(BuildContext context, String phone, String pwd) async {

    ResponseData responseData = await NetUtils1.login(context, phone, pwd);
    if (responseData.code != 200) {
      Utils.showToast(responseData.msg ?? '登录失败，请检查账号密码');
      return null;
    }
    Utils.showToast('登录成功');
    saveToken(responseData.data);
    User user = await NetUtils1.getUserInfo(context);
    _saveUserInfo(user);
    return user;
  }

  Future<User> fastLogin(BuildContext context, String phone, String code) async {

    ResponseData responseData = await NetUtils1.quickLogin(context, phone, code);
    if (responseData.code != 200) {
      Utils.showToast(responseData.msg ?? '登录失败，请检查账号密码');
      return null;
    }
    Utils.showToast('登录成功');
    saveToken(responseData.data);
    User user = await NetUtils1.getUserInfo(context);
    _saveUserInfo(user);
    return user;
  }

  /// 保存用户信息到 sp
  _saveUserInfo(User user) {
    _user = user;
    Application.sp.setString('user', json.encode(user.toJson()));
  }
  saveToken(String token) {
    _token = token;
    Application.sp.setString('token', token);
    NetUtils1.updateToken();
  }
}
