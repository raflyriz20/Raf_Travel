import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/screens/login_screen.dart';

Future<User> createAccount(String fullname, String username, String address,
    String email, String phone, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Pesan : Berhasil Membuat Akun");
      return user;
    } else {
      print("Pesan : Gagal Membuat Akun [Tidak Boleh Kosong]");
      return user;
    }
  } catch (e) {
    print("Error : ${e}");
    return null;
  }
}

Future<User> updateAccount(String email, String password) async {
  try {
    User user = await FirebaseAuth.instance.currentUser;
    user.updateEmail(email);
    user.updatePassword(password);
    if (user != null) {
      print("Pesan : Berhasil Update Akun");
      return user;
    } else {
      print("Pesan : Gagal Update Akun [Tidak Boleh Kosong]");
      return user;
    }
  } catch (e) {
    print("Error : ${e}");
    return null;
  }
}

Future<User> login(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    User user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Pesan : Berhasil Login");
      return user;
    } else {
      print("Pesan : Gagal Login [Tidak Boleh Kosong]");
      return user;
    }
  } catch (e) {
    print("Error : ${e}");
    return null;
  }
}

Future logout(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await _auth.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
          (Route<dynamic> route) => false);
    });
  } catch (e) {
    print("Error : ${e}");
    return null;
  }
}
