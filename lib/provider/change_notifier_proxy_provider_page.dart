import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeNotifierProxyProviderPage extends StatefulWidget {
  const ChangeNotifierProxyProviderPage({Key? key,}) : super(key: key);
  @override
  ChangeNotifierProxyProviderPageState createState() => ChangeNotifierProxyProviderPageState();
}

class ChangeNotifierProxyProviderPageState extends State<ChangeNotifierProxyProviderPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ListModel>(
          create: (ctx) => ListModel(),
        ),
        ChangeNotifierProxyProvider<ListModel, CollectionListModel>(
          create: (ctx) => CollectionListModel(ListModel()),
          update: (ctx, listModel, collectionModel) => CollectionListModel(listModel),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        debugShowCheckedModeBanner: false,
        home: const ChangeNotifierProxyProviderDemo(),
      ),
    );;
  }
}

class Shop{
  final int id;
  final String name;
  Shop(this.id, this.name);
}

class ListModel {
  // 商品列表
  final List <Shop> shops = [
    Shop(1, "Apple/苹果 14 英寸 MacBook"),
    Shop(2, "HUAWEI/华为Mate 40 RS "),
    Shop(3, "Apple/苹果 11 英寸 iPad Pro"),
    Shop(4, "Xiaomi 12Pro5g骁龙8"),
    Shop(5, "Apple/苹果 iPhone 13 Pro"),
    Shop(6, "华为/HUAWEI Mate X2"),
    Shop(7, "小米11 Ultra至尊5g手机"),
    Shop(8, "HUAWEI/华为P40 Pro+ 5G 徕卡"),
  ];
}

class CollectionListModel extends ChangeNotifier{

  // 依赖ListModel
  final ListModel _listModel;

  CollectionListModel(this._listModel);

  // 所有收藏的商品
  List<Shop> shops = [];

  // 添加收藏
  void add(Shop shop){
    shops.add(shop);
    notifyListeners();
  }
  // 移除收藏
  void remove(Shop shop){
    shops.remove(shop);
    notifyListeners();
  }
}


class ChangeNotifierProxyProviderDemo extends StatefulWidget {
  const ChangeNotifierProxyProviderDemo({Key? key}) : super(key: key);
  @override
  _ChangeNotifierProxyProviderDemoState createState() => _ChangeNotifierProxyProviderDemoState();
}

class _ChangeNotifierProxyProviderDemoState extends State<ChangeNotifierProxyProviderDemo> {
  int _selectedIndex = 0;
  final _pages = [const ListPage(), const CollectionPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: "商品列表"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "收藏列表"
          )
        ],
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ListModel listModel = Provider.of<ListModel>(context);
    List<Shop> shops = listModel.shops;
    return Scaffold(
      appBar: AppBar(title: const Text("商品列表"),),
      body: ListView.builder(
        itemCount: listModel.shops.length,
        itemBuilder: (ctx,index) => ShopItem(shop: shops[index],),
      ),
    );
  }
}
class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CollectionListModel collectionModel = Provider.of<CollectionListModel>(context);
    List<Shop> shops = collectionModel.shops;
    return Scaffold(
      appBar: AppBar(title: const Text("收藏列表"),),
      body: ListView.builder(
        itemCount: shops.length,
        itemBuilder: (ctx,index) => ShopItem(shop: shops[index],),
      ),
    );
  }
}

class ShopItem extends StatelessWidget {
  const ShopItem({Key? key,required this.shop}) : super(key: key);
  final Shop shop;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text("${shop.id}"),
      ),
      title: Text(shop.name,style: const TextStyle(fontSize: 17),),
      trailing: ShopCollectionButton(shop: shop,),
    );
  }
}

class ShopCollectionButton extends StatelessWidget {
  const ShopCollectionButton({Key? key,required this.shop}) : super(key: key);
  final Shop shop;
  @override
  Widget build(BuildContext context) {
    CollectionListModel collectionModel = Provider.of<CollectionListModel>(context);
    bool contains = collectionModel.shops.contains(shop);
    return InkWell(
      onTap: contains ? ()=> collectionModel.remove(shop) : ()=> collectionModel.add(shop),
      child:  SizedBox(
        width: 60,height: 60,
        child: contains ? const Icon(Icons.favorite,color: Colors.redAccent,) : const Icon(Icons.favorite_border),
      ),
    );
  }
}
