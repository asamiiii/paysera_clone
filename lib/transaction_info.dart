import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:paysera/dummy_transation.dart';
import 'package:paysera/edit_profile.dart';
import 'package:paysera/trans.dart';

class InComingTransInfo extends StatelessWidget {
  DetailsData item;
  InComingTransInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
   String formattedDate = DateFormat(
      'd MMM y',
      
    ).format(item.time!);
    var list= formattedDate.split(' ');
    String formattedTime = DateFormat('h:m a',).format(item.time!);
    var timeList= formattedTime.split(' ');
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    debugPrint('date list : ${list.first}');
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: HexColor('f1f2f6'),
        bottomNavigationBar: Container(
          width: screenWidth,
          color: Colors.white,
          child: Image.asset('images/come.png',height: 50.h,)),
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            'تفاصيل المعاملة',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: HexColor('019cde'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    item.imagePath == null || item.imagePath == ''
                        ? CircleAvatar(
                            radius: 40.sp,
                            backgroundColor: HexColor('73a5d2'),
                            child: Text(
                              getInitials(item.userName ?? ''),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30.sp),
                            ),
                          )
                        : ClipOval(
                            child: Image.file(
                                fit: BoxFit.fill,
                                File(item.imagePath ?? ''),
                                height: 90.h,
                                width: 90.w)),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  item.userName ?? 'Un known',
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  item.iBan ?? 'Un known',
                  style: TextStyle(fontSize: 15.sp, color: HexColor('858a90')),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  item.userName ?? 'Un known',
                  style: TextStyle(fontSize: 15.sp, color: HexColor('858a90')),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+',
                      style: TextStyle(color: Colors.green, fontSize: 40.sp),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      item.ammount ?? 'Un known',
                      style: TextStyle(
                        fontSize: 35.sp,
                        color: item.sent == true ? Colors.red : Colors.green,
                      ),
                    ),
                    Icon(
                      Icons.euro,
                      size: 40.sp,
                      color: Colors.green,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textDirection: ui.TextDirection.ltr,
                      ' ${list[0]}',
                      style: TextStyle(color: HexColor('94999d')),
                    ),
                    Text(
                      textDirection: ui.TextDirection.ltr,
                      ' ${convertEnglishMonthToArabic(list[1])} ',
                      style: TextStyle(color: HexColor('94999d')),
                    ),
                    Text(
                      textDirection: ui.TextDirection.ltr,
                      '${list[2]}',
                      style: TextStyle(color: HexColor('94999d')),
                    ),
                    Text(
                      ' علي',
                      style: TextStyle(color: HexColor('94999d')),
                    ),
                    Text(
                      textDirection: ui.TextDirection.ltr,
                      '${timeList[0]} ',
                      style: TextStyle(color: HexColor('94999d')),
                    ),
                    Text(
                      textDirection: ui.TextDirection.ltr,
                      timeList[1]=='AM'?' ص' :' م ' ,
                      style: TextStyle(color: HexColor('94999d')),
                    ),
                    
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'الاجراءات',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
                Card(
                  color: HexColor('ffffff'),
                  surfaceTintColor: HexColor('ffffff'),
                  child: ListTile(
                    onTap: () {},
                    visualDensity: VisualDensity(vertical: 3), //
                    title: Text(
                      'الحصول علي كشف المعاملة',
                      style: TextStyle(fontSize: 15),
                    ),
                    leading: Image.asset(
                      'images/ic_bill_gray.png',
                      height: 35.h,
                      width: 35.w,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OutGoingTransInfo extends StatelessWidget {
  DetailsData item;
  OutGoingTransInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
     String formattedDate = DateFormat(
      'd MMM y',
      
    ).format(item.time!);
    var list= formattedDate.split(' ');
    String formattedTime = DateFormat('h:m a',).format(item.time!);
    var timeList= formattedTime.split(' ');
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    debugPrint('date list : ${list.first}');
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: HexColor('f1f2f6'),
        bottomNavigationBar: Container(
          width: screenWidth,
          color: Colors.white,
          child: Image.asset('images/out.png',height: 50.h,)),
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            'تفاصيل المعاملة',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: HexColor('019cde'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    item.imagePath == null || item.imagePath == ''
                        ? CircleAvatar(
                            radius: 40.sp,
                            backgroundColor: HexColor('73a5d2'),
                            child: Text(
                              getInitials(item.userName ?? ''),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30.sp),
                            ),
                          )
                        : ClipOval(
                            child: Image.file(
                                fit: BoxFit.fill,
                                File(item.imagePath ?? ''),
                                height: 90.h,
                                width: 90.w)),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  item.userName ?? '',
                  style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  item.iBan ?? 'Un known',
                  style: TextStyle(fontSize: 15.sp, color: HexColor('858a90')),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  item.userName ?? 'Un known',
                  style: TextStyle(fontSize: 15.sp, color: HexColor('858a90')),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '-',
                      style: TextStyle(color: Colors.red, fontSize: 40.sp),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      item.ammount ?? 'Un known',
                      style: TextStyle(
                        fontSize: 35.sp,
                        color: Colors.red,
                      ),
                    ),
                    Icon(
                      Icons.euro,
                      size: 40.sp,
                      color: Colors.red,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textDirection: ui.TextDirection.ltr,
                      ' ${list[0]}',
                      style: TextStyle(color: HexColor('94999d')),
                    ),
                    Text(
                      textDirection: ui.TextDirection.ltr,
                      ' ${convertEnglishMonthToArabic(list[1])} ',
                      style: TextStyle(color: HexColor('94999d')),
                    ),
                    Text(
                      textDirection: ui.TextDirection.ltr,
                      '${list[2]}',
                      style: TextStyle(color: HexColor('94999d')),
                    ),
                    Text(
                      ' علي',
                      style: TextStyle(color: HexColor('94999d')),
                    ),
                    Text(
                      textDirection: ui.TextDirection.ltr,
                      '${timeList[0]} ',
                      style: TextStyle(color: HexColor('94999d')),
                    ),
                    Text(
                      textDirection: ui.TextDirection.ltr,
                      timeList[1]=='AM'?' ص' :' م ' ,
                      style: TextStyle(color: HexColor('94999d')),
                    ),
                    
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'الاجراءات',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 230.h,
                  child: ListView.separated(
                    padding: EdgeInsets.only(bottom: 20),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 60.h,
                        width: screenWidth,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: HexColor('ffffff'),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(index == 0 ? 10 : 0),
                              topRight: Radius.circular(index == 0 ? 10 : 0),
                              bottomLeft: Radius.circular(
                                  index == services.length - 1 ? 10 : 0),
                              bottomRight: Radius.circular(
                                  index == services.length - 1 ? 10 : 0),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              textDirection: ui.TextDirection.rtl,
                              children: [
                                CircleAvatar(
                                  radius: 15.sp,
                                  backgroundColor: HexColor('73a5d2'),
                                  backgroundImage: AssetImage(
                                      services[index].iconPath ?? ''),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Column(
                                  textDirection: ui.TextDirection.rtl,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      services[index].title ?? '',
                                      style: TextStyle(fontSize: 12.sp),
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
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: HexColor('f4f4f4'),
                        height: 0,
                        indent: 70.w,
                        // endIndent: 70.w,
                        thickness: 1,
                      );
                    },
                    itemCount: services.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceItem {
  String? iconPath;
  String? title;

  ServiceItem({this.iconPath, this.title});
}

List<ServiceItem> services = [
  ServiceItem(
      iconPath: 'images/ic_bill_gray.png', title: 'الحصول على كشف المعاملة'),
  ServiceItem(
      iconPath: 'images/ic_recurring_payment_green.png',
      title: 'تعيين كدفعة متكررة'),
  ServiceItem(
      iconPath: 'images/ic_create_payment_blue.png', title: 'انشاء قالب'),
  ServiceItem(
      iconPath: 'images/ic_split_bill_yellow.png', title: 'تقسيم الفاتورة')
];



String? convertEnglishMonthToArabic(String? month) {
  Map<String, String> monthMap = {
    'Jan': 'يناير',
    'Feb': 'فبراير',
    'Mar': 'مارس',
    'Apr': 'ابريل',
    'May': 'مايو',
    'Jun': 'يونيو',
    'Jul': 'يوليو',
    'Aug': 'اغسطس',
    'Sep': 'سبتمبر',
    'Oct': 'اكتوبر',
    'Nov': 'نوفمبر',
    'Dec': 'ديسمبر',
  };

  return monthMap.containsKey(month) ? monthMap[month] : null;
}