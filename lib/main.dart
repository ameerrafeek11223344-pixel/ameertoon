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
      debugShowCheckedModeBanner: false,
      title: 'أثير تون',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // قائمة تجريبية للمانهو بتصميم يشبه أثير تون (غلاف، عنوان، تصنيف، والفصول التابعة لها)
  final List<Map<String, dynamic>> mangaList = const [
    {
      'title': 'بداية الأسطورة (Solo Leveling Style)',
      'genre': 'أكشن • خيال • مغامرة',
      'cover': 'https://via.placeholder.com/300x450/222222/FFFFFF?text=Manga+Cover+1',
      'chapters': [
        {
          'title': 'الفصل الأول',
          'images': [
            'https://via.placeholder.com/800x1200/333333/FFFFFF?text=Page+1',
            'https://via.placeholder.com/800x1200/444444/FFFFFF?text=Page+2',
          ],
        },
        {
          'title': 'الفصل الثاني',
          'images': [
            'https://via.placeholder.com/800x1200/222222/FFFFFF?text=Page+1',
            'https://via.placeholder.com/800x1200/333333/FFFFFF?text=Page+2',
          ],
        },
      ],
    },
    {
      'title': 'المواجهة الحاسمة',
      'genre': 'غموض • إثارة • دراما',
      'cover': 'https://via.placeholder.com/300x450/333333/FFFFFF?text=Manga+Cover+2',
      'chapters': [
        {
          'title': 'الفصل الأول',
          'images': [
            'https://via.placeholder.com/800x1200/555555/FFFFFF?text=Page+1',
          ],
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_stories, color: Colors.deepPurpleAccent),
            SizedBox(width: 8),
            Text('أثير تون | AmeerToon', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: mangaList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // عرض عملين في كل صف
            childAspectRatio: 0.65, // نسبة الطول إلى العرض لتناسب شكل غلاف المانهو
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final manga = mangaList[index];
            return GestureDetector(
              onTap: () {
                _showChaptersBottomSheet(context, manga);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          manga['cover'],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            manga['title'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            manga['genre'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showChaptersBottomSheet(BuildContext context, Map<String, dynamic> manga) {
    final chapters = manga['chapters'] as List;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                manga['title'],
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'اختر الفصل للقراءة (يعمل بدون إنترنت بعد فتحه لأول مرة):',
                style: TextStyle(color: Colors.grey[400], fontSize: 11),
              ),
              const Divider(color: Colors.grey),
              Expanded(
                child: ListView.builder(
                  itemCount: chapters.length,
                  itemBuilder: (context, index) {
                    final chapter = chapters[index];
                    return ListTile(
                      title: Text(
                        chapter['title'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.deepPurpleAccent),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MangaReaderPage(
                              chapterTitle: '${manga['title']} - ${chapter['title']}',
                              imageUrls: List<String>.from(chapter['images']),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
