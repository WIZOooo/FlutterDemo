/// 假数据
final Map<String, dynamic> mockData = {
  "list" : [
    {
      "i_show_tpl": "item_type_1",
    },
    {
      "i_show_tpl": "item_type_2",
    },
    {
      "i_show_tpl": "item_type_3",
    },
    {
      "i_show_tpl": "item_type_1",
    },
    {
      "i_show_tpl": "item_type_3",
    },
  ]
};

/// 分割线类型
enum SeparatorType {
  // 没有线
  noLine,

  // 细线
  xiXian,

  // 粗线高度5
  cuXianHeight5,
}

class ItemEntity {
  ItemEntity({
    this.iShowTpl,
  });

  ItemEntity.fromJson(dynamic json) {
    json = json as Map<String, dynamic>;
    iShowTpl = json['i_show_tpl'] as String?;
  }

  String? type;
  String? iShowTpl;
  String? channelTitle;
  SeparatorType topLine = SeparatorType.noLine;
  SeparatorType bottomLine = SeparatorType.noLine;
}

/// 生成数据模型
List<ItemEntity> generateEntityList() {
  List<ItemEntity> list = [];
  List tempList = mockData["list"] as List;
  for(dynamic item in tempList) {
    ItemEntity entity = ItemEntity.fromJson(item);
    list.add(entity);
  }
  return list;
}