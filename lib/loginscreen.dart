import 'package:app/home.dart';
import 'package:app/widget/genLoginSignupHeader.dart';
import 'package:app/widget/getTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  // final _formKey = new GlobalKey<FormState>();
  final _conUsernm = TextEditingController();
  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;

  @override
  // void initState() {
  //   super.initState();
  //   dbHelper = DbHelper();
  // }

  login() async {
    String uid = _conUserId.text;
    // String uname = _conUsernm.text;
    String passwd = _conPassword.text;

    if (uid.isEmpty) {
      AlertDialog(
        title: Text(
          "Please Enter User ID",
        ),
      );
      // alertDialog(context, "Please Enter User ID");
    } else if (passwd.isEmpty) {
      AlertDialog(
        title: Text(
          "Please Enter Password",
        ),
      );
      // alertDialog(context, "Please Enter Password");
    } else {
      await dbHelper.getLoginUser(uid, passwd).then((userData) {
        if (userData != null) {
          (userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => Home()),
                (Route<dynamic> route) => true);
          });
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LoginForm(),
              ));
        }
      }).catchError((error) {
        print(error);
        AlertDialog(
          title: Text(
            "Login Fail",
          ),
        );
        // alertDialog(context, "Error: Login Fail");
      });
    }
  }

  // Future setSP(UserModel user) async {
  //   final SharedPreferences sp = await _pref;

  //   sp.setString("user_id", user.user_id!);
  //   sp.setString("user_name", user.user_name!);
  //   sp.setString("password", user.password!);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                genLoginSignupHeader('Login'),
                SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                        'assets/images/app.png') // Replace with your logo asset
                    ),
                getTextFormField(
                    controller: _conUserId,
                    icon: Icons.person,
                    hintName: 'User ID'),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                ),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[400],
                      minimumSize: Size(
                        10,
                        50,
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Home()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
