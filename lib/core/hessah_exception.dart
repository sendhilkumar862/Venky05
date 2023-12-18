class HessahException implements Exception {
  const HessahException(
    this.code,
    this.msg,
  );
  final int code;
  final String msg;
}
