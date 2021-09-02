import 'package:flutter/material.dart';

class MaterialRouteSubPage extends StatefulWidget {
  MaterialRouteSubPage({Key? key}) : super(key: key);

  @override
  _MaterialRouteSubPageState createState() => _MaterialRouteSubPageState();
}

class _MaterialRouteSubPageState extends State<MaterialRouteSubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SubPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'SubPage',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
          ],
        ),
      ),
    );
  }
}
