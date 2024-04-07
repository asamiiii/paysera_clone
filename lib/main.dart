import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paysera/cash_helper.dart';
import 'package:paysera/main_view.dart';
import 'package:paysera/trans.dart';
import 'package:paysera/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

FToast? fToast;
HexColor mainColor = HexColor('#87EA5C');
Box<DetailsData>? persons;

String? accountName;
String? iBan;
String? bankName;
String? bankAddress;
String? swift_bic;
String? bank_out_name;
String? bank_out_address;
String? bank_out_swift;

String? mail;
void main() async {
  image = null;
  imagePath = null;
// WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DetailsDataAdapter());
  persons = await Hive.openBox('trans');
  //  debugPrint('dummyData : $dummyData ');
  //  for (var element in dummyData) {
  //   persons?.add(element);
  //  }
  // getAllLocalTrans();
  // persons?.clear();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    fToast?.init(context);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Paysera',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'), // English
            const Locale('ar'), // Arabic
            // Add more locales if needed
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkFirstSeen();
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
    });

    super.initState();
  }

  Future<void> checkFirstSeen() async {
    bool? isAuth = false;
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => SizedBox(
            height: 250.h,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Paysera',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Use your fingerprint to continue',
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Unlock to login',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {
                    setState(() {});
                    isAuth = true;
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.pop(context); // Close the modal sheet
                    openMainView(); // Open the main view
                  },
                  child: isAuth == false
                      ? Image.asset(
                          'images/fp.png',
                          width: 50.w,
                          height: 50.h,
                        )
                      : Image.asset(
                          'images/check.png',
                          width: 50.w,
                          height: 50.h,
                        ),
                ),
                const Expanded(child: SizedBox()),
                const Text('Touch the fingerprint sensor'),
                Row(
                  children: [
                    TextButton(onPressed: () {}, child: const Text('Use PIN')),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void openMainView() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#0885C5'),
      body: Center(
          child: Image.asset('images/logo.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill)),
    );
  }
}

showMessage({String? msg, bool? sucsess}) {
  Fluttertoast.showToast(
      msg: msg ?? '',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: sucsess == true ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

List<DetailsData> listData = [];

Future<void> getAllLocalTrans() async {
  persons = await Hive.openBox('trans');
  var keys = persons?.keys;
  listData.clear();
  keys?.forEach((element) {
    debugPrint('item key : $element');
    var i = persons?.get(element);
    if (i != null) {
      listData.add(i);
    }
  });

  debugPrint('listt : $listData');
}

addItemToLocal(DetailsData item) async {
  persons = await Hive.openBox('trans');
  persons?.add(item);
}

deleteItem(int id) async {
  persons = await Hive.openBox('trans');

  final Map<dynamic, DetailsData> deliveriesMap = persons!.toMap();
  dynamic desiredKey;
  deliveriesMap.forEach((key, value) {
    if (value.id == id) {
      desiredKey = key;
    }
  });
  persons?.delete(desiredKey);
}
