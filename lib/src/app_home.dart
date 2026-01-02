import 'package:bride_house/src/view/customer/customer_view.dart';
import 'package:bride_house/src/view/item/item_list_view.dart';
import 'package:bride_house/src/view/item/item_search_view.dart';
import 'package:bride_house/src/view/schedule/schedule_view.dart';
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
    const BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: '캘린더'),
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
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          ScheduleView(),
          ItemListView(),
          CustomerView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(onTap: _pageRouter, currentIndex: _currentIndex, items: items),
    );
  }
}
