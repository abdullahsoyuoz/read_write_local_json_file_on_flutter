import 'package:flutter/material.dart';
import 'jsonHelper.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: App()));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  TextEditingController controllerKey = TextEditingController();
  TextEditingController controllerValue = TextEditingController();
  JsonHelper jsonman;
  Map<String, dynamic> content;

  void guncelle() {
    setState(() {
      content = jsonman.read();
    });
  }

  @override
  void initState() {
    super.initState();
    jsonman = JsonHelper("test"); // json file name => .../test.json
    jsonman.initialize();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        guncelle();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Json R&W App"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TEXT FIELDS
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controllerKey,
                    decoration: InputDecoration(
                        hintText: "Key",
                        hintStyle:
                            TextStyle(color: Color.fromARGB(30, 0, 0, 0))),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controllerValue,
                    decoration: InputDecoration(
                        hintText: "Value",
                        hintStyle:
                            TextStyle(color: Color.fromARGB(30, 0, 0, 0))),
                  ),
                ),
              ],
            ),
            // CRUD BUTTONS
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FlatButton(
                      onPressed: () {
                        jsonman.create(
                            controllerKey.text, controllerValue.text);
                        guncelle();
                      },
                      child: Text("CREATE"),
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FlatButton(
                      onPressed: () {
                        jsonman.update(
                            controllerKey.text, controllerValue.text);
                        guncelle();
                      },
                      child: Text("UPDATE"),
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FlatButton(
                      onPressed: () {
                        jsonman.delete(controllerKey.text);
                        guncelle();
                      },
                      child: Text("DELETE"),
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
            // LISTVIEW
            Expanded(
              child: ListView.builder(
                itemCount: content.length,
                itemBuilder: (context, index) {
                  if (content.isEmpty) {
                    return Text("veri yok");
                  } else {
                    String key = content.keys.elementAt(index);
                    String value = content.values.elementAt(index);
                    return ListTile(
                      title: Text(key),
                      subtitle: Text(value),
                      onTap: () {
                        setState(() {
                          controllerKey.text = key;
                          controllerValue.text = value;
                        });
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
