import 'package:flutter/material.dart';
import 'package:qiita_article/viewModels/article_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ArticleSearchSettingPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(articleViewModel.notifier);
    final state = ref.watch(articleViewModel.notifier).state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('検索'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          TextFormField(
            controller: TextEditingController(text: state.keyword),
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              hintText: 'キーワード',
            ),
            onFieldSubmitted: (value) async {
              await viewModel.setQuery(value);
              await viewModel.getArticles();
              Navigator.of(context).pop();
            },
          ),
        ]),
      ),
    );
  }
}
