import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pingo_assignment_app/src/common/theme/theme_helper.dart';
import 'package:pingo_assignment_app/src/common/widgets/loading_widget.dart';
import 'package:pingo_assignment_app/src/core/providers/auth_provider.dart';
import 'package:pingo_assignment_app/src/features/home/data/model/news_response.dart';
import 'package:pingo_assignment_app/src/features/home/data/repository/news_repo.dart';
import 'package:pingo_assignment_app/src/features/home/presentation/widgets/news_card.dart';
import 'package:pingo_assignment_app/src/navigation/router.dart';
import 'package:pingo_assignment_app/src/services/firebase_remote_config_service.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final newsRepo = Provider.of<NewsRepo>(context);
    final remoteConfigService =
        Provider.of<FirebaseRemoteConfigService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeHelper.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                remoteConfigService.fetchAndActivate();
              },
              child: Text("MyNews", style: ThemeHelper.appBarBoldTextStyle)),
        ),
        leadingWidth: 120,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                await Provider.of<AuthProvider>(context, listen: false)
                    .signOut();
                if (Provider.of<AuthProvider>(context, listen: false).status ==
                    Status.Unauthenticated) {
                  context.router.pushAndPopUntil(const SignupRoute(),
                      predicate: (route) => false);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.near_me, color: ThemeHelper.white),
                  Text(
                    remoteConfigService.countryCode,
                    style: ThemeHelper.subheadingMediumTextStyle.copyWith(
                        color: ThemeHelper.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Top Headlines", style: ThemeHelper.headingBoldTextStyle),
            Expanded(
              child: FutureBuilder<NewsResponse?>(
                future: newsRepo.getNews(remoteConfigService.countryCode),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text('No news found.'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.articles?.length,
                      itemBuilder: (context, index) {
                        final article = snapshot.data!.articles![index];
                        return NewsCard(article: article);
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
