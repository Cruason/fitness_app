import 'package:flutter/cupertino.dart';

class Days{
  static const monday = "Понедельник";
  static const tuesday = "Вторник";
  static const wednesday = "Среда";
  static const thursday = "Четверг";
  static const friday = "Пятница";
  static const saturday = "Суббота";
  static const sunday = "Воскресенье";

}

class Pages{
  final String route;
  final String? iconPath;

  const Pages.route({required this.route, this.iconPath});

  static const homePage = Pages.route(route: '/', iconPath: 'assets/nav_icons/icon_home.png');
  static const planListPage = Pages.route(route: 'plan_list', iconPath: 'assets/nav_icons/icon_list.png');
  static const profilePage = Pages.route(route: 'profile', iconPath: 'assets/nav_icons/icon_profile.png');
  static const addPlanPage = Pages.route(route: 'add_plan_page');
  static const detailPlanPage = Pages.route(route: 'detail_plan_page', iconPath: "assets/nav_icons/icon_dumbbell.png");
  static const settingsPage = Pages.route(route: 'settings', iconPath: 'assets/nav_icons/icon_settings.png');

}

class CustomIcons{
  final String path;

  const CustomIcons.path({required this.path});

  static const emptyBox = CustomIcons.path(path: 'assets/icons/icon_empty_box.png');
  static const arrowRight = CustomIcons.path(path: 'assets/icons/icon_arrow_left.png');
  static const pageError = CustomIcons.path(path: 'assets/icons/icon_page_error.png');
  static const exerciseIcon = CustomIcons.path(path: 'assets/icons/icon_exercise.png');
  static const weightIcon = CustomIcons.path(path: 'assets/icons/icon_weight.png');
  static const restIcon = CustomIcons.path(path: 'assets/icons/icon_rest_time.png');
  static const repeatIcon = CustomIcons.path(path: 'assets/icons/icon_repeat.png');
  static const deleteIcon = CustomIcons.path(path: 'assets/icons/icon_delete.png');
  static const optionsIcon = CustomIcons.path(path: 'assets/icons/icon_options.png');
  static const duplicateIcon = CustomIcons.path(path: 'assets/icons/icon_duplicate.png');
}


class CustomColors{
  final Color color;

  const CustomColors.color({required this.color});

  static const green73D13D = CustomColors.color(color: Color(0XFF73D13D));
  static const orangeF08700 = CustomColors.color(color: Color(0xFFF08700));
  static const error = CustomColors.color(color: Color(0xFFE42C2C));
  static const lightGray = CustomColors.color(color: Color(0xFF979AA0));
  static const redFire = CustomColors.color(color: Color(0xFFCE1126));
}

class Options{
  static const delete = "удалить";
  static const edit = "изменить";
  static const share = "поделиться";
  static const report = "пожаловаться";
  static const add = "добавить";
}