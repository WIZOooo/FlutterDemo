import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class ProxyProviderPage extends StatefulWidget {
  const ProxyProviderPage({Key? key,}) : super(key: key);
  @override
  ProxyProviderPageState createState() => ProxyProviderPageState();
}

class ProxyProviderPageState extends State<ProxyProviderPage> {
  @override

  /// ProxyProvider示例
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Person>(
          create: (ctx) => Person(),
        ),
        ///其中一个模型更新后会通知另一个模型也更新
        ProxyProvider<Person, EatModel>(
          update: (ctx, person, eatModel) => EatModel(name: "12123"),
        )
      ],
      child: const MaterialApp(
        home: ProxyProviderDemo(),
      ),
    );
  }
}

/// 页面内容
class ProxyProviderDemo extends StatelessWidget {
  const ProxyProviderDemo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer<EatModel>(builder: (ctx,eatModel,child) => Text(eatModel.whoEat)),
            Consumer<Person>( // 拿到person对象，调用方法
              builder: (ctx,person,child){
                return ElevatedButton( /// 点击按钮更新Person的name，eatModel.whoEat会同步更新
                  onPressed: () => person.changName(),
                  child: const Text("点击修改"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// person model
class Person extends ChangeNotifier{
  String name = "小虎牙";

  void changName(){
    name = "更新的小虎牙";
    notifyListeners();
  }
}


/// eat model
class EatModel{
  EatModel({required this.name});

  final String name;

  String get whoEat => "$randomNum正在吃饭";

  int get randomNum => Random().nextInt(10);
}