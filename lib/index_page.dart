import 'package:flutter/material.dart';
import 'package:material_route_demo/Navigation/popWithResult/pop_with_result.dart';
import 'package:material_route_demo/Navigation/routesetting_transfer_param/routesetting_transfer_param.dart';
import 'package:material_route_demo/material_route_demo/material_route_home_page.dart';
import 'package:material_route_demo/nestedScroll_view_demo/nestedScroll_view_demo.dart';
import 'package:material_route_demo/provider/provider_page.dart';
import 'package:material_route_demo/scroll_extra_space/scroll_extra_space.dart';
import 'package:material_route_demo/sliverfillingremain_scroll_async/sliverfillingremain_scroll_async.dart';

import 'nestedscrollview_scroll_sync/nestedscrollview_scroll_sync.dart';

final List<IndexPageItem> pageItemList = [
  IndexPageItem(
    itemName: 'Provider',
    targetWidget: ProviderPage(),
  ),
  IndexPageItem(
    itemName: '使用Material Route跳转',
    targetWidget: MaterialRouteHomePage(),
  ),
  IndexPageItem(
    itemName: 'Navigation / 从一个页面返回数据',
    targetWidget: HomeScreen(),
  ),
  IndexPageItem(
    itemName: 'Navigation / 使用RouteSetting传递参数',
    targetWidget: TodosScreen(
      todos: List.generate(
        20,
        (i) => Todo(
          'Todo $i',
          'A description of what needs to be done for Todo $i',
        ),
      ),
    ),
  ),
  IndexPageItem(
    itemName: 'NestedScrollViewDemo',
    targetWidget: NestedScrollViewDemoPage(),
  ),
  IndexPageItem(
    itemName: 'Bug / tabView多余滚动去除',
    targetWidget: ScrollExtraSpaceHomePage(title: 'Flutter Demo Home Page'),
  ),
  IndexPageItem(
    itemName: 'Bug / NestedScrollView的Body中含有多层滚动视图导致内外层滚动割裂',
    targetWidget: SliverFillingRemainScrollAsyncPage(
      title: 'SliverFillingRemainScrollAsyncPage',
    ),
  ),
  IndexPageItem(
    itemName: 'Bug / NestedScrollView嵌套tabView导致子tab之间滚动相互影响',
    targetWidget: NestedScrollViewTabViewScrollSync(
      title: 'NestedScrollViewTabViewScrollSync',
    ),
  ),
  IndexPageItem(
    itemName: 'Flutter实战 / AnimatedListDemo',
    targetWidget: NestedScrollViewTabViewScrollSync(
      title: 'NestedScrollViewTabViewScrollSync',
    ),
  ),
];

ListView pageContentListView = ListView.separated(
  padding: EdgeInsets.symmetric(horizontal: 20),
  itemBuilder: (context, index) {
    return pageItemList[index];
  },
  separatorBuilder: (context, index) => Container(
    color: Colors.blueGrey,
    height: 1,
  ),
  itemCount: pageItemList.length,
);

class IndexPage extends StatelessWidget {
  IndexPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Index Page'),
      ),
      body: pageContentListView,
    );
  }
}

class IndexPageItem extends StatelessWidget {
  IndexPageItem({
    Key? key,
    required this.itemName,
    required this.targetWidget,
  }) : super(key: key);
  final String itemName;
  final Widget targetWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => targetWidget,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text(
          itemName,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}

class UnitPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // print(
    //     "=====shrinkOffset:$shrinkOffset======overlapsContent:$overlapsContent====");
    // final String info =
    //     'shrinkOffset:${shrinkOffset.toStringAsFixed(1)}'
    //     '\noverlapsContent:$overlapsContent';

    return Container(
      alignment: Alignment.center,
      child: Text('Header: Pinned 100高度'),
      color: Colors.red.withOpacity(0.4),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
