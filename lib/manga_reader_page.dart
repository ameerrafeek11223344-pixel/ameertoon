import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MangaReaderPage extends StatelessWidget {
  final String chapterTitle;
  final List<String> imageUrls;

  const MangaReaderPage({
    Key? key,
    required this.chapterTitle,
    required this.imageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
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
                return CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => const SizedBox(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 250,
                    color: const Color(0xFF1E1E1E),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wifi_off, color: Colors.grey, size: 40),
                          SizedBox(height: 8),
                          Text(
                            "تعذر التحميل، تأكد من الاتصال أو تم حفظه مسبقاً",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
