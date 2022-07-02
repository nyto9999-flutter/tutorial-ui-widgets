import 'package:flutter/material.dart';
import 'package:tutorial_ui_widgets/models/article.dart';
import 'package:tutorial_ui_widgets/pages/article_page.dart';
import 'package:tutorial_ui_widgets/repos/article_repo.dart';
import 'package:tutorial_ui_widgets/widgets/article_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Article>>? _futureArticles;

  @override
  void initState() {
    super.initState();
    _futureArticles = ArticleRepo().getArticles();
  }

  @override
  Widget build(BuildContext context) {
    // if have asyn task, always use futurebuilder instead.
    return FutureBuilder<List<Article>>(
        future: _futureArticles,
        //a snapshot is just a representation of
        //the most recent interation with their synchronous tasks.
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                final article = snapshot.data![index];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticlePage(
                            article: article,
                          ),
                        ),
                      );
                    },
                    child: ArticleCard(article: article));
              },
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                style: const TextStyle(fontSize: 24),
              ),
            );
          }
          //during the network call, progress indicator is displaying.
          return const Center(child: CircularProgressIndicator());
        });
  }
}
