import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lovebird/auth/auth.dart';
import 'package:lovebird/models/grid.dart';
import 'package:lovebird/pages/login/login.dart';
import 'package:lovebird/utils/theme.dart';
import 'package:lovebird/widgets/category.dart';
import 'package:lovebird/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/about.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    loadSharedPreferences();
  }

  Future<void> loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  // SharedPreferences? prefs;
  final _auth = Auth();
  List data = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
  ];

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // SharedPreferences.getInstance().then((value) => prefs = value);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPictureSize: const Size.square(80),
              currentAccountPicture: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    prefs?.getString('photoUrl') ?? '',
                  ),
                ),
              ),
              accountName: Text(
                prefs?.getString('displayName') ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              accountEmail: Text(prefs?.getString('email') ?? ''),
            ),
            drawerItem('assets/icons/food.png', 'Bahasa'),
            drawerItem('assets/icons/food.png', 'Makanan'),
            drawerItem('assets/icons/footprint.png', 'Jenis'),
            drawerItem('assets/icons/care.png', 'Perawatan'),
            drawerItem('assets/icons/gender.png', 'Gender'),
            const Divider(thickness: 1),
            drawerItem('assets/icons/info.png', 'Info'),
            GestureDetector(
              onTap: () async {
                await _auth.logout();
                // ignore: use_build_context_synchronously
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('isLoggedIn');
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (ctx) => const LoginPage()),
                    (route) => false);
              },
              child: const ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.logout_outlined),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[50],
        elevation: 0,
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
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/makanan'),
                      child: itemCategory('assets/icons/food.png', 'Makanan',
                          const Color(0xfffef8e0)),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/jenis'),
                      child: itemCategory('assets/icons/footprint.png', 'Jenis',
                          const Color(0xffe8f6e9)),
                    ),
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
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  data[index].url,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data[index].name,
                              ),
                            ),
                          ],
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
