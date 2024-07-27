import 'package:flutter/material.dart';
import 'package:pingo_assignment_app/src/common/helpers/size.dart';
import 'package:pingo_assignment_app/src/common/theme/theme_helper.dart';
import 'package:pingo_assignment_app/src/features/home/data/model/news_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.article,
  });
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: ThemeHelper.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.title ?? "No title",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: ThemeHelper.headingBoldTextStyle),
                  Text(
                      article.content != null ? article.content! : "No content",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: ThemeHelper.subheadingMediumTextStyle),
                  Text(
                      article.publishedAt != null
                          ? timeago.format(article.publishedAt!)
                          : 'Unknown time',
                      style: ThemeHelper.smallTextStyle),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.all(4.0),
                width: SizeHelper(context).wHelper(30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(article.urlToImage != null
                          ? article.urlToImage!
                          : "https://picsum.photos/200/300"),
                    )))
          ],
        ));
  }
}
