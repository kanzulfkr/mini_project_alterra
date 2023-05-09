// ----- STRINGS ------
import 'dart:math';

const baseURL = 'http://192.168.148.93:8000/api';
const loginURL = '$baseURL/login';
const registerURL = '$baseURL/register';
const logoutURL = '$baseURL/logout';
const userURL = '$baseURL/user';
const postsURL = '$baseURL/posts';
const commentsURL = '$baseURL/comments';

// ----- Errors -----
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';

// ----- Etc -----
const defaultProfilePicture =
    'http://192.168.148.93:8000/storage/default-users.png';
