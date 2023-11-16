import 'dart:async';

import 'package:exam_instagram_clone_tut/views/components/constants/strings.dart';
import 'package:exam_instagram_clone_tut/views/components/loading/loading_screen_controleer.dart';
import 'package:flutter/material.dart';

class LoadingScreen {
  // private constructor
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  // exposed this private property _shared via factory constructor like below
  factory LoadingScreen.instance() => _shared;
  // so that entire application will have single LoadingScreen.
  // This class is not immutable because this class will hold up a variable--> controller

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = Strings.loading,
  }) {
    // here if loading screen is visible but need to change text then with update(text) function
    // used StreamController so text only updated and loading screen will remain loading as if {return true}
    // otherwise else create showOverlay new Loading screen
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

// overlay get continuously updates if anyone widget calls update function of
// LoadingScreenController so we need to work with something kind of Stream
  LoadingScreenController? showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final state = Overlay.of(context);
    if (state == null) {
      return null;
    }

    final textController = StreamController<String>();
    textController.add(text);
// must use correct context to get exact size of which renderbox we want -->like in MainView
// widget we have 2 context on in build() another is for Consumer(builder:(_--> context))
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.black.withAlpha(150),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.8,
              maxHeight: size.height * 0.8,
              minWidth: size.width * 0.5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  StreamBuilder(
                      stream: textController.stream,
                      builder: (context, snapShot) {
                        if (snapShot.hasData) {
                          return Text(
                            snapShot.requireData,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.black,
                                ),
                          );
                        } else {
                          return Container();
                        }
                      })
                ],
              )),
            ),
          ),
        ),
      );
    });

    state.insert(overlay);
    // to able to close stremcontroller and remove overlay or add text
    // to become self -contained LoadingScreenController we created close and update function while calling
    // loging screen or closing it
    return LoadingScreenController(close: () {
      textController.close();
      overlay.remove();
      return true;
    }, update: (text) {
      textController.add(text);
      return true;
    });
  }
}
