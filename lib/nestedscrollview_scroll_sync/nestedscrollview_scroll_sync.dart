import 'package:flutter/material.dart';
import 'package:material_route_demo/nestedscrollview_scroll_sync/custom_nested_scrollview.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final GlobalKey<NestedScrollViewState> globalKey = GlobalKey();

ListView listView = ListView.separated(
  // physics: NeverScrollableScrollPhysics(),
  // shrinkWrap: true,
  // controller: globalKey.currentState!.innerController,
  itemBuilder: (context, index) => Text(
    "Hello friend $index",
  ),
  separatorBuilder: (context, index) => SizedBox(
    height: 20,
  ),
  itemCount: 100,
);

List<Widget> tabWidgets = <Widget>[listView, listView, listView, listView];

SliverList sliverList = SliverList(
  delegate: SliverChildBuilderDelegate(
    (BuildContext context, int index) {
      return Text(
        'Hello friend $index',
      );
    },
    childCount: 50,
  ),
);

class NestedScrollViewTabViewScrollSync extends StatefulWidget {
  NestedScrollViewTabViewScrollSync({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  _NestedScrollViewTabViewScrollSyncState createState() =>
      _NestedScrollViewTabViewScrollSyncState();
}

class _NestedScrollViewTabViewScrollSyncState
    extends State<NestedScrollViewTabViewScrollSync>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // late CustomNestedScrollCoordinator coordinator;
  // late List<CustomNestedScrollController> innerControllerList;
  late ScrollController _scrollViewController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // innerControllerList = [
    //   // CustomNestedScrollController(coordinator)
    // ];
    tabController = TabController(vsync: this, length: 4);
    tabController.addListener(() {
      if (tabController.index != currentIndex) {

      }
    });
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
        key: globalKey,
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
                        icon: Icon(Icons.description,
                            color: Theme.of(context).accentColor),
                      ),
                      Tab(
                        icon: Icon(Icons.timer,
                            color: Theme.of(context).accentColor),
                      ),
                      Tab(
                        icon: Icon(Icons.ondemand_video,
                            color: Theme.of(context).accentColor),
                      ),
                      Tab(
                        icon: Icon(Icons.photo_camera,
                            color: Theme.of(context).accentColor),
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
                      physics: NeverScrollableScrollPhysics(),
                      primary: false,
                      controller: ScrollController(),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverFillRemaining(
                          child: SmartRefresher(
                            enablePullUp: true,
                            enablePullDown: true,
                            controller: RefreshController(),
                            child: CustomScrollView(
                              controller: globalKey.currentState!.innerController,
                              primary: false,
                              slivers: [
                                sliverList,
                              ],
                            ),
                          ),
                        ),
                        // SliverFillRemaining(child: w)
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
