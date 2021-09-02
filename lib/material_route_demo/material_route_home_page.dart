import 'package:flutter/material.dart';

import 'material_route_sub_page.dart';

class MaterialRouteHomePage extends StatefulWidget {
  MaterialRouteHomePage({Key? key}) : super(key: key);

  @override
  _MaterialRouteHomePageState createState() => _MaterialRouteHomePageState();
}

class _MaterialRouteHomePageState extends State<MaterialRouteHomePage> {
  void _router() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MaterialRouteSubPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Click floating Button to route',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _router,
        tooltip: 'Click to route',
        child: Icon(Icons.add),
      ),
    );
  }
}
