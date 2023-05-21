import 'package:flutter/material.dart';
import 'package:lovebird/widgets/appbar.dart';

import '../widgets/food.dart';

class Food extends StatelessWidget {
  const Food({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Makanan'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Lovebird Hitam',
              ),
              const Text(
                'Makanan Loverbirde pada umumnya diantaranya : ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              foodList(
                  '1. Biji - bijian',
                  'https://1.bp.blogspot.com/-qspXt0Sh93A/WhWLeriDVpI/AAAAAAAAE8g/WbpwFSJxnR8ZWkLrkLuDAoc5HfVEAh-bACEwYBhgL/s1600/wijen.jpg',
                  'Biji-bijian merupakan makanan utama lovebird. Anda dapat memberikan biji bunga matahari, biji bawang, biji gandum, biji jagung, dan biji kacang hijau. Namun, pastikan untuk membeli biji-bijian yang berkualitas baik dan segar. Biji-bijian dapat diberikan langsung di wadah makanan lovebird, atau dicampur dengan makanan tambahan seperti sayuran atau buah-buahan.',
                  0xffe8f6e9),
              const SizedBox(
                height: 8,
              ),
              foodList(
                  '2. Buah - buahan',
                  'https://muftiwp.gov.my/images/old/Buah-buahan-dan-Sayuran.jpg',
                  'Lovebird menyukai buah-buahan, dan ini dapat menjadi sumber nutrisi yang baik bagi mereka. Anda dapat memberikan buah-buahan seperti apel, stroberi, buah anggur, pepaya, mangga, dan pisang. Namun, perlu diingat untuk menghapus bijinya terlebih dahulu dan mencuci buah sebelum memberikannya kepada lovebird.',
                  0xfffef8e0),
              const SizedBox(
                height: 8,
              ),
              foodList(
                  '3. Sayuran',
                  'https://imgs.search.brave.com/-KBQ7pSS47SAYFvPr3re-3YiSmfW0c8Y0GwB3vQitQg/rs:fit:1200:1200:1/g:ce/aHR0cHM6Ly9pbWFn/ZXMucGV4ZWxzLmNv/bS9waG90b3MvMTU1/NTM0Mi9wZXhlbHMt/cGhvdG8tMTU1NTM0/Mi5qcGVnP2NzPXNy/Z2ImZGw9cGV4ZWxz/LTE1NTUzNDIuanBn/JmZtPWpwZw',
                  'Selain biji-bijian dan buah-buahan, sayuran juga penting untuk memberikan asupan gizi yang seimbang bagi lovebird. Anda dapat memberikan sayuran hijau seperti kangkung, bayam, dan sawi, serta sayuran berwarna seperti wortel, brokoli, dan kacang polong. Pastikan sayuran yang diberikan segar dan dicuci bersih terlebih dahulu.',
                  0xffe5f5fc),
              const SizedBox(
                height: 8,
              ),
              foodList(
                  '4. Pelengkap',
                  'https://imgs.search.brave.com/xwf-k1MqiGieYBpe6Ft25ju3QRUOURd3PeqPCQFgp6k/rs:fit:1000:595:1/g:ce/aHR0cHM6Ly8xLmJw/LmJsb2dzcG90LmNv/bS8tb2Z4YlBSV09Z/ak0vV1VQeFQ1T2FU/LUkvQUFBQUFBQUFB/dUkvQ0VwWjVpM3lo/T2s1dkhYN1M1Q3Bz/T1p5OVRLX1ZsR2Vn/Q0xjQkdBcy9zMTYw/MC9UZWx1ciUyQkF5/YW0lMkJOZWdlcmku/anBn',
                  'Selain makanan utama, lovebird juga membutuhkan makanan tambahan sebagai pelengkap. Anda dapat memberikan telur rebus, millet, atau roti tawar yang sudah dipotong kecil-kecil. Namun, pastikan untuk memberikan makanan tambahan dengan porsi yang tepat, sehingga lovebird tidak kelebihan makan dan kegemukan.',
                  0xfff4e3fd),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
