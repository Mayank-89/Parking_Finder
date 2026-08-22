class Parking {
  final String name;
  final double latitude;
  final double longitude;
  final int availableSlots;
  final double price;
  final double rating;

  Parking({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.availableSlots,
    required this.price,
    required this.rating,
  });
}