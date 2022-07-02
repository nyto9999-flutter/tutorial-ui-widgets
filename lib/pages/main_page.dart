import 'package:flutter/material.dart';
import 'package:tutorial_ui_widgets/pages/home_page.dart';
import 'indox_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = [
    const HomePage(),
    const InboxPage(),
  ];
  int _seletedIndex = 0;

  void _onTapped(int index) {
    setState(() {
      _seletedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          width: 180,
        ),
      ),
      // ListView is Flutter fashion of Android's RecyclerView and iOS UITableView.
      body: IndexedStack(index: _seletedIndex, children: [..._pages]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _seletedIndex, // the the active tab
        onTap: _onTapped,
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Inbox', icon: Icon(Icons.mail)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
