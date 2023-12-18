class StatusCode {
  const StatusCode._();
  static const int success = 200;
  static const int create = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int forbidden = 403;
  static const int serverError = 500;
  static const int timeOut = 504;
  static const int unSuccessful = 406;
  static const int noInternet = 0;
  static const int unknown = -1;
}