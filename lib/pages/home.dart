import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lovebird/auth/auth.dart';
import 'package:lovebird/models/grid.dart';
import 'package:lovebird/utils/theme.dart';
import 'package:lovebird/widgets/category.dart';
import 'package:lovebird/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovebird/widgets/toast.dart';
import '../widgets/about.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleSignInAccount? _googleSignInAccount;

  final _firestore = FirebaseFirestore.instance;

  final _auth = Auth();
  List data = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      drawer: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _firestore.collection('users').doc(user!.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Drawer(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return toast('Gagal mendapatkan informasi');
          }

          String? displayName;
          String? email;
          String? photoUrl;

          // Mendapatkan informasi pengguna dari metode login email/password
          if (user.email != null) {
            displayName = user.displayName;
            email = user.email;
          }

          // Mendapatkan informasi pengguna dari metode login Google
          if (_googleSignInAccount != null) {
            displayName = _googleSignInAccount!.displayName;
            email = _googleSignInAccount!.email;
            photoUrl = _googleSignInAccount!.photoUrl;
          }

          return CustomDrawer(
            displayName: displayName,
            email: email,
            photoUrl: photoUrl,
          );
        },
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
                  physics: const AlwaysScrollableScrollPhysics(),
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

//   buildDrawer(String? _displayName, String? _email, BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: [
//           UserAccountsDrawerHeader(
//             currentAccountPictureSize: const Size.square(80),
//             currentAccountPicture: UserManager.photoUrl != null
//                 ? CircleAvatar(
//                     backgroundImage: NetworkImage(UserManager.photoUrl!),
//                   )
//                 : const CircleAvatar(
//                     child: Icon(
//                       Icons.person,
//                       size: 50,
//                     ),
//                   ),
//             accountName: _displayName != null
//                 ? Text(
//                     _displayName,
//                     style: const TextStyle(fontSize: 16),
//                   )
//                 : null,
//             accountEmail: _email != null ? Text(_email) : null,
//           ),
//           // drawerItem('assets/icons/food.png', 'Bahasa'),
//           // drawerItem('assets/icons/food.png', 'Makanan'),
//           // drawerItem('assets/icons/footprint.png', 'Jenis'),
//           // drawerItem('assets/icons/care.png', 'Perawatan'),
//           // drawerItem('assets/icons/gender.png', 'Gender'),
//           // const Divider(thickness: 1),
//           // drawerItem('assets/icons/info.png', 'Info'),
//           GestureDetector(
//             onTap: () async {
//               await _auth.logout();
//               // SharedPreferences prefs = await SharedPreferences.getInstance();
//               // bool isGoogleLoggedIn =
//               //     await SessionManager.getGoogleLoginStatus();
//               // bool isEmailPasswordLoggedIn =
//               //     await SessionManager.getEmailPasswordLoginStatus();

//               // if (isGoogleLoggedIn) {
//               //   await SessionManager.clearGoogleLoginSession();
//               // } else if (isEmailPasswordLoggedIn) {
//               //   await SessionManager.clearEmailPasswordLoginSession();
//               // }

//               // prefs.remove('isLoggedIn');
//               // ignore: use_build_context_synchronously
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (ctx) => const LoginPage()),
//                   (route) => false);
//             },
//             child: const ListTile(
//               title: Text('Logout'),
//               leading: Icon(Icons.logout_outlined),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
}
