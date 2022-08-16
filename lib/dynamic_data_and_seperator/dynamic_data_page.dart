import 'package:flutter/material.dart';
import 'package:material_route_demo/dynamic_data_and_seperator/entity.dart';
import 'package:material_route_demo/dynamic_data_and_seperator/constants.dart';

class DynamicDataPage extends StatelessWidget {
  DynamicDataPage({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ItemEntity> entityList = generateEntityList();
    checkSeparatorLevel(entityList);

    return Scaffold(
      appBar: AppBar(
        title: Text('动态数据流'),
      ),
      body: ListView.separated(itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            // 上分割线
            generateSeparator(context, entityList[index].topLine),

            itemWidgetList[entityList[index].iShowTpl]?.widget(entityList[index]) ?? Container(),

            // 下分割线
            generateSeparator(context, entityList[index].bottomLine),
          ],
        );
      }, separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      }, itemCount: entityList.length),
    );
  }
}