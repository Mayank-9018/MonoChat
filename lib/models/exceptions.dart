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
