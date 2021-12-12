import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/common/theme_helper.dart';
import 'package:flutter_travel_ui/screens/navbar.dart';
import 'package:flutter_travel_ui/screens/registration_screen.dart';
import 'package:flutter_travel_ui/services/methods.dart';
import 'package:flutter_travel_ui/widgets/header_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  bool _isLoading = false;

  /* textbox */
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  showDialogWrong(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Oke"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Pesan"),
      content: Text("Email atau Password anda salah !"),
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
      content: Text("Email atau Password tidak boleh kosong !"),
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
              child: Column(
                children: [
                  Container(
                    height: _headerHeight,
                    child: HeaderWidget(
                        _headerHeight,
                        true,
                        Icons
                            .login_rounded), //let's create a common header widget
                  ),
                  SafeArea(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        margin: EdgeInsets.fromLTRB(
                            20, 10, 20, 10), // This will be the login form
                        child: Column(
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Masukkan username dan password',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 30.0),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      child: TextFormField(
                                        controller: _email,
                                        decoration: ThemeHelper()
                                            .textInputDecoration(
                                                "E-mail", "Enter your email"),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 20.0),
                                    Container(
                                      child: TextFormField(
                                        controller: _password,
                                        obscureText: true,
                                        decoration: ThemeHelper()
                                            .textInputDecoration("Password",
                                                "Enter your Password"),
                                        validator: (val) {
                                          if (!(val.isNotEmpty) &&
                                              !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                  .hasMatch(val)) {
                                            return "Enter a valid Password";
                                          }
                                          return null;
                                        },
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 15.0),
                                    FormField<bool>(
                                        builder: (state) {
                                          return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  state.errorText ?? '',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .errorColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                        // ignore: missing_return
                                        validator: (value) {}),
                                    SizedBox(height: 50.0),
                                    Container(
                                      decoration: ThemeHelper()
                                          .buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              40, 10, 40, 10),
                                          child: Text(
                                            'LOGIN'.toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_email.text.isNotEmpty &&
                                              _password.text.isNotEmpty) {
                                            setState(() {
                                              _isLoading = true;
                                            });

                                            login(_email.text, _password.text)
                                                .then((user) {
                                              if (user != null) {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                print("Pesan : Berhasil Login");
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    navbar()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              } else {
                                                print("Pesan : Gagal Login");
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                showDialogWrong(context);
                                              }
                                            });
                                          } else {
                                            print(
                                                "Pesan : Kolom Tidak Boleh Kosong");
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            showDialogEmpty(context);
                                          }
                                          /* if (_formKey.currentState
                                              .validate()) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            navbar()),
                                                    (Route<dynamic> route) =>
                                                        false);
                                          } */
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(10, 20, 10, 20),
                                      //child: Text('Don\'t have an account? Create'),
                                      child: Text.rich(TextSpan(children: [
                                        TextSpan(
                                            text: "Don\'t have an account? "),
                                        TextSpan(
                                          text: 'Create',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegistrationScreen()));
                                            },
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ])),
                                    ),
                                  ],
                                )),
                          ],
                        )),
                  ),
                ],
              ),
            ),
    );
  }
}
