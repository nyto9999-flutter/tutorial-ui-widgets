import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_ui_widgets/models/article.dart';
import 'package:tutorial_ui_widgets/widgets/platform_spinner.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: CupertinoColors.systemGrey4),
          ),
        ),
        child: WideCard(article: article),
      );
    }

    //Android
    return Card(
        margin: const EdgeInsets.all(16),
        elevation: 4,
        /*LayoutBuilder is called at layout time,
        and provides experience widgets box constraints,
        Constraints is simply the information of a box.*/
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;
            return isTablet
                ? WideCard(article: article)
                : TallCard(article: article);
          },
        ));
  }
}

class TallCard extends StatelessWidget {
  final Article article;
  const TallCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardBanner(imageUrl: article.urlToImage),
        CardDetails(article: article),
      ],
    );
  }
}

class WideCard extends StatelessWidget {
  final Article article;
  const WideCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CardBanner(
          imageUrl: article.urlToImage,
          isWideCard: true,
        ),
        Expanded(
            child: CardDetails(
          article: article,
        ))
      ],
    );
  }
}

class CardBanner extends StatelessWidget {
  final String? imageUrl;
  final bool isWideCard;
  const CardBanner({Key? key, this.imageUrl, this.isWideCard = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //the rest of children will be put on the top of the child 'SizeBox'
      ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4), topRight: Radius.circular(4)),
        child: SizedBox(
          height: isWideCard ? 150 : 200,
          width: isWideCard ? 150 : double.infinity,
          child: Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              //progress value is continuously updated until the download is complete, the value becomes bull.
              if (progress == null) return child;
              return const Center(child: PlatformSpinner());
            },
          ),
        ),
      ),
      Positioned(
        top: isWideCard ? 2 : 10,
        right: isWideCard ? 2 : 10,
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
    final isProtrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      height: isProtrait ? 130 : 150,
      padding: const EdgeInsets.all(16),
      child: Column(
        /*there is no need that sizedBox and space
        if enclosing container has a fixed height ? 130 : 150*/
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            article!.title,
            style: Theme.of(context).textTheme.headline5,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  child: Text(
                article!.source,
                overflow: TextOverflow.ellipsis,
              )),
              const Text('45 comments'),
            ],
          )
        ],
      ),
    );
  }
}
