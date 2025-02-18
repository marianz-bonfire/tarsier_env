import 'common/environment/env.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.init();

  String? appName = Env.appName; // You can use the generated static getter
  String? appKey =
      Env.vars['APP_KEY']; // Or you can use the key in the Map<String,String>
  String appUrl = Env.get('APP_URL',
      'http://localhost'); // Or you can use the get function with default fallback

  // You can call also use "get" function with fallback value
  int dbPort = Env.get<int>('DB_PORT', 3306);
  bool appDebug = Env.get<bool>('APP_DEBUG', true);
  double threshold = Env.get<double>('THRESHOLD', 3.1416);

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
    final envVars = Env.vars.entries.toList(); // Convert map to list

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            color: Colors.amber,
            padding: const EdgeInsets.all(12.0),
            child: const Text(
              'This is a demo on how to get the value from .env file.',
              textAlign: TextAlign.center,
            ),
          ),
// Centered Container with Text
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: const Text(
              "Environment Variables",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

// ListView inside Expanded
          Expanded(
            child: ListView.builder(
              itemCount: envVars.length,
              itemBuilder: (context, index) {
                final key = envVars[index].key;
                final value = envVars[index].value;

                return ListTile(
                  title: Text(
                    key,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
//subtitle: Text(value),
                  dense: true,
                  trailing: Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                  ),
                  leading: const Icon(Icons.settings),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
