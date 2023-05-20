abstract class AuthState {
  late bool isLoggedIn;
}

class LoggedIn extends AuthState {
  LoggedIn() {
    isLoggedIn = true;
  }
}

class NotLoggedIn extends AuthState {
  NotLoggedIn() {
    isLoggedIn = false;
  }
}

class SignUpState extends AuthState {
  SignUpState() {
    isLoggedIn = false;
  }
}
