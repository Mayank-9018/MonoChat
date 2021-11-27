// Login Exception codes:
// empty string - handle localy
// invalid-email - handle localy
// user-not-found
// wrong-password
// network-request-failed
// too-many-requests

class WrongCredentials implements Exception {
  String errMessage = 'Wrong Credentials!';
  @override
  String toString() {
    return errMessage;
  }
}

class NetworkRequestFailed implements Exception {
  String errMessage = 'No internet connection!';
  @override
  String toString() {
    return errMessage;
  }
}

class TooManyRequests implements Exception {
  String errMessage = 'Too many requests, try again later!';
  @override
  String toString() {
    return errMessage;
  }
}

class UserNotFound implements Exception {
  String errMessage = 'User not found!';
  @override
  String toString() {
    return errMessage;
  }
}

class EmailAlreadyInUse implements Exception {
  String errMessage = 'An account already exists for this email address!';
  @override
  String toString() {
    return errMessage;
  }
}

class InvalidEmail implements Exception {
  String errMessage = 'Invalid Email!';
  @override
  String toString() {
    return errMessage;
  }
}

class WeakPassword implements Exception {
  String errMessage = 'Weak password! Password should contain 8+ characters';
  @override
  String toString() {
    return errMessage;
  }
}
