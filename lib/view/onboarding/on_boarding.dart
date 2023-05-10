import 'package:bahanku/view/onboarding/login_new.dart';
import 'package:bahanku/view/onboarding/register_new.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 40,
            ),
            TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              controller: tabController,
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontSize: 18),
              unselectedLabelStyle: const TextStyle(fontSize: 18),
              indicatorWeight: 3,
              tabs: const [
                Tab(
                  text: 'Sign In',
                ),
                Tab(
                  text: 'Sign Up',
                ),
              ],
            ),
            SizedBox(
              width: double.maxFinite,
              height: 650,
              child: TabBarView(
                controller: tabController,
                children: const [
                  Tab(child: LoginPage()),
                  Tab(child: RegisterPage())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
