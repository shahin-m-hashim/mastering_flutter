import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/admin_model.dart';

class DBHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(AdminModel user) async {
    try {
      await _firestore.collection('Admins').doc(user.uid).set({
        'name': user.name,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
      });
    } catch (e) {
      print('Error adding user to Firestore: $e');
      rethrow;
    }
  }
}
