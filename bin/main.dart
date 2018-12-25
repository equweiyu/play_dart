import 'dart:convert';
import 'dart:io';

import 'decodable.dart';

main() {
  final file = File('bin/mock_data.json').readAsStringSync();
  final jsondata = json.decode(file);
  final obj = LastContent.decode(jsondata);
  print(obj);
}

class Story extends Decodable {
  List<String> images;
  String image;
  String title;
  int id;

  Story.decode(data) : super.decode(data);
}

class LastContent extends Decodable {
  String date;
  List<Story> stories;
  Story top_storie;

  LastContent.decode(data) : super.decode(data);
}
