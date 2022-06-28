/// Holds information about a device
enum Device {
  tv(name: 'TV', id: 1, imageUrl: 'assets/tv.png'),
  humidifier(name: 'Humidifier', id: 2, imageUrl: 'assets/humidifier.png'),
  airConditioner(name: 'AC', id: 3, imageUrl: 'assets/air_conditioner.png');

  final String name;
  final int id;
  final String imageUrl;

  const Device({required this.name, required this.id, required this.imageUrl});
}