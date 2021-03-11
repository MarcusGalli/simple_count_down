import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';

import 'package:timer_count_down/timer_count_down.dart';

void main() => runApp(MyApp());

///
/// Test app
///
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Countdown',
      ),
    );
  }
}

///
/// Home page
///
class MyHomePage extends StatefulWidget {
  ///
  /// AppBar title
  ///
  final String title;

  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

///
/// Page state
///
class _MyHomePageState extends State<MyHomePage> {
  final CountdownController _controller = CountdownController();

  bool _isPause = true;
  bool _isRestart = false;

  @override
  Widget build(BuildContext context) {
    final IconData buttonIcon = _isRestart
        ? Icons.refresh
        : (_isPause ? Icons.pause : Icons.play_arrow);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Countdown(
              controller: _controller,
              seconds: 5,
              build: (_, double time) => Text(
                time.toString(),
                style: TextStyle(
                  fontSize: 100,
                ),
              ),
              interval: Duration(milliseconds: 100),
              onFinished: () {
                print('Timer is done!');

                setState(() {
                  _isRestart = true;
                });
              },
            ),
            RaisedButton(
              child: Text('Set new Value'),
              onPressed: () {
                print('show Dialog');
                Scaffold.of(context).showBottomSheet(
                  (BuildContext context) {
                    return Container(
                      height: 300,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            const Text('Enter new timer value'),
                            ElevatedButton(
                              child: Text('Apply'),
                              onPressed: () {
                                print('New Button');
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(buttonIcon),
        onPressed: () {
          final isCompleted = _controller.isCompleted;
          isCompleted ? _controller.restart() : _controller.pause();

          if (!isCompleted && !_isPause) {
            _controller.resume();
          }

          if (isCompleted) {
            setState(() {
              _isRestart = false;
            });
          } else {
            setState(() {
              _isPause = !_isPause;
            });
          }
        },
      ),
    );
  }
}
