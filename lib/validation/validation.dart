class Validation {
  List<String> check(List<String> values, List<String> label) {
    List<String> msg = [];
    int count = 0;
    if (values.length != label.length) {
      throw "Erorr";
    } else {
      while (count != values.length) {
        if (values[count] == "") {
          msg.add("Please Fill ${label[count]}");
        }

        count++;
      }
    }
    return msg;
  }

  bool IsValidate(String _regExp, String value) {
    RegExp regExp = new RegExp(_regExp);
    return regExp.hasMatch(value);
  }
}
