import 'package:favorite_places_app/widgets/toast_util.dart';

class AuthVlidatorHelper {
  bool validateUserInput(String email, String password) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (email.isEmpty) {
      showToast("Email is required");
      return false;
    }

    if (!emailRegex.hasMatch(email)) {
      showToast("Invalid email format");

      return false;
    }

    if (password.isEmpty) {
      showToast("Password is required");

      return false;
    }

    if (password.length < 8) {
      showToast("Password must be at least 8 characters long");

      return false;
    }

    return true;
  }
}
