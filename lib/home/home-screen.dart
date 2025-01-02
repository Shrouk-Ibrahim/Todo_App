import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/auth/login/login_screen.dart';
import 'package:todo_application/home/settings/setting-list-tab.dart';
import 'package:todo_application/providers/auth-provider.dart';
import 'task-list/add-task-bottom-sheet.dart';
import 'task-list/task-list-tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    // var listProvider = Provider.of<ListProvider>(context, );///////////////////
    return Scaffold(
      //${authProvider.currentUser!.name}
      appBar: AppBar(
        title: Text(selectedIndex == 0 ? 'TO DO LIST' : 'Settings',
            style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(onPressed: (){
            // listProvider.tasksList=[];  //////////////on logout error//////////////////
            // authProvider.currentUser= null ;///////////on logout error////////////////
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }, icon: Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (int index) {
            selectedIndex = index;
            setState(() {});
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'task List'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'SETTINGS')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    TaskListTab(),
    SettingTab(),
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }
}
