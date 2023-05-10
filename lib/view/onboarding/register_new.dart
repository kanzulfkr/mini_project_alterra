// ignore_for_file: use_build_context_synchronously

import 'package:bahanku/api/user_service.dart';
import 'package:bahanku/models/api_response.dart';
import 'package:bahanku/models/user/user.dart';
import 'package:bahanku/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      passwordConfirmController = TextEditingController();

  void _registerUser() async {
    ApiResponse response = await register(
        nameController.text, emailController.text, passwordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  // Save and redirect to home
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
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                "Let's create here!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: nameController,
                validator: (val) => val!.isEmpty ? 'Invalid name' : null,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                validator: (val) =>
                    val!.length < 8 ? 'Invalid email adress' : null,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                validator: (val) =>
                    val!.length < 8 ? 'Required at least 8 chars' : null,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                controller: passwordConfirmController,
                validator: (val) => val != passwordController.text
                    ? 'Confirm password does not match'
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const SizedBox(height: 30),
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
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            loading = !loading;
                            _registerUser();
                          });
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
