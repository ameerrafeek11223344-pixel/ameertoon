import 'package:flutter/material.dart';
import 'manga_reader_page.dart';

void main() {
  runApp(const AmeerToonApp());
}

class AmeerToonApp extends StatelessWidget {
  const AmeerToonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AmeerToon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.deepPurple,
      ),
      home: const MangaHomeFeed(),
    );
  }
}

class MangaHomeFeed extends StatelessWidget {
  const MangaHomeFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // قائمة تجريبية لفصول المانجا/المانهوا مع صور افتراضية للاختبار
    final List<Map<String, dynamic>> sampleChapters = [
      {
        'title': 'الفصل 1: بداية الأسطورة',
        'images': [
          'https://picsum.photos/800/1200?random=1',
          'https://picsum.photos/800/1200?random=2',
          'https://picsum.photos/800/1200?random=3',
        ],
      },
      {
        'title': 'الفصل 2: المواجهة الحاسمة',
        'images': [
          'https://picsum.photos/800/1200?random=4',
          'https://picsum.photos/800/1200?random=5',
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text(
          'أثير تون - AmeerToon',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: sampleChapters.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final chapter = sampleChapters[index];
          return Card(
            color: const Color(0xFF1E1E1E),
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              title: Text(
                chapter['title'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: const Text(
                'متاح للقراءة والتحميل بدون إنترنت',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.deepPurpleAccent,
                size: 16,
              ),
              onTap: () {
                // الانتقال إلى شاشة القارئ عند الضغط على الفصل
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MangaReaderPage(
                      chapterTitle: chapter['title'],
                      imageUrls: List<String>.from(chapter['images']),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
