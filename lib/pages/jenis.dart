import 'package:flutter/material.dart';

import '../models/grid.dart';

class Jenis extends StatelessWidget {
  Jenis({super.key});

  final List<PhotoItem> dataGrid = [
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15060917/Lovebird-Misty-364x277.jpg',
      'Lovebird Misty',
    ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15061243/Lovebird-halfsider-168x300.jpg',
      'Lovebird Halfsider',
    ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15061150/Lovebird-Dakori-364x384.jpg',
      'Lovebird Dakori',
    ),
    // PhotoItem(
    //   'assets/images/biben.jpg',
    //   'Biben',
    // ),
    // PhotoItem(
    //   'assets/images/bubun.jpg',
    //   'Lovebird Batman',
    // ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15062546/Lovebird-muka-salem-Agapornis-roseicollis--384x216.jpg',
      'Lovebird Muka Salem',
    ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15061218/Lovebird-biru-mangsi-364x245.jpg',
      'Lovebird Biru Mangsi',
    ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15061309/Lovebird-Olive-225x300.jpg',
      ' Lovebird Olive',
    ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15062452/lovebird-fisher-384x384.jpg',
      ' Lovebird Fischer',
    ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15061336/Lovebird-Pale-Fallow-364x438.jpeg',
      'Lovebird Pale Fallow',
    ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15062104/lovebird-parblue-384x288.jpg',
      'Lovebird Parblue',
    ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15062133/Lovebird-Albino-364x381.jpg',
      'Lovebird Albino',
    ),
    // PhotoItem(
    //   'assets/images/my1.jpg',
    //   'Lovebird Cobalt',
    // ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15062328/lovebird-blorok.jpg',
      'Lovebird Blorok',
    ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15062303/Lovebird-Biola.jpg',
      'Lovebird Biola',
    ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15062240/lovebird-lutino-384x288.jpg',
      'Lovebird Lutino',
    ),
    PhotoItem(
      'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/10/15062219/lovebird-violet.jpg',
      'Lovebird Violet',
    ),
    // PhotoItem(
    //   'assets/images/my2.jpg',
    //   'Babon',
    // ),
    // PhotoItem(
    //   'assets/images/my4.jpg',
    //   'Babon',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading:
            const IconButton(onPressed: null, icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text(
          'Jenis',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: dataGrid.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (_, index) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image: NetworkImage(
                        dataGrid[index].image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      color: Colors.black45,
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text(
                        dataGrid[index].title,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
