class FieldValidators {
  static String? mobileValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter your Mobile number";
    } else if (value.length < 10 && value.length > 10) {
      return "Enter valid Mobile number";
    }
    return null;
  }

  static String? mobileNoValidator(value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (RegExp(r"^[0-9]{10}$").hasMatch(value)) {
      // } else if (value.toString().contains('@')) {
      return null;
    } else {
      return 'Enter valid phone number';
    }
  }

  static String? emailValidator(email) {
    if (email == null || email.isEmpty) {
      return null;
    } else if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      // } else if (value.toString().contains('@')) {
      return null;
    } else {
      return 'Please enter valid email address';
    }
  }

  static String? aadharValidator(aadhar) {
    if (aadhar == null || aadhar.isEmpty) {
      return null;
    } else if (RegExp(r"^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$").hasMatch(aadhar)) {
      // } else if (value.toString().contains('@')) {
      return null;
    } else {
      return 'Please enter valid aadhar number';
    }
  }

  static String? pinCodeValidator(value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (RegExp(r"^[1-9]{1}[0-9]{2}[0-9]{3}$").hasMatch(value)) {
      // } else if (value.toString().contains('@')) {
      return null;
    } else {
      return 'Please enter valid pin code';
    }
  }

  static String? passwordValidator(value) {
    if (value.isEmpty) {
      return "Please enter your Password";
    } else if (value.length < 5) {
      return 'Password must be of greater than 4 character';
    }
    return null;
  }

  static String? globalValidator(value) {
    if (value.isEmpty) {
      return 'Required Field';
    }
    return null;
  }

  static String? chequeNoValidator(value) {
    if (value.isEmpty) {
      return 'Please enter cheque no';
    } else if (value.length < 9 || value.length > 9) {
      return 'cheque number must be 9-digit number';
    }
    return null;
  }

  // static String? phoneNumberValidator(value) {
  //   if (value.isEmpty) {
  //     return "";
  //   } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%A-Za-z-.,]')
  //       .hasMatch(value)) {
  //     return "Only Numbers are Allowed";
  //   } else {
  //     return null;
  //   }
  // }
}
