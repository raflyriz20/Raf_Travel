import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/common/theme_helper.dart';
import 'package:flutter_travel_ui/screens/login_screen.dart';
import 'package:flutter_travel_ui/services/methods.dart';
import 'package:flutter_travel_ui/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationScreenState();
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  bool _isLoading = false;

  /* textbox */
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void setNull() {
    setState(() {
      _fullname.text = '';
      _username.text = '';
      _address.text = '';
      _email.text = '';
      _phoneNumber.text = '';
      _password.text = '';
    });
  }

  showDialogWrong(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Oke"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Pesan"),
      content: Text("Beberapa Salah / Tidak Valid !"),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDialogEmpty(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Oke"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Pesan"),
      content: Text("Data Tidak Boleh Kosong !"),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    child: HeaderWidget(
                        150, false, Icons.person_add_alt_1_rounded),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              GestureDetector(
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 5, color: Colors.white),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 20,
                                            offset: const Offset(5, 5),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey.shade300,
                                        size: 80.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                child: TextFormField(
                                  controller: _fullname,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Full Name', 'Enter your Name'),
                                  keyboardType: TextInputType.name,
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                  controller: _username,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Username', 'Enter your Username'),
                                  validator: (val) {
                                    if (!(val.isNotEmpty) &&
                                        !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                            .hasMatch(val)) {
                                      return "Enter a valid Username";
                                    }
                                    return null;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: TextFormField(
                                  controller: _address,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Alamat', 'Enter your Alamat'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                  controller: _email,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "E-mail", "Enter your email"),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                  controller: _phoneNumber,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Mobile Number",
                                      "Enter your mobile number"),
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    if (!(val.isNotEmpty) &&
                                        !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                      return "Enter a valid phone number";
                                    }
                                    return null;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                  controller: _password,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Password*", "Enter your password"),
                                  validator: (val) {
                                    if (!(val.isNotEmpty) &&
                                        !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                            .hasMatch(val)) {
                                      return "Enter a valid Password";
                                    }
                                    return null;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              FormField<bool>(
                                builder: (state) {
                                  return Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Checkbox(
                                              value: checkboxValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  checkboxValue = value;
                                                  state.didChange(value);
                                                });
                                              }),
                                          Text(
                                            "I accept all terms and conditions.",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          state.errorText ?? '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Theme.of(context).errorColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                validator: (value) {
                                  if (!checkboxValue) {
                                    return 'You need to accept terms and conditions';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      "Register".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_fullname.text.isNotEmpty &&
                                        _username.text.isNotEmpty &&
                                        _address.text.isNotEmpty &&
                                        _email.text.isNotEmpty &&
                                        _phoneNumber.text.isNotEmpty &&
                                        _password.text.isNotEmpty) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      createAccount(
                                              _fullname.text,
                                              _username.text,
                                              _address.text,
                                              _email.text,
                                              _phoneNumber.text,
                                              _password.text)
                                          .then((user) async {
                                        User user =
                                            FirebaseAuth.instance.currentUser;
                                        if (user != null) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          print("Pesan : Berhasil Register");
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .set(({
                                                'uid': user.uid,
                                                'fullname': _fullname.text,
                                                'username': _username.text,
                                                'address': _address.text,
                                                'email': _email.text,
                                                'phone': _phoneNumber.text,
                                                'password': _password.text,
                                                'about':
                                                    'Saya Suka Berpetualang',
                                              }));
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              LoginScreen()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        } else {
                                          print("Pesan : Gagal Register");
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          showDialogWrong(context);
                                        }
                                      });
                                    } else {
                                      print("Pesan : Kolom Tidak Boleh Kosong");
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      showDialogEmpty(context);
                                    }
                                    /* if (_formKey.currentState.validate()) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                          (Route<dynamic> route) => false);
                                    } */
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
