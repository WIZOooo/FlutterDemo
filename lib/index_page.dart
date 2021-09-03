import 'package:flutter/material.dart';
import 'package:material_route_demo/material_route_demo/material_route_home_page.dart';

final List<IndexPageItem> pageItemList = [
  IndexPageItem(
    itemName: 'Material Route Demo',
    targetWidget: MaterialRouteHomePage(),
  ),
];

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
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          return pageItemList[index];
        },
        separatorBuilder: (context, index) => Container(
          color: Colors.blueGrey,
          height: 1,
        ),
        itemCount: pageItemList.length,
      ),
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
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
