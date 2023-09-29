import 'package:app/home.dart';
import 'package:flutter/material.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  @override
  bool _obscureText = true;
  bool _obscureText2 = true;

  var passwordController = TextEditingController();
  var newPasswordController = TextEditingController();

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void showSuccessMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // void onChangePassword() async {
  //   final username = 'user';
  //   final passwordSaatIni = passwordController.text;
  //   final newPassword = newPasswordController.text;

  //   final dbHelper = DatabaseHelper();

  //   final existingUser = await dbHelper.getUserByUsername(username);
  //   if (existingUser == null || existingUser.password != passwordSaatIni) {
  //     showErrorMessage('Password saat ini tidak benar');
  //     return;
  //   }

  //   final updatedUser = Users(
  //     id: existingUser.id,
  //     username: existingUser.username,
  //     password: newPassword,
  //   );

  //   final rowsAffected = await dbHelper.updateUserPassword(updatedUser);
  //   if (rowsAffected > 0) {
  //     showSuccessMessage('Password berhasil diperbarui');
  //   } else {
  //     showErrorMessage('Gagal memperbarui password');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.settings_applications),
          leadingWidth: 100,
          backgroundColor: Colors.blue,
          title: const Text("Pengaturan"),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // Password Old
              Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.password_outlined),
                    labelText: 'Password Old',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              // Password New
              Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: newPasswordController,
                  obscureText: _obscureText2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.password),
                    labelText: 'Password New',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _obscureText2 = !_obscureText2;
                    });
                  },
                ),
              ),
              // tombol save
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        minWidth: double.maxFinite, // set minWidth to maxFinite
                        color: Colors.green,
                        onPressed: () {
                          // onChangePassword();
                        },
                        child: Text("SAVE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.8))),
                      ),
                    ),
                  ],
                ),
              ),
              // tombol kembali
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        minWidth: double.maxFinite, // set minWidth to maxFinite
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        },
                        child: Text("BACK",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.8))),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 165,
                    width: 165,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF3E616B), width: 2.0),
                        borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/fotoLisa.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About This App',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2B4856)),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Aplikasi ini dibuat oleh:',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2B4856)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Nama: Elizabeth Resi A',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2B4856)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'NIM: 2141764053',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2B4856)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Tanggal: 25 September 2023',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2B4856)),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
