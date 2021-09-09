import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ListView listView = ListView.separated(
  // physics: NeverScrollableScrollPhysics(),
  // shrinkWrap: true,
  itemBuilder: (context, index) => Text(
    "Hello friend $index",
  ),
  separatorBuilder: (context, index) => SizedBox(
    height: 20,
  ),
  itemCount: 100,
);

List<Widget> tabWidgets = <Widget>[
  listView,
  listView,
  listView,
  listView
];

class SliverFillingRemainScrollAsyncPage extends StatefulWidget {
  SliverFillingRemainScrollAsyncPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SliverFillingRemainScrollAsyncPageState createState() => _SliverFillingRemainScrollAsyncPageState();
}

class _SliverFillingRemainScrollAsyncPageState extends State<SliverFillingRemainScrollAsyncPage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);

    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scroll extra space'),
      ),
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  expandedHeight: 300.0,
                  forceElevated: innerBoxIsScrolled,
                  stretch: true,
                  bottom: TabBar(
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(Icons.description, color: Theme.of(context).accentColor),
                      ),
                      Tab(
                        icon: Icon(Icons.timer, color: Theme.of(context).accentColor),
                      ),
                      Tab(
                        icon: Icon(Icons.ondemand_video, color: Theme.of(context).accentColor),
                      ),
                      Tab(
                        icon: Icon(Icons.photo_camera, color: Theme.of(context).accentColor),
                      ),
                    ],
                    controller: tabController,
                  )),
            ),
          ];
        },
        body: TabBarView(
          children: tabWidgets.map((Widget w) {
            return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        ),
                        SliverToBoxAdapter(child: w)
                      ],
                    );
                  },
                ));
          }).toList(),
          controller: tabController,
        ),
      ),
    );
  }
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text(widget.title),
//     ),
//     body: CustomScrollView(
//         slivers: <Widget>[
//
//           SliverPersistentHeader(
//             pinned: true,
//             delegate: _SliverTabBarViewDelegate(
//               child: Container(
//                   color: Theme
//                       .of(context)
//                       .cardColor,
//                   child: TabBar(
//                     tabs: <Widget>[
//                       Tab(
//                         icon: Icon(Icons.account_box, color: Theme
//                             .of(context)
//                             .accentColor),
//                       ),
//                       Tab(
//                         icon: Icon(Icons.history, color: Theme
//                             .of(context)
//                             .accentColor),
//                       ),
//                       Tab(
//                         icon: Icon(Icons.photo_camera, color: Theme
//                             .of(context)
//                             .accentColor),
//                       ),
//                       Tab(
//                         icon: Icon(
//                           Icons.mail_outline,
//                           color: Theme
//                               .of(context)
//                               .accentColor,
//                         ),
//                       )
//                     ],
//                     controller: tabController,
//                   )),
//             ),
//           ),
//           SliverFillRemaining(
//             hasScrollBody: true,
//             child: TabBarView(
//               children: <Widget>[
//                 new Text("Hello friend",),
//                 new Text("Hello friend",),
//                 new Text("Hello friend",),
//                 new Text("Hello friend",)
//               ],
//               controller: tabController,
//             ),
//           ),
//         ]), // This trailing comma makes auto-formatting nicer for build methods.
//   );
// }
}

class _SliverTabBarViewDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarViewDelegate({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: child,
      elevation: 200,
    );
  }

  @override
  double get maxExtent => kTextTabBarHeight;

  @override
  double get minExtent => kTextTabBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
