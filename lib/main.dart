import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: IncrementNumber());
  }
}

class IncrementNumber extends StatefulWidget {
  const IncrementNumber({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IncrementNumberState createState() => _IncrementNumberState();
}

class _IncrementNumberState extends State<IncrementNumber> {
  int _count = 0;
  double _width = 1;
  late Timer _timer;

  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          if (_width == MediaQuery.of(context).size.width) {
            _count = 0;
            _width = 0;
          } else {
            _count++;
            _width = _count * 10;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // cancel the timer to prevent memory leaks
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // print(_width);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Increment Number'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_count',
              style: const TextStyle(fontSize: 24),
            ),
            Stack(
              children: [
                Container(
                  color: Colors.grey.shade300,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 70),
                    height: 70,
                    width: 70,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPaused = !_isPaused;
                          });
                        },
                        icon: Icon(
                          _isPaused ? Icons.play_arrow : Icons.pause,
                          size: 50,
                        )),
                  ),
                )
              ],
            ),
            Container(
              color: _isPaused ? Colors.white : Colors.red,
              height: 10,
              width: _width,
            ),
          ],
        ),
      ),
    );
  }
}
