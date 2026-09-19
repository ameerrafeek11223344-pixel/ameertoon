import 'package:flutter/material.dart';

class MangaReaderPage extends StatelessWidget {
  final String chapterTitle;
  // قائمة تحتوي على روابط صور الفصول التي تم جلبها من السيرفر أو المصدر
  final List<String> imageUrls;

  const MangaReaderPage({
    Key? key,
    required this.chapterTitle,
    required this.imageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // خلفية سوداء تناسب قراءة المانهو ليلاً
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          chapterTitle,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: imageUrls.isEmpty
          ? const Center(
              child: Text(
                "لا توجد صور في هذا الفصل",
                style: TextStyle(color: Colors.white54),
              ),
            )
          : ListView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(
                  imageUrls[index],
                  fit: BoxFit.fitWidth, // لضمان عرض الصورة بعرض الشاشة بالكامل
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      height: 400,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[850],
                      child: const Center(
                        child: Text(
                          "فشل تحميل الصورة",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
