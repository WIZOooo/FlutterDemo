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
            // Theme(
            //   data: Theme.of(context).copyWith(
            //     primaryColor: Colors.red,
            //     textTheme: TextTheme(headline4: TextStyle(fontSize: 3, color: Colors.red)),
            //     pageTransitionsTheme: PageTransitionsTheme(
            //       builders: {
            //         TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            //       },
            //     ),
            //   ),
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => MaterialRouteSubPage(),
            //         ),
            //       );
            //     },
            //     child: Text(
            //       'SubxxxxPage',
            //       style: Theme.of(context).textTheme.headline4,
            //     ),
            //   ),
            // ),
            Theme(
              // Create a unique theme with "ThemeData"
              data: ThemeData(
                accentColor: Colors.red,
                pageTransitionsTheme: PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                  },
                ),
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MaterialRouteSubPage(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
