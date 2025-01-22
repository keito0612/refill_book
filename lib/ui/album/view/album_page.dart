import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refill_book/model/album.dart';
import 'package:refill_book/ui/image_list/view/image_list_page.dart';
import 'package:refill_book/ui/preview/view/preview_page.dart';

class AlbumPage extends HookConsumerWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Album> mocAlbumList = [
      Album(id: 0, title: "旅の思い出"),
      Album(id: 0, title: "旅の思い出"),
      Album(id: 0, title: "旅の思い出"),
      Album(id: 0, title: "旅の思い出")
    ];
    return albumListWidget(mocAlbumList, context);
  }

  Widget albumListWidget(List<Album> albumList, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    final aspectRatio = orientation == Orientation.portrait
        ? (width / 2) / (height * 0.3) // 縦画面の比率
        : (width / 4) / (height * 0.6);
    return GridView.builder(
      padding: EdgeInsets.all(20.0),
      itemCount: albumList.length,
      itemBuilder: (context, index) {
        return albumItemWidget(albumList[index], context);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
          mainAxisSpacing: 30,
          crossAxisSpacing: 30,
          childAspectRatio: aspectRatio),
    );
  }

  Widget albumItemWidget(Album album, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ImageListPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(2),
                bottomRight: Radius.circular(2),
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(16.0)),
            color: Colors.amber,
            border: Border.all(color: Colors.black)),
        width: 140,
        height: 300,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.black)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14.0),
                        bottomLeft: Radius.circular(16.0)),
                    color: Colors.amberAccent),
              ),
            ),
            Expanded(
              flex: 13,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 160,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Center(
                            child: Text(album.title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 16.0, left: 16.0),
                        child: _ImageWidget(null))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _ImageWidget(Uint8List? imageData) {
  if (imageData != null) {
    return Image.memory(imageData);
  } else {
    return Container(
      color: Colors.grey,
      height: 140,
      child: Center(
        child: Image.asset(
          "lib/image/no_image_icon.png",
        ),
      ),
    );
  }
}
