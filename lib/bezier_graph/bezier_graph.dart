import 'package:flutter/material.dart';
import 'package:material_route_demo/bezier_graph/bezier_painter.dart';
import 'package:material_route_demo/bezier_graph/slider_chart/paint_chart.dart';

class BezierGraphWidget extends StatefulWidget {
  BezierGraphWidget({
    Key? key,
  }) : super(key: key);

  @override
  BezierGraphWidgetState createState() => new BezierGraphWidgetState();
}

class BezierGraphWidgetState extends State<BezierGraphWidget> {
  double _dx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BezierGraphWidget'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
          ),
          GestureDetector(
            onTapUp: (TapUpDetails details) {
              print('Global dy ${details.globalPosition.dy}');
              print('Local dy ${details.localPosition.dy}');
            },
            child: SizedBox(
              height: 600,
              width: 400,
              child: CustomPaint(
                painter: BezierPainter(_dx),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView() {
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          child: SizedBox(
            width: 700,
            child: CustomPaint(
              painter: BezierPainter(_dx),
            ),
          ),
        );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(BezierGraphWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
