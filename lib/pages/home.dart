import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lovebird/models/grid.dart';
import 'package:lovebird/utils/theme.dart';
import 'package:lovebird/widgets/category.dart';
import 'package:lovebird/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/about.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
  ];

  // final List<PhotoItem> dataGrid = [
  //   PhotoItem(
  //     'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15060917/Lovebird-Misty-364x277.jpg',
  //     'Lovebird Misty',
  //   ),
  //   PhotoItem(
  //     'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15061243/Lovebird-halfsider-168x300.jpg',
  //     'Lovebird Halfsider',
  //   ),
  //   PhotoItem(
  //     'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15061150/Lovebird-Dakori-364x384.jpg',
  //     'Lovebird Dakori',
  //   ),
  //   // PhotoItem(
  //   //   'assets/images/biben.jpg',
  //   //   'Biben',
  //   // ),
  //   // PhotoItem(
  //   //   'assets/images/bubun.jpg',
  //   //   'Lovebird Batman',
  //   // ),
  //   PhotoItem(
  //     'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15062546/Lovebird-muka-salem-Agapornis-roseicollis--384x216.jpg',
  //     'Lovebird Muka Salem',
  //   ),
  //   PhotoItem(
  //     'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15061218/Lovebird-biru-mangsi-364x245.jpg',
  //     'Lovebird Biru Mangsi',
  //   ),
  //   PhotoItem(
  //     'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15061309/Lovebird-Olive-225x300.jpg',
  //     'Lovebird Olive',
  //   ),
  //   PhotoItem(
  //     'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15062452/lovebird-fisher-384x384.jpg',
  //     'Lovebird Fischer',
  //   ),
  // ];
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          const UserAccountsDrawerHeader(
              currentAccountPictureSize: Size.square(80),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person, size: 50),
              ),
              accountName: Text('Raka'),
              accountEmail: Text('raka.dev@gmail.com')),
          drawerItem('assets/icons/food.png', 'Bahasa'),
          drawerItem('assets/icons/food.png', 'Makanan'),
          drawerItem('assets/icons/footprint.png', 'Jenis'),
          drawerItem('assets/icons/care.png', 'Perawatan'),
          drawerItem('assets/icons/gender.png', 'Gender'),
          const Divider(thickness: 1),
          drawerItem('assets/icons/info.png', 'Info'),
        ],
      )),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.language))
        ],
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 0.8,
                  aspectRatio: 9 / 3,
                  height: 180,
                ),
                items: data.map((e) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            e,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Catagory',
                style: kTitle,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    itemCategory('assets/icons/food.png', 'Makanan',
                        const Color(0xfffef8e0)),
                    const SizedBox(width: 16),
                    itemCategory('assets/icons/footprint.png', 'Jenis',
                        const Color(0xffe8f6e9)),
                    const SizedBox(width: 16),
                    itemCategory('assets/icons/care.png', 'Perawatan',
                        const Color(0xfff4e3fd)),
                    const SizedBox(width: 16),
                    itemCategory('assets/icons/gender.png', 'Gender',
                        const Color(0xffe5f5fc)),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'About',
                style: kTitle,
              ),
              const SizedBox(height: 16),
              about('assets/icons/info.png', 'Apa itu burung Lovebird',
                  'Lovervbird adalah', const Color(0xffBBDEFA)),
              const SizedBox(height: 10),
              about('assets/icons/list.png', 'Sebelum Memelihara',
                  'Persiapan sebelum memelihara', const Color(0xffFFCDD2)),
              const SizedBox(height: 10),
              about('assets/icons/kandang1.png', 'Set Up Kandang ',
                  'Kandang yang baik akan', const Color(0xffFFFAC3)),
              const SizedBox(height: 16),
              const Text(
                'Photo',
                style: kTitle,
              ),
              const SizedBox(height: 16),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('gallery').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<PhotoItem> data = snapshot.data!.docs
                      .map((doc) => PhotoItem.fromFirestore(doc))
                      .toList();
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      return Card(
                        elevation: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            data[index].url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
