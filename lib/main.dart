import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double _radius = 100.0;
  bool _expand = true;
  static const int duration = 15000;

  @override
  void initState() {
    super.initState();
    createTicker((Duration elapsed) {
      setState(() {
        var fraction = (elapsed.inMilliseconds % duration) / duration;
        if (_expand) {
          _radius = 200 * fraction;
        } else {
          _radius = 200 * (1 - fraction);
        }
        if (_radius > 195) {
          _expand = false;
        }
        if (_radius < 5) {
          _expand = true;
        }
      });
    }).start();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CustomPaint(painter: MyPainter(_radius))
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  double radius;
  var _circlePaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 7.0
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
//    print(360 * radius / 200);
    _circlePaint.color =
        HSVColor.fromAHSV(1.0, 360 * radius / 200, 1.0, 1.0).toColor();
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), radius, _circlePaint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.radius != radius;
  }

  MyPainter(this.radius);
}
