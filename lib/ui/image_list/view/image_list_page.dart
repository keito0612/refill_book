import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refill_book/ui/preview/view/preview_page.dart';

class ImageListPage extends HookConsumerWidget {
  const ImageListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, dynamic>> mocImageDatas = [
      {"id": 0, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
      {"id": 1, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
      {"id": 2, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"},
      {"id": 3, "image": "", "memo": "結婚式結婚式けんっけんっけんっけんっけんっけんっけんっけんっ"}
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text("写真一覧"),
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
      body: _albumListWidget(mocImageDatas, context),
    );
  }
}

Widget _albumListWidget(
    List<Map<String, dynamic>> imageList, BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final orientation = MediaQuery.of(context).orientation;
  final aspectRatio = orientation == Orientation.portrait
      ? (width / 2) / (height * 0.3) // 縦画面の比率
      : (width / 4) / (height * 0.6);
  return GridView.builder(
    padding: EdgeInsets.all(20.0),
    itemCount: imageList.length,
    itemBuilder: (context, index) {
      return _imageWithMemoItemWidget(
          imageList[index]['id'], imageList[index]['memo'], context);
    },
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
      mainAxisSpacing: 30,
      crossAxisSpacing: 16,
      childAspectRatio: aspectRatio,
    ),
  );
}

Widget _imageWithMemoItemWidget(int id, String memo, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PreviewPage(id: id)),
      );
    },
    child: Container(
      color: Colors.white,
      child: Column(
        children: [
          _imageWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _memoTextWidget(memo),
          )
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
