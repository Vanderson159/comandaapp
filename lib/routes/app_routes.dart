import 'package:flutter/material.dart';

abstract class Routes{
  static const INITIAL = '/';
  static const INITIAL2 = '/initial2';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const FORGOT = '/forgot';
  static const LISTMESAS = '/listMesas';
  static const DETAILS = '/details';
  static const DELETEMESAS = '/deleteMesas';
  static const ADDMESAS = '/addMesas';
  static const MESAITEM = '/mesaItem';
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}