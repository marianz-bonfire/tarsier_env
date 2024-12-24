import 'common/env.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Env.init();
  await Env.init();
  await Env.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Using Ma<String,String> such Env.vars[\'key\']'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text('APP_KEY:'), Text('')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text('APP_KEY:'), Text('')],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

