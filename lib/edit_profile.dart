import 'dart:ffi';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:paysera/cash_helper.dart';
import 'package:paysera/main.dart';
import 'package:paysera/main_view.dart';
import 'package:paysera/trans.dart';
import 'package:paysera/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
    ? bankAccountName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';
String? userName = 'AS';
String? firstChar = getInitials(userName ?? '');
String? totalPalance;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool? sent = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          image == null
                              ? CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey[200],
                                  child: Text(
                                    firstChar == null || firstChar!.isEmpty
                                        ? ''
                                        : firstChar ?? '',
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                )
                              : ClipOval(
                                  child: Image.file(
                                      fit: BoxFit.fill,
                                      image!,
                                      height: 100,
                                      width: 100)),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () async {
                        await getImageFromFiles();
                        setState(() {});
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainView(),
                            ));
                      },
                      child: const Text('Change')),
                  const SizedBox(
                    height: 30,
                  ),
                  
                  
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(
                        child: const Text('Add Transaction'),
                        onPressed: () {
                          TextEditingController toController =
                              TextEditingController();
                          TextEditingController idController =
                              TextEditingController();
                          TextEditingController amountController =
                              TextEditingController();
                          TextEditingController BankNameController =
                              TextEditingController();
                          TextEditingController timeController =
                              TextEditingController();

                          TextEditingController iBanCodeController =
                              TextEditingController();

                          TextEditingController imagePathController =
                              TextEditingController();
                          String? pathImage;
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) => SingleChildScrollView(
                                    child: AlertDialog(
                                      content: SizedBox(
                                        width: 500,
                                        // height: 500,
                                        child: Column(
                                          children: [
                                            AppTextField(
                                                controller: idController,
                                                keyboardType:
                                                    TextInputType.number,
                                                icon: const Icon(Icons.abc),
                                                hintText: 'required id',
                                                label: 'required id'),
                                                const SizedBox(
                                              height: 10,
                                            ),
                                            AppTextField(
                                                controller: BankNameController,
                                                keyboardType:
                                                    TextInputType.text,
                                                icon: const Icon(Icons.abc),
                                                hintText: 'bank name',
                                                label: 'bank name'),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppTextField(
                                                controller: toController,
                                                keyboardType:
                                                    TextInputType.text,
                                                icon: const Icon(Icons.abc),
                                                hintText: 'To',
                                                label: 'To'),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppTextField(
                                                controller: amountController,
                                                keyboardType:
                                                    TextInputType.number,
                                                icon: const Icon(Icons.abc),
                                                hintText: 'amount',
                                                label: 'amount'),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppTextField(
                                                onTap: () {
                                                  debugPrint('Pick Time');
                                                  DatePicker.showDateTimePicker(
                                                      context,
                                                      showTitleActions: true,
                                                      
                                                      minTime:
                                                          DateTime(2011, 3, 5),
                                                      maxTime: DateTime.now(),
                                                      onChanged: (date) {
                                                    String formattedDate =
                                                        DateFormat(
                                                                'yyyy-MM-dd kk:mm')
                                                            .format(date);
                                                    debugPrint('date : $date');
                                                    timeController.text =
                                                        formattedDate;
                                                  }, onConfirm: (date) {
                                                    String formattedDate =
                                                        DateFormat(
                                                                'yyyy-MM-dd kk:mm')
                                                            .format(date);
                                                    debugPrint('date : $date');
                                                    timeController.text =
                                                        formattedDate;
                                                  },
                                                      currentTime:
                                                          DateTime.now(),
                                                      locale: LocaleType.en);
                                                },
                                                readOnly: true,
                                                controller: timeController,
                                                keyboardType:
                                                    TextInputType.text,
                                                icon: const Icon(Icons.abc),
                                                hintText: 'time',
                                                label: 'time'),
                                            const SizedBox(
                                              height: 10,
                                            ),

                                            AppTextField(
                                                controller: iBanCodeController,
                                                keyboardType:
                                                    TextInputType.text,
                                                icon: const Icon(Icons.abc),
                                                hintText: 'IBAN',
                                                label: 'IBAN'),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            AppTextField(
                                                controller: imagePathController,
                                                onTap: () async {
                                                  PickedFile? pickedFile =
                                                      await ImagePicker()
                                                          .getImage(
                                                    source: ImageSource.gallery,
                                                  );
                                                  if (pickedFile != null) {
                                                    pathImage = pickedFile.path;
                                                    debugPrint(
                                                        'imagePath : $pathImage');
                                                    image = File(pathImage!);
                                                    imagePathController.text = pathImage??'';
                                                  } else {
                                                    print('No image selected');
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.text,
                                                icon: const Icon(Icons.abc),
                                                hintText: 'Image',
                                                label: 'Image'),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            StatefulBuilder(
                                    builder: (context, setState) => Row(
                                      children: [
                                        const Text('Sent'),
                                        Checkbox(
                                          checkColor: Colors.white,
                                          // fillColor: MaterialStateProperty.resolveWith(getColor),
                                          value: sent,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              sent = value!;
                                              debugPrint('value $value');
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text('Send'),
                                          onPressed: () async {
                                            await addItemToLocal(DetailsData(
                                              id: int.parse(idController.text),
                                                ammount: amountController.text,
                                                sent: sent,
                                                userName: toController.text,
                                                bankName:
                                                    BankNameController.text,
                                                time: DateTime.parse(
                                                    timeController.text),
                                                imagePath:
                                                    imagePathController.text,
                                                iBan: iBanCodeController.text));

                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MainView(),
                                                ));
                                            Fluttertoast.showToast(
                                                msg: "Transaction is Added",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ));
                        })
                  ]),
                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Edit Total Balance'),
                        Icon(Icons.attach_money)
                      ],
                    ),
                    onPressed: () {
                      TextEditingController balanceController =
                          TextEditingController(text: totalPalance ?? '');

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: SizedBox(
                            width: 500,
                            height: 150,
                            child: Column(
                              children: [
                                AppTextField(
                                    controller: balanceController,
                                    keyboardType: TextInputType.number,
                                    icon: const Icon(Icons.abc),
                                    hintText: 'Balance',
                                    label: 'Balance'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Edit'),
                              onPressed: () async {
                                if (balanceController.text.isNotEmpty) {
                                  // Obtain shared preferences.
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'totalPalance', balanceController.text);
                                  // totalPalance = balanceController.text;
                                  setState(() {});
                                  showMessage(msg: 'Sucsess', sucsess: true);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MainView(),
                                      ));
                                } else {
                                  showMessage(
                                      msg: 'No value added', sucsess: false);
                                }
                              },
                            ),
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          title: const Text('Edit Balance'),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: const Text('Add Account Information'),
                        onPressed: () {
                          TextEditingController nameController =
                              TextEditingController(text: accountName ?? '');
                          TextEditingController iBAN =
                              TextEditingController(text: iBan ?? '');
                          TextEditingController bankNamec =
                              TextEditingController(text: bankName ?? '');
                          TextEditingController bankAddressc =
                              TextEditingController(text: bankAddress ?? '');
                          TextEditingController swift_bicc =
                              TextEditingController(text: swift_bic ?? '');
                          TextEditingController bankOutGoingName =
                              TextEditingController(text: bank_out_name ?? '');
                          TextEditingController bankOutgoingAddress =
                              TextEditingController(
                                  text: bank_out_address ?? '');
                          TextEditingController bankOutgoingSwift =
                              TextEditingController(text: bank_out_swift ?? '');

                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) => SingleChildScrollView(
                              child: AlertDialog(
                                content: SizedBox(
                                  width: 500,
                                  height: 600,
                                  child: Column(
                                    children: [
                                      AppTextField(
                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          icon: const Icon(Icons.abc),
                                          hintText: 'Account name',
                                          label: 'Account name'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppTextField(
                                          controller: iBAN,
                                          keyboardType: TextInputType.text,
                                          icon: const Icon(Icons.abc),
                                          hintText: 'IBAN',
                                          label: 'IBAN'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppTextField(
                                          controller: bankNamec,
                                          keyboardType: TextInputType.text,
                                          icon: const Icon(Icons.abc),
                                          hintText: 'Bank name',
                                          label: 'Bank name'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppTextField(
                                          controller: bankAddressc,
                                          keyboardType: TextInputType.text,
                                          icon: const Icon(Icons.abc),
                                          hintText: 'Bank Address',
                                          label: 'Bank Address'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppTextField(
                                          controller: swift_bicc,
                                          keyboardType: TextInputType.text,
                                          icon: const Icon(Icons.abc),
                                          hintText: 'SWIFT/BIC',
                                          label: 'SWIFT/BIC'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppTextField(
                                          controller: bankOutGoingName,
                                          keyboardType: TextInputType.text,
                                          icon: const Icon(Icons.abc),
                                          hintText: 'Bank Out Name ',
                                          label: 'Bank Out NAme '),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppTextField(
                                          controller: bankOutgoingAddress,
                                          keyboardType: TextInputType.text,
                                          icon: const Icon(Icons.abc),
                                          hintText: 'Bank Out Address ',
                                          label: 'Bank Out Address '),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppTextField(
                                          controller: bankOutgoingSwift,
                                          keyboardType: TextInputType.text,
                                          icon: const Icon(Icons.abc),
                                          hintText: 'Bank Out swift',
                                          label: 'Bank Out swift'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      child: const Text('Send'),
                                      onPressed: () async {
                                        CacheHelper.addStringToCache(
                                            key: 'account_name',
                                            value: nameController.text);
                                        CacheHelper.addStringToCache(
                                            key: 'iban', value: iBAN.text);
                                        CacheHelper.addStringToCache(
                                            key: 'bank_name',
                                            value: bankNamec.text);
                                        CacheHelper.addStringToCache(
                                            key: 'bank_address',
                                            value: bankAddressc.text);

                                        CacheHelper.addStringToCache(
                                            key: 'swift_bic',
                                            value: swift_bicc.text);

                                        CacheHelper.addStringToCache(
                                            key: 'bank_out_name',
                                            value: bankOutGoingName.text);

                                        CacheHelper.addStringToCache(
                                            key: 'bank_out_address',
                                            value: bankOutgoingAddress.text);

                                        CacheHelper.addStringToCache(
                                            key: 'bank_out_swift',
                                            value: bankOutgoingSwift.text);

                                        Fluttertoast.showToast(
                                            msg: "Account is Updated",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainView(),
                                            ));
                                      }),
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                                title: const Text('Account Information'),
                              ),
                            ),
                          );
                        },
                      ),
                      Icon(Icons.send)
                    ],
                  ),
                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('E-mail'),
                        Icon(Icons.attach_money)
                      ],
                    ),
                    onPressed: () {
                      TextEditingController mailControllerc =
                          TextEditingController(text: mail ?? '');

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: SizedBox(
                            width: 500,
                            height: 150,
                            child: Column(
                              children: [
                                AppTextField(
                                    controller: mailControllerc,
                                    keyboardType: TextInputType.emailAddress,
                                    icon: const Icon(Icons.abc),
                                    hintText: 'mail',
                                    label: 'mail'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Edit'),
                              onPressed: () async {
                                if (mailControllerc.text.isNotEmpty) {
                                  // Obtain shared preferences.
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'mail', mailControllerc.text);
                                  // totalPalance = balanceController.text;
                                  setState(() {});
                                  showMessage(msg: 'Sucsess', sucsess: true);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MainView(),
                                      ));
                                } else {
                                  showMessage(
                                      msg: 'No value added', sucsess: false);
                                }
                              },
                            ),
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          title: const Text('Edit Balance'),
                        ),
                      );
                    },
                  ),
                ]))));
  }
}
