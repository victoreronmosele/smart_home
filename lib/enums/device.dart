/// Holds information about a device
enum Device {
  tv(name: 'TV', longName: 'Television', id: 1, imageUrl: 'assets/tv.png'),
  humidifier(
      name: 'Humidifier',
      longName: 'Humidifier',
      id: 2,
      imageUrl: 'assets/humidifier.png'),
  airConditioner(
      name: 'AC',
      longName: 'Air Conditioner',
      id: 3,
      imageUrl: 'assets/air_conditioner.png');

  /// Holds short form of device name
  final String name;

  /// Holds long form of device name
  final String longName;

  /// Holds device id
  final int id;

  /// Holds device image url
  final String imageUrl;

  const Device(
      {required this.name,
      required this.longName,
      required this.id,
      required this.imageUrl});
}
