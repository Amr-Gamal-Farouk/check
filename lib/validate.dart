bool validPhone(String phoneNumber) {
  // RegExp regex = new RegExp(r'^(?:[0]10)?[0-9]{11}$');
  RegExp regex = new RegExp(r'^([1][0125])[0-9]{8}$');
  if (regex.hasMatch(phoneNumber))
    return true;
  else
    return false;
}

bool validEmail(String email) {
  RegExp regex = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (!regex.hasMatch(email))
    return false;
  else
    return true;
}

bool checkUrl(String url) {
  if (url.endsWith(".mp4") || url.contains(".mp4")) {
    return true;
  }
//
  else {
    return false;
  }
}
