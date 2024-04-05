import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:paysera/dummy_transation.dart';

class InComingTransInfo extends StatelessWidget {
  DetailsData item;
  InComingTransInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: HexColor('f1f2f6'),
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
                    CircleAvatar(
                      radius: 40.sp,
                      backgroundColor: HexColor('73a5d2'),
                      child: Text(
                        'AS',
                        style: TextStyle(color: Colors.white, fontSize: 30.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  'User Name',
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '1254878454121545',
                  style: TextStyle(fontSize: 15.sp, color: HexColor('858a90')),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'kjhkjhjkhjkhjkh',
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
                            style:
                                TextStyle(color: Colors.green, fontSize: 40.sp),
                          ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      '10',
                      style: TextStyle(
                        fontSize: 35.sp,
                        color: item.sent == true ? Colors.red : Colors.green,
                      ),
                    ),
                    Icon(
                      Icons.euro,
                      size: 40.sp,
                      color:  Colors.green,
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
                      '3 ابريل 2023 علي 11:30 ص',
                      style: TextStyle(color: HexColor('94999d')),
                    )
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
                    onTap: () {
                      
                    },
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
   OutGoingTransInfo({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
     var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: HexColor('f1f2f6'),
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
                    CircleAvatar(
                      radius: 40.sp,
                      backgroundColor: HexColor('73a5d2'),
                      child: Text(
                        'AS',
                        style: TextStyle(color: Colors.white, fontSize: 30.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  'User Name',
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '1254878454121545',
                  style: TextStyle(fontSize: 15.sp, color: HexColor('858a90')),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'User Name',
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
                            style:
                                TextStyle(color: Colors.red, fontSize: 40.sp),
                          ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      '10',
                      style: TextStyle(
                        fontSize: 35.sp,
                        color:  Colors.red,
                      ),
                    ),
                    Icon(
                      Icons.euro,
                      size: 40.sp,
                      color:  Colors.red,
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
                      '3 ابريل 2023 علي 11:30 ص',
                      style: TextStyle(color: HexColor('94999d')),
                    )
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
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>dummyData[index].sent==true ? OutGoingTransInfo(item: dummyData[index],):  InComingTransInfo(item: dummyData[index],),));
                                  },
                                  child: Container(
                                    height: 70.h,
                                    width: screenWidth,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: HexColor('ffffff'),
                                        borderRadius: BorderRadius.only(
                                          topLeft:
                                              Radius.circular(index == 0 ? 10 : 0),
                                          topRight:
                                              Radius.circular(index == 0 ? 10 : 0),
                                          bottomLeft: Radius.circular(
                                              index == services.length - 1
                                                  ? 10
                                                  : 0),
                                          bottomRight: Radius.circular(
                                              index == services.length - 1
                                                  ? 10
                                                  : 0),
                                        )),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            CircleAvatar(
                                              radius: 22.sp,
                                              backgroundColor: HexColor('73a5d2'),
                                              backgroundImage: AssetImage(services[index].iconPath??''),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Column(
                                              textDirection: TextDirection.rtl,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(services[index].title??''),
                                                
                                              ],
                                            ),
                                            Expanded(child: SizedBox()),
                                            Icon(Icons.arrow_forward_ios,size: 15,color: Colors.grey,)
                                          ],
                                        )
                                      ],
                                    ),
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
                              itemCount: dummyData.length,
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


class ServiceItem{
  String? iconPath;
  String? title;

  ServiceItem({this.iconPath,this.title});
}

List<ServiceItem> services = [
  ServiceItem(iconPath: 'images/ic_bill_gray.png',title: 'الحصول على كشف المعاملة'),
  ServiceItem(iconPath: 'images/ic_recurring_payment_green.png',title: 'تعيين كدفعة متكررة'),
  ServiceItem(iconPath: 'images/ic_create_payment_blue.png',title: 'انشاء قالب'),
  ServiceItem(iconPath: 'images/ic_split_bill_yellow.png',title: 'تقسيم الفاتورة')
];
