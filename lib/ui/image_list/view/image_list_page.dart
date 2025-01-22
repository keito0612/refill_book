import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refill_book/ui/preview/view/preview_page.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

class ImageListPage extends HookConsumerWidget {
  const ImageListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // ナビゲーションバーを透明に
      systemNavigationBarIconBrightness: Brightness.light, // アイコンを明るく
      statusBarColor: Colors.transparent, // ステータスバーを透明に
      statusBarIconBrightness: Brightness.light, // ステータスバーアイコンを明るく
    ));
    final controller = PageController(initialPage: 0);
    final pageCount = useState(1);
    List<List<Map<String, dynamic>>> mocImageDatas = [
      [
        {"id": 0, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 1, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 2, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 3, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 4, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 5, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
      ],
      [
        {"id": 6, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 7, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 8, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 9, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 10, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 11, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 12, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 13, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
      ],
      [
        {"id": 12, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 13, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 14, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 15, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 16, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 17, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 18, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
        {"id": 19, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
      ]
    ];
    final width = useMemoized(() => MediaQuery.of(context).size.width);
    final height = useMemoized(() => MediaQuery.of(context).size.height);
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text(
          "写真一覧(${pageCount.value}/${mocImageDatas.length})",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: Text(
              "追加",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: PageView.builder(
        key: ValueKey(mocImageDatas.length),
        controller: controller,
        itemCount: mocImageDatas.length,
        itemBuilder: (context, index) {
          return _albumListWidget(ValueKey(mocImageDatas[index]),
              mocImageDatas[index], context, width, height, orientation);
        },
        onPageChanged: (int pageNumber) {
          pageCount.value = pageNumber + 1;
        },
      ),
    );
  }
}

Widget _albumListWidget(
    Key key,
    List<Map<String, dynamic>> imageList,
    BuildContext context,
    double width,
    double height,
    Orientation orientation) {
  final aspectRatio = orientation == Orientation.portrait
      ? (width / 2) / (height * 0.3) // 縦画面の比率
      : (width / 2) / (height * 0.3);
  final scrollController = ScrollController();
  return Scrollbar(
    controller: scrollController,
    child: GridView.builder(
      controller: scrollController,
      shrinkWrap: true,
      key: key,
      padding: EdgeInsets.all(20.0),
      itemCount: imageList.length,
      itemBuilder: (context, index) {
        return _imageWithMemoItemWidget(
            key: ValueKey(imageList[index]['id']),
            id: imageList[index]['id'],
            memo: imageList[index]['memo'],
            context: context);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
        mainAxisSpacing: 30,
        crossAxisSpacing: 16,
        childAspectRatio: aspectRatio,
      ),
    ),
  );
}

Widget _imageWithMemoItemWidget({
  required Key key,
  required int id,
  required String memo,
  required BuildContext context,
}) {
  return GestureDetector(
    key: key, // Key を設定
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PreviewPage(id: id)),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          _imageWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _memoTextWidget(memo),
          ),
        ],
      ),
    ),
  );
}

Widget _imageWidget({Uint8List? imageData}) {
  if (imageData != null) {
    return Image.memory(imageData);
  } else {
    return Image.asset(
      width: 120,
      height: 150,
      "lib/image/no_image_icon.png",
    );
  }
}

Widget _memoTextWidget(String memo) {
  return Container(
    child: Text(
      memo,
      maxLines: 2,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
          color: Colors.black),
    ),
  );
}
