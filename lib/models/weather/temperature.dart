class Temperature {
  final double min;
  final double max;

  const Temperature({required this.min, required this.max});

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
    min: json['min'].toDouble(),
    max: json['max'].toDouble(),
  );
}