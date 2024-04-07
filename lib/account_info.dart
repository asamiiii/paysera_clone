import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:paysera/main.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // padding: EdgeInsets.all(10),
                height: 5.h,
                width: 30.w,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(25)),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/ic_share_details.png',
                  height: 20.h,
                  width: 20.w,
                ),
                SizedBox(width: 7,),
                Text(
                  'مشاركة',
                  style: TextStyle(color: HexColor('019CDE')),
                ),
                Expanded(child: SizedBox()),
                Text('تفاصيل الحساب')
              ],
            ),
          ),
          Container(
            height: 420.h,
            width: screenWidth,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('المستلم',style: TextStyle(color: Colors.grey,fontSize: 10),),
                        Text(accountName ?? 'Un Known',style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset('images/ic_copy.png',height: 20.h,width: 20.w,)
                  ],
                ),
SizedBox(height: 12.h,),
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('رقم الحساب الدولي الخاص بك',style: TextStyle(color: Colors.grey,fontSize: 10),),
                        Text(iBan?? 'Un Known',style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset('images/ic_copy.png',height: 20.h,width: 20.w,)
                  ],
                ),
SizedBox(height: 12.h,),
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('اسم البنك',style: TextStyle(color: Colors.grey,fontSize: 10),),
                        Text(bankName?? 'Un Known',style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset('images/ic_copy.png',height: 20.h,width: 20.w,)
                  ],
                ),
SizedBox(height: 12.h,),

                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('عنوان البنك',style: TextStyle(color: Colors.grey,fontSize: 10),),
                        Text(bankAddress?? 'Un Known',style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset('images/ic_copy.png',height: 20.h,width: 20.w,)
                  ],
                ),

SizedBox(height: 12.h,),
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('SWIFT/BIC',style: TextStyle(color: Colors.grey,fontSize: 10),),
                        Text(swift_bic?? 'Un Known',style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset('images/ic_copy.png',height: 20.h,width: 20.w,)
                  ],
                ),

SizedBox(height: 12.h,),
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('اسم البنك المراسل',style: TextStyle(color: Colors.grey,fontSize: 10),),
                        Text(bank_out_name?? 'Un Known',style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset('images/ic_copy.png',height: 20.h,width: 20.w,)
                  ],
                ),
SizedBox(height: 12.h,),
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('عنوان البنك المراسل',style: TextStyle(color: Colors.grey,fontSize: 10),),
                        Text(bank_out_address?? 'Un Known',style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset('images/ic_copy.png',height: 20.h,width: 20.w,)
                  ],
                ),

                SizedBox(height: 12.h,),
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('سويفت كود الخاص بالبنك المراسل',style: TextStyle(color: Colors.grey,fontSize: 10),),
                        Text(bank_out_swift?? 'Un Known',style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset('images/ic_copy.png',height: 20.h,width: 20.w,)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
