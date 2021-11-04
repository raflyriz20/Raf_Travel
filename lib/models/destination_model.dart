import 'package:flutter_travel_ui/models/activity_model.dart';

class Destination {
  String imageUrl;
  String city;
  String country;
  String description;
  List<Activity> activities;

  Destination({
    this.imageUrl,
    this.city,
    this.country,
    this.description,
    this.activities,
  });
}

List<Activity> activities_bwi = [
  Activity(
    imageUrl: 'assets/images/baluran.jpg',
    name: 'Tn. Baluran\' Banyuwangi',
    type: 'Sightseeing Tour',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 30,
  ),
  Activity(
    imageUrl: 'assets/images/alaspurwo.jpg',
    name: 'Alas Purwo',
    type: 'Sightseeing Tour',
    startTimes: ['8:00 pm', '12:00 pm'],
    rating: 4,
    price: 150,
  ),
  Activity(
    imageUrl: 'assets/images/pulaumerah.jpg',
    name: 'Pantai Pulau Merah',
    type: 'Sightseeing Tour',
    startTimes: ['12:30 pm', '2:00 pm'],
    rating: 5,
    price: 125,
  ),
    Activity(
    imageUrl: 'assets/images/ijen.jpeg',
    name: 'kawah Ijen',
    type: 'Sightseeing Tour',
    startTimes: ['12:30 pm', '8:00 pm'],
    rating: 5,
    price: 200,
  ),
];

List<Activity> activities_bws = [
  Activity(
    imageUrl: 'assets/images/kawah_wurung.jpeg',
    name: 'kawah wurung',
    type: 'Sightseeing Tour',
    startTimes: ['12:00 am', '8:00 am'],
    rating: 5,
    price: 200,
  ),
  Activity(
    imageUrl: 'assets/images/blawan.jpg',
    name: 'Air Terjun Blawan',
    type: 'Sightseeing Tour',
    startTimes: ['8:00 pm', '12:00 pm'],
    rating: 4,
    price: 150,
  ),
  Activity(
    imageUrl: 'assets/images/piramid.jpg',
    name: 'puncak piramid',
    type: 'Sightseeing Tour',
    startTimes: ['12:30 pm', '8:00 pm'],
    rating: 5,
    price: 200,
  ),
];

List<Activity> activities_sbd = [
  Activity(
    imageUrl: 'assets/images/pasirputih.jpg',
    name: 'Pantai Pasir Putih',
    type: 'Sightseeing Tour',
    startTimes: ['12:00 am', '6:00 am'],
    rating: 5,
    price: 200,
  ),
  Activity(
    imageUrl: 'assets/images/kampungkerapu.jpg',
    name: 'Kampung Kerapu',
    type: 'Sightseeing Tour',
    startTimes: ['8:00 pm', '12:00 pm'],
    rating: 5,
    price: 150,
  ),
  Activity(
    imageUrl: 'assets/images/blekok.jpeg',
    name: 'Kampung Blekok',
    type: 'Sightseeing Tour',
    startTimes: ['12:30 pm', '6:00 pm'],
    rating: 4,
    price: 120,
  ),
];

List<Activity> activities_jbr = [
  Activity(
    imageUrl: 'assets/images/papuma.jpg',
    name: 'Pantai Papuma',
    type: 'Sightseeing Tour',
    startTimes: ['12:00 am', '6:00 am'],
    rating: 5,
    price: 100,
  ),
  Activity(
    imageUrl: 'assets/images/gambir.jpg',
    name: 'Gunung Gambir',
    type: 'Sightseeing Tour',
    startTimes: ['8:00 pm', '12:00 pm'],
    rating: 5,
    price: 80,
  ),
];

List<Destination> destinations = [
  Destination(
    imageUrl: 'assets/images/ijen.jpeg',
    city: 'Banyuwangi',
    country: 'Indonesia',
    description: 'Banyuwangi dijuluki sebagai the sunrise of java',
    activities: activities_bwi,
  ),
  Destination(
    imageUrl: 'assets/images/kawah_wurung.jpeg',
    city: 'Bondowoso',
    country: 'Indonesia',
    description: 'kunjungi bondowoso untuk menikmati keindahan alam yang istimewa',
    activities: activities_bws,
  ),
  Destination(
    imageUrl: 'assets/images/pasirputih.jpg',
    city: 'Situbondo',
    country: 'indonesia',
    description: 'pemandangan dan keindahan alam yang sangat luar biasa',
    activities: activities_sbd,
  ),
  Destination(
    imageUrl: 'assets/images/papuma2.jpg',
    city: 'Jember',
    country: 'Indonesia',
    description: 'Kunjungi Jember untuk petualangan yang menakjubkan.',
    activities: activities_jbr,
  ),
];
