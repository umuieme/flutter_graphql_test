class Validator{

  static String validateEmail(String value){
    return value.isNotEmpty ? null: "Invalid email";
  }

  static String validatePassword(String value){
    return value.isNotEmpty ? null: "Invalid password";

  }
}