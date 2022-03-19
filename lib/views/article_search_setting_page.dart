import 'package:flutter/material.dart';
import 'package:qiita_article/viewModels/article_view_model.dart';
import 'package:qiita_article/views/articles_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArticleSearchSettingPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(articleViewModel);
    return Container();
  }
}
