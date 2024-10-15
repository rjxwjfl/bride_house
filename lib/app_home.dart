import 'package:bride_house/pages/customer/customer_view.dart';
import 'package:bride_house/pages/item/item_state_view.dart';
import 'package:flutter/material.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  late final PageController _pageController;
  late int _currentIndex;
  List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.data_thresholding_outlined), label: '상품'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: '고객'),
  ];

  void _pageRouter(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(_currentIndex);
  }

  @override
  void initState() {
    _currentIndex = 0;
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          ItemView(),
          CustomerView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(onTap: _pageRouter, currentIndex: _currentIndex, items: items),
    );
  }
}
