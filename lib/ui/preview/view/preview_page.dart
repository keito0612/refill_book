import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PreviewPage extends HookConsumerWidget {
  PreviewPage({super.key, this.id});
  int? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController controller = PageController(initialPage: id!);
    final pageCount = useState((id! + 1));
    final visible = useState(true);
    print(id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: visible.value
          ? AppBar(
              centerTitle: true,
              backgroundColor: Colors.grey,
              title: Text(
                "${pageCount.value.toString()} / 8",
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
                    onPressed: () {
                      _openModalBottomSheet(context);
                    }),
                TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "編集",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _openEditModalBottomSheet(context);
                    })
              ],
            )
          : null,
      body: PageView.builder(
        dragStartBehavior: DragStartBehavior.values.first,
        scrollDirection: axisDirectionToAxis(AxisDirection.right),
        controller: controller,
        itemCount: 20,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                if (visible.value) {
                  visible.value = false;
                } else {
                  visible.value = true;
                }
              },
              child: _previewBodyWidget(null, context, visible));
        },
        onPageChanged: (int pageValue) {
          pageCount.value = pageValue + 1;
        },
      ),
    );
  }
}

Widget _previewBodyWidget(
    Uint8List? imageData, BuildContext context, ValueNotifier<bool> visible) {
  if (visible.value) {
    return Column(
      children: [
        Expanded(
            flex: 8,
            child: InteractiveViewer(
                minScale: 1,
                maxScale: 9,
                child: _previewImageWidget(imageData))),
        Expanded(flex: 2, child: _previewMemoWidget(context))
      ],
    );
  } else {
    return InteractiveViewer(
        minScale: 1, maxScale: 9, child: _previewImageWidget(imageData));
  }
}

Widget _previewImageWidget(Uint8List? imageData) {
  if (imageData != null) {
    return Image.memory(imageData);
  } else {
    return Image.asset(
      "lib/image/no_image_icon.png",
    );
  }
}

Widget _previewMemoWidget(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Container(
    width: width,
    height: height * 0.2,
    color: Colors.grey,
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    ),
  );
}

void _openModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.sizeOf(context).height / 4,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'カメラ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // アルバムを開く処理を記載（今回は省略）
                },
                child: Text(
                  'アルバム',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  '閉じる',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _openEditModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.sizeOf(context).height / 4,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.4),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'フォトエディタ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // アルバムを開く処理を記載（今回は省略）
                },
                child: Text(
                  '画像を変える',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  '閉じる',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
