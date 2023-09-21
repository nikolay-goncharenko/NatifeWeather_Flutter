class BlockingError {
  final int cod;
  final String message;

  const BlockingError({
    required this.cod,
    required this.message,
  });

  factory BlockingError.fromJson(Map<String, dynamic> json) => BlockingError(
    cod: json['cod'],
    message: json['message'],
  );
}