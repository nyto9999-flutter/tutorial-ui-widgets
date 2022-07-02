import 'package:flutter/material.dart';
import 'package:tutorial_ui_widgets/models/article.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: Column(
        children: [
          CardBanner(imageUrl: article.urlToImage),
          CardDetails(article: article),
        ],
      ),
    );
  }
}

class CardBanner extends StatelessWidget {
  final String? imageUrl;
  const CardBanner({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //the rest of children will be put on the top of the child 'SizeBox'
      ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4), topRight: Radius.circular(4)),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              //progress value is continuously updated until the download is complete, the value becomes bull.
              if (progress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      Positioned(
        top: 10,
        right: 10,
        child: IconButton(
          icon: const Icon(
            Icons.bookmark_border,
            size: 32,
          ),
          onPressed: () {},
        ),
      )
    ]);
  }
}

class CardDetails extends StatelessWidget {
  final Article? article;
  const CardDetails({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            article!.title,
            style: Theme.of(context).textTheme.headline5,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: <Widget>[
              Text(article!.source),
              const Spacer(),
              const Text('45 comments'),
            ],
          )
        ],
      ),
    );
  }
}
