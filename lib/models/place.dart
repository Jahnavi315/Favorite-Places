import 'package:uuid/uuid.dart';
import 'dart:io';

var uuid = const Uuid();

class Place{
  
  Place({required this.title,required this.image}):id = uuid.v4();
  
  String id;
  String title;
  File image;
}