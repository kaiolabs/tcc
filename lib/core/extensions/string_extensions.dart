extension StringExtension on String {
  bool get isEmail {
    final RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(this);
  }

  bool get isPassword {
    final RegExp regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return regex.hasMatch(this);
  }

  bool get isPhoneNumber {
    final RegExp regex = RegExp(r'^[0-9]{10}$');
    return regex.hasMatch(this);
  }

  bool get isName {
    final RegExp regex = RegExp(r'^[a-zA-Z ]+$');
    return regex.hasMatch(this);
  }

  bool get isNumber {
    final RegExp regex = RegExp(r'^[0-9]+$');
    return regex.hasMatch(this);
  }
}
