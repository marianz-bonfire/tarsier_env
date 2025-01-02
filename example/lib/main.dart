import 'common/environment/env.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Env.init(); // Initialize environment variables

  String? appName = Env.appName; // You can use the generated static getter
  String? appKey =
      Env.vars['APP_KEY']; // Or you can use the key in the Map<String,String>

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Env.appName ?? 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: Env.vars['APP_NAME'] ?? 'Flutter App',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              color: Colors.amber,
              padding: const EdgeInsets.all(12.0),
              child: const Text(
                  'This is a demo on how to get the value from .env file. Below value is the from APP_KEY'),
            ),
          ),
          Text(Env.appKey ?? '')
        ],
      ),
    );
  }
}
