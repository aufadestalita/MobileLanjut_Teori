import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OSAMAKOM 2026',
      theme: ThemeData(
        fontFamily: 'Roboto', // Idealnya gunakan GoogleFonts.poppins() jika ada package-nya
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Warna background abu sangat muda
      body: Column(
        children: [
          // Header / Navbar (Meniru bagian atas di video)
          _buildNavbar(),
          // Konten Utama yang bisa di-scroll
          const Expanded(
            child: SingleChildScrollView(
              child: CompetitionSection(),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membuat Top Navigation Bar
  Widget _buildNavbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & Title
          Row(
            children: [
              const Icon(Icons.school, color: Colors.blue, size: 30),
              const SizedBox(width: 10),
              const Text(
                'OSAMAKOM 2026',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E266D),
                ),
              ),
            ],
          ),
          // Menu Links
          Row(
            children: [
              _navItem('Beranda'),
              _navItem('Tentang'),
              _navItem('Kompetisi'),
              _navItem('Pelatihan STEM'),
              _navItem('Jadwal'),
              _navItem('Hadiah'),
            ],
          ),
          // Action Buttons
          Row(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.search, size: 18, color: Colors.black87),
                label: const Text('Cek Status', style: TextStyle(color: Colors.black87)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E266D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                ),
                child: const Text('Daftar', style: TextStyle(color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _navItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Bagian Kartu Kompetisi (Stateful agar interaktif)
// Bagian Kartu Kompetisi
class CompetitionSection extends StatefulWidget {
  const CompetitionSection({Key? key}) : super(key: key);

  @override
  State<CompetitionSection> createState() => _CompetitionSectionState();
}

class _CompetitionSectionState extends State<CompetitionSection> {
  // Fisika (index 2) menyala secara default saat web pertama kali dibuka
  int selectedIndex = 2; 

  final List<Map<String, dynamic>> competitions = [
    {
      'title': 'Biologi',
      'desc': 'Eksplorasi kehidupan & keanekaragaman hayati.',
      'icon': Icons.biotech,
      'color': Colors.green,
    },
    {
      'title': 'Kimia',
      'desc': 'Reaksi kimia & analisis materi tingkat lanjut.',
      'icon': Icons.science,
      'color': Colors.redAccent,
    },
    {
      'title': 'Fisika',
      'desc': 'Hukum alam, mekanika, hingga teori modern.',
      'icon': Icons.animation,
      'color': Colors.blue,
    },
    {
      'title': 'Matematika',
      'desc': 'Logika, analisis, dan pemecahan masalah numerik.',
      'icon': Icons.calculate,
      'color': Colors.orange,
    },
    {
      'title': 'Komputer',
      'desc': 'Algoritma, pemrograman, dan logika komputer.',
      'icon': Icons.terminal,
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: const Color(0xFFF8F9FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Bidang Kompetisi',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E266D),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Asah kemampuanmu di salah satu dari lima bidang olimpiade unggulan kami',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: competitions.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> data = entry.value;

                bool isSelected = index == selectedIndex;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    // PERUBAHAN UTAMA: State berubah begitu kursor menyentuh kartu (hover)
                    onEnter: (_) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    // GestureDetector tetap bisa dipertahankan jika kartu ini nantinya punya fungsi navigasi URL saat diklik
                    child: GestureDetector(
                      onTap: () {
                        // Logika navigasi ke halaman pendaftaran ditaruh di sini nantinya
                      },
                      child: _buildCompetitionCard(data, isSelected),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitionCard(Map<String, dynamic> data, bool isSelected) {
    Color themeColor = data['color'];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      // Sedikit membesar saat terpilih, sama seperti efek di video
      transform: Matrix4.identity()..scale(isSelected ? 1.02 : 1.0),
      width: 230,
      height: 300,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? themeColor : Colors.grey.shade200,
          width: isSelected ? 2.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected ? themeColor.withOpacity(0.15) : Colors.transparent,
            blurRadius: isSelected ? 20 : 0,
            spreadRadius: isSelected ? 5 : 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: themeColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              data['icon'],
              color: themeColor,
              size: 36,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            data['title'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            data['desc'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          const Spacer(),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isSelected ? 1.0 : 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LIHAT JUKNIS & DAFTAR',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward,
                  size: 14,
                  color: themeColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}