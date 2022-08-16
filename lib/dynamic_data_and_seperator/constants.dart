import 'package:flutter/material.dart';
import 'package:material_route_demo/dynamic_data_and_seperator/entity.dart';

/// Type 对应的控件
final Map<String, ItemWidgetFunction> itemWidgetList = <String, ItemWidgetFunction>{
  'item_type_1': ItemWidgetFunction(
    topLine: SeparatorType.noLine,
    bottomLine: SeparatorType.cuXianHeight5,
    widget: (ItemEntity entity) {
      return Text("item_type_1");
    },
  ),
  'item_type_2': ItemWidgetFunction(
    topLine: SeparatorType.xiXian,
    bottomLine: SeparatorType.xiXian,
    widget: (ItemEntity entity) {
      return Text("item_type_2");
    },
  ),
  'item_type_3': ItemWidgetFunction(
    topLine: SeparatorType.xiXian,
    bottomLine: SeparatorType.xiXian,
    widget: (ItemEntity entity) {
      return Text("item_type_3");
    },
  ),
};

/// 绑定 Item 和分割线
class ItemWidgetFunction {
  ItemWidgetFunction({
    required this.topLine,
    required this.bottomLine,
    required this.widget,
  });

  // item 上边的分割线
  SeparatorType topLine;

  // item 下边的分割线
  SeparatorType bottomLine;

  // item
  Widget Function(ItemEntity entity) widget;
}

/// 处理 item 之间的分割线类型
void checkSeparatorLevel(List<ItemEntity>? dataList, {final int startIndex = 0}) {
  if (dataList == null || dataList.isEmpty || startIndex >= dataList.length) {
    return;
  }
  final int size = dataList.length;

  int startPosition = startIndex;
  if (startPosition != 0) {
    startPosition = startPosition - 1;
  }

  // 判断上下的等级, 如果比上下的低就把等级降到没有线, 否则不变
  ItemEntity currData;
  ItemEntity? preData;
  ItemEntity? nextData;
  for (int i = startPosition; i < size; i++) {
    currData = dataList[i];
    preData = i - 1 >= 0 ? dataList[i - 1] : null;
    nextData = i + 1 < size ? dataList[i + 1] : null;

    // 设置分割线类型
    currData.topLine = itemWidgetList[currData.iShowTpl ?? '']?.topLine ?? SeparatorType.noLine;
    currData.bottomLine = itemWidgetList[currData.iShowTpl ?? '']?.bottomLine ?? SeparatorType.noLine;

    nextData?.topLine = itemWidgetList[nextData.iShowTpl ?? '']?.topLine ?? SeparatorType.noLine;
    nextData?.bottomLine = itemWidgetList[nextData.iShowTpl ?? '']?.bottomLine ?? SeparatorType.noLine;

    // 上方部件下分割线如果是粗线，隐藏当前部件上分割线
    // 上下相同的话，显示上方数据的底部的线
    if (preData == null || currData.topLine.index <= preData.bottomLine.index) {
      currData.topLine = SeparatorType.noLine;
    }

    if (nextData == null || currData.bottomLine.index < nextData.topLine.index) {
      currData.bottomLine = SeparatorType.noLine;
    }
  }
}

/// 根据分割线类型创建分割线
Widget generateSeparator(BuildContext context, SeparatorType separatorType) {
  switch (separatorType) {
    case SeparatorType.noLine:
      return const SizedBox(width: 0, height: 0);
    case SeparatorType.xiXian:
      return Container(
        width: double.infinity,
        height: 0.5,
        margin: const EdgeInsets.symmetric(horizontal: 14),
        color: Color(0xFFDEDEDE),
      );
    case SeparatorType.cuXianHeight5:
      return Container(
        width: double.infinity,
        height: 5,
        color: Color(0xFFDEDEDE),
      );
  }
}
