// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:bahanku/view/component_widgets/component_widgets.dart';
import 'package:bahanku/view/onboarding/on_boarding.dart';
import 'package:flutter/material.dart';

import 'package:bahanku/constant/app_services.dart';
import 'package:bahanku/models/api_response.dart';
import 'package:bahanku/models/post/post.dart';
import 'package:bahanku/api/post_service.dart';
import 'package:bahanku/api/user_service.dart';
import 'package:image_picker/image_picker.dart';

class PostForm extends StatefulWidget {
  final Post? post;
  final String? title;

  const PostForm({super.key, this.post, this.title});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtControllerBody = TextEditingController();
  bool _loading = false;
  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _createPost() async {
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await createPost(_txtControllerBody.text, image);

    if (response.error == null) {
      Navigator.of(context).pop();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const OnBoarding()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  // edit post
  void _editPost(int postId) async {
    ApiResponse response = await editPost(postId, _txtControllerBody.text);
    if (response.error == null) {
      Navigator.of(context).pop();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const OnBoarding()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  @override
  void initState() {
    if (widget.post != null) {
      _txtControllerBody.text = widget.post!.body ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                widget.post != null
                    ? const SizedBox()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            image: _imageFile == null
                                ? null
                                : DecorationImage(
                                    image: FileImage(_imageFile ?? File('')),
                                    fit: BoxFit.cover)),
                        child: Center(
                          child: IconButton(
                            icon: const Icon(Icons.image,
                                size: 50, color: Colors.black38),
                            onPressed: () {
                              getImage();
                            },
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _txtControllerBody,
                          keyboardType: TextInputType.multiline,
                          maxLines: 9,
                          validator: (val) =>
                              val!.isEmpty ? 'Post body is required' : null,
                          decoration: const InputDecoration(
                            hintText: "Post body...",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black38),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        child: Container(
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
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _loading = !_loading;
                            });
                            if (widget.post == null) {
                              _createPost();
                            } else {
                              _editPost(widget.post!.id ?? 0);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8),
                //   child: kTextButton(
                //     'Post',
                //     () {
                //       if (_formKey.currentState!.validate()) {
                //         setState(() {
                //           _loading = !_loading;
                //         });
                //         if (widget.post == null) {
                //           _createPost();
                //         } else {
                //           _editPost(widget.post!.id ?? 0);
                //         }
                //       }
                //     },
                //   ),
                // )
              ],
            ),
    );
  }
}
