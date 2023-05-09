import 'dart:io';

import 'package:bahanku/api/constant.dart';
import 'package:bahanku/models/api_response.dart';
import 'package:bahanku/models/user.dart';
import 'package:bahanku/services/user_service.dart';
import 'package:bahanku/view/login/login.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User? user;
  bool loading = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _imageFile;
  final _picker = ImagePicker();
  TextEditingController txtNameController = TextEditingController();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // get user detail
  void getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        loading = false;
        txtNameController.text = user!.name ?? '';
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  //update profile
  void updateProfile() async {
    ApiResponse response =
        await updateUser(txtNameController.text, getStringImage(_imageFile));
    setState(() {
      loading = false;
    });
    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.data}'),
        ),
      );
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    radius: 95,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        image: _imageFile == null
                            ? user!.image != null
                                ? DecorationImage(
                                    image: NetworkImage('${user!.image}'),
                                    fit: BoxFit.cover)
                                : const DecorationImage(
                                    image: NetworkImage(defaultProfilePicture),
                                    fit: BoxFit.cover,
                                    scale: 0.5,
                                  )
                            : DecorationImage(
                                image: FileImage(_imageFile ?? File('')),
                                fit: BoxFit.cover,
                              ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    getImage();
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.maxFinite,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/icons/user.png'),
                      SizedBox(
                        width: 220,
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                            ),
                            controller: txtNameController,
                            validator: (val) =>
                                val!.isEmpty ? 'Invalid Name' : null,
                          ),
                        ),
                      ),
                      InkWell(
                        child: Icon(
                          Icons.check_circle_outline_sharp,
                          color: Colors.green[700],
                        ),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            updateProfile();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const ButtonWidgets(
                  nameButton: 'Preferences',
                  iconButton: 'assets/icons/preferences.png',
                ),
                const ButtonWidgets(
                  nameButton: 'Notification',
                  iconButton: 'assets/icons/notification.png',
                ),
                const ButtonWidgets(
                  nameButton: 'Privacy and Security',
                  iconButton: 'assets/icons/privacy-security.png',
                ),
                const ButtonWidgets(
                  nameButton: 'About App',
                  iconButton: 'assets/icons/about.png',
                ),
                const SizedBox(height: 10),
                InkWell(
                  child: Container(
                    width: double.maxFinite,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () {
                    logout().then(
                      (value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                            (route) => false)
                      },
                    );
                  },
                ),
              ],
            ),
          );
  }
}