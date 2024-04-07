import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:paysera/account_info.dart';
import 'package:paysera/dummy_transation.dart';
import 'package:paysera/edit_profile.dart';
import 'package:paysera/main.dart';
import 'package:paysera/main_view.dart';
import 'package:paysera/trans.dart';
import 'package:paysera/transaction_info.dart';
import 'package:paysera/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paysera/cash_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      isLoading = true;
      setState(() {});
      totalPalance = prefs.getString('totalPalance');
      // eurAccountNumber =await  CacheHelper.getStringFromCache(key: 'EUR_account_number')??'Un Known';
      // usdAccountNumber =await  CacheHelper.getStringFromCache(key: 'USD_account_number')??'Un Known';
      // gbpAccountNumber =await  CacheHelper.getStringFromCache(key: 'GBP_account_number')??'Un Known';
      userName = await getProfileName() ?? 'AS';
      firstChar = getInitials(await getProfileName() ?? 'AS');
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

      accountName = await CacheHelper.getStringFromCache(key: 'account_name');
      iBan = await CacheHelper.getStringFromCache(key: 'iban');
      bankName = await CacheHelper.getStringFromCache(key: 'bank_name');
      bankAddress = await CacheHelper.getStringFromCache(key: 'bank_address');
      swift_bic = await CacheHelper.getStringFromCache(key: 'swift_bic');
      bank_out_name =
          await CacheHelper.getStringFromCache(key: 'bank_out_name');
      bank_out_address =
          await CacheHelper.getStringFromCache(key: 'bank_out_address');
      bank_out_swift =
          await CacheHelper.getStringFromCache(key: 'bank_out_swift');
      mail = await CacheHelper.getStringFromCache(key: 'mail');
      // eurTotalPalance = prefs.getString('EUR_totalPalance');
      await getAllLocalTrans();
      listData.sort((a, b) => a.time!.compareTo(b.time!));
      debugPrint('list dat : $listData');
      isLoading = false;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: HexColor('F1F2F6'),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200.h,
                    width: screenWidth,
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, top: 40.h),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [HexColor('0D4E85'), HexColor('038DCC')])),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.qr_code_scanner,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Icon(
                              Icons.notifications_none_rounded,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Container(
                              height: 30.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  color: HexColor('317DAE'),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                  Expanded(child: SizedBox()),
                                  Container(
                                    height: 30.h,
                                    width: 130.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 1),
                                    decoration: BoxDecoration(
                                        color: HexColor('0C457A'),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                       Expanded(child: SizedBox()),
                                        Column(
                                          children: [
                                            SizedBox(
                                              width:  85.w,
                                              child: Text(
                                                accountName ?? 'unknown@outlook.com',
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              'حساب دفع',
                                              style: TextStyle(
                                                  fontSize: 6.sp,
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                        const Expanded(child: SizedBox()),
                                         image == null
                              ? CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey[200],
                                  child: Text(
                                    firstChar == null || firstChar!.isEmpty
                                        ? ''
                                        : firstChar ?? '',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                )
                              : ClipOval(
                                  child: Image.file(
                                      fit: BoxFit.fill,
                                      image!,
                                      height: 30,
                                      width: 30)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            InkWell(
                              onTap: () {
                                advancedDrawerController.showDrawer();
                                setState(() {});
                              },
                              child: Icon(
                                Icons.settings_outlined,
                                color: Colors.white,
                                size: 25.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              // backgroundColor: HexColor('F1F2F6'),
                              builder: (context) => Container(
                                width: screenWidth,
                                height: screenHeight * 0.70,
                                decoration: BoxDecoration(
                                    color: HexColor('F1F2F6'),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25))),
                                child: AccountInfo(),
                                // child: EuroDetails(
                                //     type: 'EUR',
                                //     accountDetails: AccountDetails(
                                //         accountHolder: holder,
                                //         accountNumber: accountNumber,
                                //         iBAN: iBAN,
                                //         sortCode: sortCode)
                                //         ),
                              ),
                            );
                          },
                          child: Container(
                            height: 20.h,
                            width: 125.w,
                            decoration: BoxDecoration(
                              color: HexColor('2375A9'),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                                child: Text(
                              iBan ?? 'Un known',
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.euro,
                              color: Colors.white,
                              size: 30.sp,
                            ),
                            Text(
                              totalPalance ?? 'O',
                              style: TextStyle(
                                  fontSize: 30.sp, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [HexColor('0198D9'), HexColor('019BDC')])),
                  ),
                  Container(
                    height: 25.h,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [HexColor('0D4E85'), HexColor('038DCC')])),
                  ),
                  Container(
                    color: HexColor('#F1F2F6'),
                    width: screenWidth,
                    height: screenHeight,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            child: Image.asset(
                              'images/banner.png',
                              fit: BoxFit.fill,
                            )),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          height: 35.h,
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                                'اليوم',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 255.h,
                          child: ListView.separated(
                            padding: EdgeInsets.only(bottom: 20),
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key(listData[index].id.toString()),
                                direction: DismissDirection.horizontal,
                                onDismissed: (direction) async {
                                  await deleteItem(listData[index].id ?? 0);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainView()));
                                  Fluttertoast.showToast(
                                      msg: "Transaction is deleted",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                },
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              listData[index].sent == true
                                                  ? OutGoingTransInfo(
                                                      item: listData[index],
                                                    )
                                                  : InComingTransInfo(
                                                      item: listData[index],
                                                    ),
                                        ));
                                  },
                                  child: Container(
                                    height: 70.h,
                                    width: screenWidth,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: HexColor('ffffff'),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              index == 0 ? 10 : 0),
                                          topRight: Radius.circular(
                                              index == 0 ? 10 : 0),
                                          bottomLeft: Radius.circular(
                                              index == listData.length - 1
                                                  ? 10
                                                  : 0),
                                          bottomRight: Radius.circular(
                                              index == listData.length - 1
                                                  ? 10
                                                  : 0),
                                        )),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            listData[index].imagePath == null ||
                                                    listData[index].imagePath ==
                                                        ''
                                                ? CircleAvatar(
                                                    radius: 22.sp,
                                                    backgroundColor:
                                                        HexColor('73a5d2'),
                                                    child: Text(
                                                      getInitials(
                                                          listData[index]
                                                                  .userName ??
                                                              ''),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                : ClipOval(
                                                    child: Image.file(
                                                        fit: BoxFit.fill,
                                                        File(listData[index]
                                                                .imagePath ??
                                                            ''),
                                                        height: 42.h,
                                                        width: 42.w)),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Column(
                                              textDirection: TextDirection.rtl,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(listData[index].userName ??
                                                    ''),
                                                Row(
                                                  children: [
                                                    Text(
                                                         listData[index].sent==true?' Sent to ':  ' Envoye depuis ',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.sp),
                                                    ),
                                                    Text(
                                                      listData[index].bankName ??
                                                          '',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.sp),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Expanded(child: SizedBox()),
                                            Row(
                                              children: [
                                                listData[index].sent == true
                                                    ? Text(
                                                        '-',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20.sp),
                                                      )
                                                    : Text(
                                                        '+',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 20.sp),
                                                      ),
                                                Icon(
                                                  Icons.euro,
                                                  size: 18.sp,
                                                  color: listData[index].sent ==
                                                          true
                                                      ? Colors.red
                                                      : Colors.green,
                                                ),
                                                Text(
                                                  listData[index].ammount ?? '',
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color:
                                                        listData[index].sent ==
                                                                true
                                                            ? Colors.red
                                                            : Colors.green,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: HexColor('f4f4f4'),
                                height: 0,
                                // indent: 100.w,
                                endIndent: 70.w,
                                thickness: 1,
                              );
                            },
                            itemCount: listData.length,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

// Widget circlName() {
//   return Container(
//       padding: const EdgeInsets.all(8),
//       child: Stack(
//         children: [
//           image == null
//               ? CircleAvatar(
//                   backgroundColor: Colors.grey[200],
//                   child: Text(firstChar ?? ''))
//               : ClipOval(
//                   child: Image.file(
//                     image!,
//                     width: 120,
//                     height: 120,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//           Positioned(
//             top: 2,
//             right: 2,
//             child: Container(
//               width: 10,
//               height: 10,
//               decoration: BoxDecoration(
//                   color: Colors.red, borderRadius: BorderRadius.circular(25)),
//             ),
//           )
//         ],
//       ));
// }

// Widget radiusButton({required String? txt,IconData? icon,bool? diffColor=false,Color? color}) {
//   return Container(
//     // height: 40,
//     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//     decoration: BoxDecoration(
//       color: diffColor==false? mainColor:color,
//       borderRadius: BorderRadius.circular(25),
//     ),
//     child: Row(
//       children: [
//         icon != null ? Icon(icon,size: 15,):const SizedBox(),
//         const SizedBox(width: 5,),
//         Text(txt ?? '',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
//       ],
//     ),
//   );
// }

// Widget transactionsItem(BuildContext context,
//     {bool? home = true,
//     required int accountType,
//     required String? userName,
//     required bool? sent,
//     required String? mony,
//     required int? id,
//     required DateTime? time,
//     required int? ref,
//     required String? bankCode,
//     required String? iBAN
//     }) {
//   //? Transactions Section
//   return GestureDetector(
//     onTap: ()async {
//       String? iBan = await CacheHelper.getStringFromCache(key: accountType==1 ? 'EUR_IBAN':accountType==2?'USD_IBAN':'GBP_IBAN');
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TransDetails(
//               iBan: iBan,
//                 data: DetailsData(
//                   accountType: accountType,
//                     userName: userName,
//                     sent: sent,
//                     ammount: mony,
//                     id: id,
//                     time: time,
//                     reference: ref,
//                     bankCode: bankCode,
//                     iBan: iBAN
//                     )),
//           ));
//     },
//     child: Dismissible(
//       direction: DismissDirection.horizontal,
//       onDismissed: (direction) async {
//         await deleteItem(id ?? 0);
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => MainView()));
//         Fluttertoast.showToast(
//             msg: "Transaction is deleted",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0);
//       },
//       key: Key(id.toString()),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           CircleAvatar(
//             radius: home == true ? 25 : 35,
//             backgroundColor: Colors.grey[200],
//             child:
//                 Icon(sent == true ? Icons.arrow_upward : Icons.arrow_downward),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 userName ?? '',
//                 style: TextStyle(
//                     fontSize: home == true ? 13 : 15,
//                     fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 sent == true ? 'Sent' : 'Recived',
//                 textAlign: TextAlign.start,
//                 style: const TextStyle(color: Colors.grey),
//               )
//             ],
//           ),
//           const Expanded(child: SizedBox()),
//           Text(
//             '${sent == true?'-':'+'}  $mony ${accountType==1 ? 'EUR' : accountType ==2? 'USD' : 'GPB'}',
//             style: const TextStyle(fontWeight: FontWeight.w600),
//           )
//         ],
//       ),
//     ),
//   );
// }

// Future<void> getAllLocalTrans() async {
//   persons = await Hive.openBox('trans');
//   var keys = persons?.keys;
//   listData.clear();
//   keys?.forEach((element) {
//     debugPrint('item key : $element');
//     var i = persons?.get(element);
//     if (i != null) {
//       listData.add(i);
//     }
//   });

//   debugPrint('listt : $listData');
// }

// addItemToLocal(DetailsData item) async {
//   persons = await Hive.openBox('trans');
//   persons?.add(item);
// }

// deleteItem(int id) async {
//   persons = await Hive.openBox('trans');

//   final Map<dynamic, DetailsData> deliveriesMap = persons!.toMap();
//   dynamic desiredKey;
//   deliveriesMap.forEach((key, value) {
//     if (value.id == id) {
//       desiredKey = key;
//     }
//   });
//   persons?.delete(desiredKey);
// }

String getInitials(String userName) => userName.isNotEmpty
    ? userName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';
