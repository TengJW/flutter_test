import 'package:flutter/material.dart';

import 'home/HomePage.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  var currentIndex = 0;
  var imgs = [
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-02.png",
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-03.png",
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-04.png",
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-05.png",
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-06.png"
  ];
  var _pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: PageView(
        children: <Widget>[
          new HomePage(),
          Image.network(imgs[1]),
          Image.network(imgs[2]),
          Image.network(imgs[3]),
          Image.network(imgs[4]),
        ],
        onPageChanged: (int position) {
          setState(() {
            currentIndex = position;
          });
        },
        controller: _pageController,
      ),
      bottomNavigationBar: _getBNB(),
    );
  }

  BottomNavigationBar _getBNB() {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int position) {
          setState(() {
            currentIndex = position;
            _pageController.animateToPage(position,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              '首页',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            title: Text(
              '项目',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart),
            title: Text(
              '动态',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            title: Text(
              '体系',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            title: Text(
              '我的',
            ),
          ),
        ]);
  }
}
