class LocationData {
  final double latitude;
  final double longitude;
  final String city;
  final String? state;
  final String country;

  const LocationData({
    required this.latitude,
    required this.longitude,
    required this.city,
    this.state,
    required this.country
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
    latitude: json['lat'].toDouble(),
    longitude: json['lon'].toDouble(),
    city: json['name'],
    state: json['state'],
    country: json['country'],
  );
}
