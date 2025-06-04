import 'package:flutter/material.dart';
import 'package:lovebird/widgets/appbar.dart';

class About1 extends StatefulWidget {
  const About1({super.key});

  @override
  State<About1> createState() => _About1State();
}

class _About1State extends State<About1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Apa itu Burung Loverd?'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              'Apa itu burung Lovebird?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.asset('assets/images/my1.jpg'),
            const Text(
              '''Lovebird dikenal karena keindahan warna bulu mereka, perilaku yang ceria, dan kepribadian yang menyenangkan. Mereka biasanya memiliki tubuh kecil dengan ekor pendek dan kepala yang besar. Bulu lovebird dapat bervariasi dalam berbagai warna dan pola, termasuk hijau, biru, kuning, dan kombinasi warna lainnya, tergantung pada spesies dan variasi genetiknya.\n\n
              Lovebird adalah burung yang sosial dan dapat membentuk ikatan yang kuat dengan pemiliknya. Mereka sering menunjukkan tanda-tanda kasih sayang dengan saling membelai atau memberikan makanan. Lovebird juga memiliki kemampuan vokal yang baik dan dapat mengeluarkan berbagai suara dan kicauan yang melodis.\n\n
              Burung lovebird dapat dijadikan hewan peliharaan yang menyenangkan dan membutuhkan perawatan yang tepat. Mereka membutuhkan kandang yang cukup besar, makanan yang seimbang, serta kesempatan untuk terbang dan bermain di luar kandang secara teratur. Jika dipelihara dengan baik, lovebird dapat hidup cukup lama, yaitu antara 10 hingga 15 tahun atau lebih.\n\n
              Terdapat berbagai jenis dan variasi lovebird, termasuk lovebird peach-faced (Agapornis roseicollis), lovebird masked (Agapornis personatus), lovebird Fischer (Agapornis fischeri), dan masih banyak lagi. Setiap jenis lovebird memiliki ciri-ciri dan karakteristik uniknya sendiri.''',
            ),
          ],
        ),
      ),
    );
  }
}
