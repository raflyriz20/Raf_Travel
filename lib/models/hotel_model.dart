class Hotel {
  String imageUrl;
  String name;
  String address;
  int price;

  Hotel({
    this.imageUrl,
    this.name,
    this.address,
    this.price,
  });
}

final List<Hotel> hotels = [
  Hotel(
    imageUrl: 'assets/images/hotel0.jpg',
    name: 'Hotel kokoon',
    address: 'kabat, banyuwangi',
    price: 175000,
  ),
  Hotel(
    imageUrl: 'assets/images/hotel1.jpg',
    name: 'Hotel Tentrem',
    address: 'Pusat kota bondowoso',
    price: 300000,
  ),
  Hotel(
    imageUrl: 'assets/images/hotel2.jpg',
    name: 'EL Hotel Royale',
    address: 'kabat, banyuwangi',
    price: 430000,
  ),
  Hotel(
    imageUrl: 'assets/images/hotelaston.jpg',
    name: 'Aston Jember Hotel',
    address: 'kaliwates, jember',
    price: 240000,
  ),
];
