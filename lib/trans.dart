import 'package:hive/hive.dart';
part 'trans.g.dart';
@HiveType(typeId: 1)
class DetailsData extends HiveObject{
  @HiveField(0)
  String? bankName;
  @HiveField(1)
  String? userName;
  @HiveField(2)
  String? ammount;
  @HiveField(3)
  bool? sent;
  @HiveField(4)
  DateTime? time;
  @HiveField(5)
  String? imagePath;
  @HiveField(6)
  String? iBan;
  @HiveField(7)
  String? id;


  DetailsData({this.id,this.bankName,this.userName,this.ammount,this.sent,this.time,this.imagePath,this.iBan});
}



List<DetailsData> dummyData = [

  // DetailsData(
  //     id: 123456,
  //     userName: 'Ahmed Sami',
  //     sent: true,
  //     ammount: '100.0',
  //     time: DateTime.parse('2023-12-11 01:15:00.000')),

  // DetailsData(
  //     userName: 'Mohammed Badrawy',
  //     sent: false,
  //     ammount: '9.0',
  //     id: 654321,
  //     time: DateTime.parse('2023-12-13 05:30:00.000')),

  // DetailsData(
  //     userName: 'Amr Ahmed',
  //     sent: true,
  //     ammount: '1.0',
  //     id: 123456,
  //     time: DateTime.parse('2023-12-14 07:40:00.000')),

  // DetailsData(
  //     userName: 'Ahmed Sami',
  //     sent: true,
  //     ammount: '98.0',
  //     id: 123456,
  //     time: DateTime.parse('2023-12-11 08:15:00.000')),

];