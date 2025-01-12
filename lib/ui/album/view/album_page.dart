import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlbumPage extends HookConsumerWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(children: [

    ]
    ),
    );
  }

  Widget albumItem() {
    return Container(
      width: 100,
      height: 150,
      child: Column(
        children: [],
      ),
    );
  }
}
