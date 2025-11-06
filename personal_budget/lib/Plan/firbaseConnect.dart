import 'package:firebase_database/firebase_database.dart';
class FirbaseConnect {
  final DatabaseReference _planRef=FirebaseDatabase.instance.ref('planData');
  final DatabaseReference _paymentRef=FirebaseDatabase.instance.ref('debtPay');
  Future<void> addPlanData(Map<String,dynamic> planData)async{
    await _planRef.push().set(planData);
  }
  Future<void> debtPayment(Map<String,dynamic> payment) async{
    await _paymentRef.push().set(payment);
  }
}