import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class JsonHelper {
  String title = "test";
  File jsonFileDirectory;

  JsonHelper(this.title);

  void initialize() {
    getApplicationDocumentsDirectory().then((directory) {
      jsonFileDirectory = File(directory.path + "/" + title);
      if (jsonFileDirectory.existsSync()) {
      } else {
        jsonFileDirectory.createSync();
      }
    });
  }

  void create(String key, String value) {
    Map<String, dynamic> content = {key: value};
    if (!jsonFileDirectory.existsSync()) {
      initialize();
    }
    Map<String, dynamic> jsonFileContent =
        json.decode(jsonFileDirectory.readAsStringSync());
    jsonFileContent.addAll(content);
    jsonFileDirectory.writeAsStringSync(json.encode(jsonFileContent));
  }

  Map<String, dynamic> read() {
    var fileContent = json.decode(jsonFileDirectory.readAsStringSync());
    return fileContent;
  }

  void update(String key, String value) {
    Map<String, dynamic> jsonFileContent =
        json.decode(jsonFileDirectory.readAsStringSync());
    jsonFileContent[key] = value;
    jsonFileDirectory.writeAsStringSync(json.encode(jsonFileContent));
  }

  void delete(String key) {
    Map<String, dynamic> jsonFileContent =
        json.decode(jsonFileDirectory.readAsStringSync());
    jsonFileContent.remove(key);
    jsonFileDirectory.writeAsStringSync(json.encode(jsonFileContent));
  }
}
