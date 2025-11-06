import 'package:firebase_database/firebase_database.dart';
class Service {
  //adding data to the database
       final DatabaseReference databaseRef=FirebaseDatabase.instance.ref("expenditure");
Future<void> addIncomeData(Map<String,dynamic> data) async{
  await databaseRef.push().set(data);
}
//getting real time data form firebase
Stream<DatabaseEvent> getIncomeData(){
  return databaseRef.onValue;
}
}