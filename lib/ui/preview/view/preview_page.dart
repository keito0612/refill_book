import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PreviewPage extends HookConsumerWidget {
  const PreviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController controller = PageController();
    final pageCount = useState(1);
    final visible = useState(true);

    return Scaffold(
      appBar: visible.value
          ? AppBar(
              centerTitle: true,
              backgroundColor: Colors.grey,
              title: Text("${pageCount.value.toString()} / 5"),
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
                    onPressed: () {}),
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
                    onPressed: () {})
              ],
            )
          : null,
      body: PageView.builder(
        dragStartBehavior: DragStartBehavior.values.first,
        scrollDirection: axisDirectionToAxis(AxisDirection.right),
        controller: controller,
        itemCount: 5,
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
