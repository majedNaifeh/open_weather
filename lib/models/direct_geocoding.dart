import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  const DirectGeocoding(
      {required this.name,
      required this.lat,
      required this.long,
      required this.country});

  final String name;
  final double lat;
  final double long;
  final String country;

  factory DirectGeocoding.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];
    return DirectGeocoding(
        name: data['name'],
        lat: data['lat'],
        long: data['lon'],
        country: data['country']);
  }

  @override
  List<Object> get props => [name, lat, long, country];

  @override
  String toString() {
    return 'DirectGeocoding(name: $name, lat: $lat, long: $long, country: $country)';
  }

  DirectGeocoding copyWith({
    String? name,
    double? lat,
    double? long,
    String? country,
  }) {
    return DirectGeocoding(
      name: name ?? this.name,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      country: country ?? this.country,
    );
  }
}
