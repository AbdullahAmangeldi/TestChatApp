import 'dart:ui';

import 'message.dart';

class User{
  User( {required this.name, required this.color, required this.messenges});
  String name;
  Color color;
  List<Message> messenges;

}