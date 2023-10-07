import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newstream/screens/details_screen/details_screen.dart';
import 'package:newstream/services/news_services.dart';
import 'model/news_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      home: const NewsHomePage(),
    );
  }
}

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({Key? key});

  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  late Future<List<Articles>> news;

  @override
  void initState() {
    super.initState();
    final newsService = NewsServices(
      apiKey: '2dc8cf7f7def40c68bd9f9ed803bd2fd',
      baseUrl: 'https://newsapi.org/v2',
    );
    news = newsService.fetchNews();
  }

  // Function to navigate to the DetailsScreen
  void _navigateToDetailsScreen(Articles article) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailsScreen(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 66, 0, 3),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 127, 0, 0), // Change AppBar color to red
        title: Center(
          child: Text(
            'N E W S T R E A M', // Center the title
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w300// Increase font size
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 7.0), // Add spacing between AppBar and Carousel
          Expanded(
            child: FutureBuilder<List<Articles>>(
              future: news,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No news available.'));
                } else {
                  final articles = snapshot.data!;
                  return CarouselSlider.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index, realIndex) {
                      final article = articles[index];
                      return GestureDetector(
                          onTap: () => _navigateToDetailsScreen(article), // Navigate to DetailsScreen on tap
                      child: Card(
                      margin: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            if (article.urlToImage != null &&
                                article.urlToImage!.isNotEmpty)
                              Image.network(article.urlToImage!),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                article.title ?? '',
                                style: Theme.of(context).textTheme.headline6,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                article.author ?? '',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                article.description ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      )
                      );
                    },
                    options: CarouselOptions(
                      height: 600.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
