import 'dart:io';

import 'package:bahanku/models/api_response.dart';
import 'package:bahanku/models/user.dart';
import 'package:bahanku/services/user_service.dart';
import 'package:bahanku/view/component_widgets/component_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/constant.dart';
import '../login/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.data}')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
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
            padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
            child: ListView(
              children: [
                Center(
                  child: GestureDetector(
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          image: _imageFile == null
                              ? user!.image != null
                                  ? DecorationImage(
                                      image: NetworkImage('${user!.image}'),
                                      fit: BoxFit.cover)
                                  : null
                              : DecorationImage(
                                  image: FileImage(_imageFile ?? File('')),
                                  fit: BoxFit.cover),
                          color: Colors.amber),
                    ),
                    onTap: () {
                      getImage();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                    ),
                    controller: txtNameController,
                    validator: (val) => val!.isEmpty ? 'Invalid Name' : null,
                  ),
                ),
                const SizedBox(height: 20),
                kTextButton(
                  'Update',
                  () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      updateProfile();
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.red),
                    padding: MaterialStateProperty.resolveWith(
                      (states) => const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                  onPressed: () {
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
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
  }
}
