import 'dart:io';

class Note {
  String? text;
  File? image;
  bool isImportant;

  Note({this.text, this.image, this.isImportant = false});
}