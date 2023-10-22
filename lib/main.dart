import 'package:app_version_update/app_version_update.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app_version_update_example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'app_version_update_example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    _verifyVersion();
  }

  void _verifyVersion() async {
    await AppVersionUpdate.checkForUpdates(
      appleId: '1459706595',
      playStoreId: 'com.byebnk.app',
    ).then((result) async {
      if (result.canUpdate!) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.grey.shade200,
              title: Column(
                children: <Widget>[
                  Icon(Icons.audio_file_outlined),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('New version is available!'),
                  ),
                ],
              ),
              content: Container(
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.amber,
                    width: 2.0,
                  ),
                ),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'A new version of the app is available! We have updated the deploy app to a new version (). Please update to the new version before continuing, this is mandatory.',
                  style: TextStyle(fontSize: 14, color: Colors.amber),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: Text(
                        "Download & Upgrade",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () async {
                        const url =
                            'https://play.google.com/store/apps/details?id=com.microsoft.outlooklite';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }
    });
    // TODO: implement initState
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
