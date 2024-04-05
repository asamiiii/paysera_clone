import 'package:flutter/material.dart';
import 'package:paysera/home.dart';


class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}
List<Widget> screens =const[
  HomeScreen(),
  HomeScreen(),
  HomeScreen(),
  HomeScreen(),
  HomeScreen()
  ];
class _MainViewState extends State<MainView> {
  int? currentIndex = 0;


  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: screens[currentIndex??0],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
items:  [
  BottomNavigationBarItem(icon:Image.asset('images/ic_more.png',width: 20,height: 20,color: Colors.grey,),label: 'المزيد'),
  BottomNavigationBarItem(icon:Image.asset('images/ic_add_gray.png',width: 20,height: 20,color: Colors.grey,),label: 'شحن'),
  BottomNavigationBarItem(icon:Image.asset('images/ic_transfers_blue_avatar.png',width: 20,height: 20,color: Colors.grey,),label: 'التحويلات'),
  BottomNavigationBarItem(icon:Image.asset('images/ic_credit_card.png',width: 20,height: 20,color: Colors.grey,),label: 'البطاقات'),
  BottomNavigationBarItem(icon:Image.asset('images/ic_wallet_avatar.png',width: 20,height: 20,),label: 'المحفظة'),
  ],
  onTap: (index) {
    currentIndex = index;
    setState(() {
      
    });
  },
  currentIndex: currentIndex??0,
      ),
    );
  }
}