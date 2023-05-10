// ignore_for_file: use_build_context_synchronously

import 'package:bahanku/api/user_service.dart';
import 'package:bahanku/models/api_response.dart';
import 'package:bahanku/models/user/user.dart';
import 'package:bahanku/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: txtEmail,
                validator: (val) => val!.length < 8 ? 'Invalid email' : null,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                controller: txtPassword,
                validator: (val) =>
                    val!.length < 8 ? 'Required at least 8 chars' : null,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Forgot password',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                  ),
                  Text(
                    'Not me',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : InkWell(
                      child: Container(
                        width: 400,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        logout().then(
                          (value) => {
                            if (formkey.currentState!.validate())
                              {
                                setState(() {
                                  loading = true;
                                  _loginUser();
                                })
                              }
                          },
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
