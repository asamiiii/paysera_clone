import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:paysera/edit_profile.dart';
import 'package:paysera/home.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:paysera/main.dart';
import 'package:paysera/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

final advancedDrawerController = AdvancedDrawerController();

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

List<Widget> screens = const [
  EditProfile(),
  HomeScreen(),
  HomeScreen(),
  HomeScreen(),
  HomeScreen(),
];

class _MainViewState extends State<MainView> {
  int? currentIndex = 4;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var profileImagePath = prefs.getString('profile_image');
      debugPrint('path : $profileImagePath');
      if (profileImagePath != null) {
        image = File(profileImagePath);
        if (image!.existsSync()) {
          // File exists, display the image
          debugPrint('file is Exist');
          Image.file(image!);
        } else {
          debugPrint('file is NOt Exist');
          // File does not exist, handle the error
          // You can display a placeholder image or show an error message
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        color: HexColor('F1F2F6'),
      ),
      openRatio: 0.65,
      openScale: 0.95,
      controller: advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: true,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black, blurRadius: 0.5, blurStyle: BlurStyle.outer),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                height: 50.h,
                // width: 200.w,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: HexColor('ffffff'),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: [
                        image == null
                            ? Image.asset(
                                'images/p.jpeg',
                                height: 35.h,
                                width: 35.w,
                                fit: BoxFit.fill,
                              )
                            : ClipOval(
                                child: Image.file(
                                    fit: BoxFit.fill,
                                    image!,
                                    height: 35.h,
                                    width: 35.h)),
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mail ?? 'Unknown',
                              style: TextStyle(fontSize: 10.sp),
                            ),
                            Text(
                              'عرض ملفي الشخصي',
                              style:
                                  TextStyle(fontSize: 8.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Colors.grey,
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Image.asset('images/fake_list.png'),
              Image.asset('images/fake_logout.jpeg')
            ],
          ),
        ),
      ),
      child: Scaffold(
        body: screens[currentIndex ?? 0],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/ic_more.png',
                  width: 20,
                  height: 20,
                  color: Colors.grey,
                ),
                label: 'المزيد'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/ic_add_gray.png',
                  width: 20,
                  height: 20,
                  color: Colors.grey,
                ),
                label: 'شحن'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/ic_transfers_blue_avatar.png',
                  width: 20,
                  height: 20,
                  color: Colors.grey,
                ),
                label: 'التحويلات'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/ic_credit_card.png',
                  width: 20,
                  height: 20,
                  color: Colors.grey,
                ),
                label: 'البطاقات'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/ic_wallet_avatar.png',
                  width: 20,
                  height: 20,
                ),
                label: 'المحفظة'),
          ],
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          currentIndex: currentIndex ?? 0,
        ),
      ),
    );
  }
}
