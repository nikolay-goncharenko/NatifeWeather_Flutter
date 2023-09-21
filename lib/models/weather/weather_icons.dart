class WeatherIcons {
  final int id;
  final String main;
  final String description;
  final String icon;

  const WeatherIcons({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherIcons.fromJson(Map<String, dynamic> json) => WeatherIcons(
    id: json['id'],
    main: json['main'],
    description: json['description'],
    icon: json['icon'],
  );
}