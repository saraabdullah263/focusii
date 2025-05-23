import 'package:flutter/material.dart';
import 'package:focusi/features/home/veiw/analytics_veiw.dart';
import 'package:focusi/features/home/veiw/home_veiw.dart';
import 'package:focusi/features/home/veiw/profile_veiw.dart';
import 'package:focusi/features/home/veiw/taskmanger_veiw.dart';
import 'package:focusi/features/home/widget/custom_button_nav_bar.dart';

class MainVeiw extends StatefulWidget {
  const MainVeiw({super.key});

  @override
  State<MainVeiw> createState() => _MainVeiwState();
}

class _MainVeiwState extends State<MainVeiw> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomButtonNavBar(
          onItemTapped: _onItemTapped,
          selectedIndex: selectedIndex,
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: const [
            HomeVeiw(),
            TaskmangerVeiw(),
            AnalyticsVeiw(),
            ProfileVeiw(),
          ],
        ),
      ),
    );
  }
}
