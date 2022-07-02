import 'package:tutorial_ui_widgets/models/article.dart';

import '../api/article_api.dart';
import '../models/article.dart';

// the repo is where the data access logic is stored,
// It's hides the business logic
//and provides a simple layer for data access(repos pattern)
class ArticleRepo {
  final articleApi = ArticleAPI();

  Future<List<Article>> getArticles() => articleApi.fetchArticles();
}
