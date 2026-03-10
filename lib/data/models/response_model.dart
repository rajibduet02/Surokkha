/// Generic API response wrapper (data, message, success).
class ResponseModel<T> {
  const ResponseModel({
    this.data,
    this.message,
    this.success = true,
  });

  final T? data;
  final String? message;
  final bool success;

  // TODO: fromJson factory
}
