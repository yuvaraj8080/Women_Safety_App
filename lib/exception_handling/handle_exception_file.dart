import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class TFirebaseAuthException implements Exception {
  final String code;

  TFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case "email-already-in-use":
        return "The email address is already in use by another account.";
      case "invalid-email":
        return "The email address is not valid.";
      case "weak-password":
        return "The password is too weak.";
      case "user-not-found":
        return "No user found with this email.";
      case "wrong-password":
        return "Wrong password provided for this user.";
      case "too-many-requests":
        return "Too many requests. Try again later.";
      case "user-disabled":
        return "This user account has been disabled.";
      default:
        return "An undefined authentication error occurred.";
    }
  }
}

class TFirebaseException implements Exception {
  final String code;

  TFirebaseException(this.code);

  String get message {
    return "FirebaseException: $code";
  }
}

class TFormException implements Exception {
  String get message {
    return "FormException: Invalid format";
  }
}

class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case "ERROR_NETWORK_REQUEST_FAILED":
        return "Network request failed. Please check your internet connection.";
      default:
        return "PlatformException: $code";
    }
  }
}

class AuthExceptionHandler {
  static String handleException(dynamic e) {
    try {
      if (e is FirebaseAuthException) {
        return TFirebaseAuthException(e.code).message;
      } else if (e is FirebaseException) {
        return TFirebaseException(e.code).message;
      } else if (e is FormatException) {
        return TFormException().message;
      } else if (e is PlatformException) {
        return TPlatformException(e.code).message;
      } else {
        return "Something went wrong, Please try again";
      }
    } catch (error) {
      return "An unexpected error occurred";
    }
  }
}
