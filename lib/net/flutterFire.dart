import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(
        email: email,
        password: password
      );
      print("User found!!");
  return true;
  } on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
  return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
  await FirebaseAuth.instance
    .createUserWithEmailAndPassword(
      email: email,
      password: password
    );
    return true;
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
  return false;
} catch (e) {
  print(e);
  return false;
}
}

Future<bool> addCoin(String id, String amount) async{
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    double _amount = double.parse(amount);
    DocumentReference _ref = FirebaseFirestore
      .instance
      .collection('Users')
      .doc(uid)
      .collection('Coins')
      .doc(id);

    FirebaseFirestore.instance.runTransaction((transaction) async{
       DocumentSnapshot snapshot = await transaction.get(_ref);
       if (!snapshot.exists) {
         _ref.set({
           'Amount' : _amount
         });
         return true;
       } 

       double newAmount = snapshot.data()['Amount'] + _amount;
       transaction.update(_ref, {'Amount' : newAmount});

    });
    return true;
  } catch (e) {
    return false;
  }
}