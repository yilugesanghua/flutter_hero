// Copyright (c) 2018, the Zefyr project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_hero/zefyr/source_enum.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:zefyr/zefyr.dart';

/// Custom image delegate used by this example to load image from application
/// assets.
class CustomImageDelegate implements ZefyrImageDelegate<SourceEnum> {
  @override
  SourceEnum get cameraSource => SourceEnum.CAMERA;

  @override
  SourceEnum get gallerySource => SourceEnum.GALLERY;

  @override
  Future<String> pickImage(SourceEnum source) async {
    List<Asset> result = await MultiImagePicker.pickImages(
      maxImages: 1,
      enableCamera: source == SourceEnum.CAMERA,
      cupertinoOptions: CupertinoOptions(
        takePhotoIcon: "chat",
      ),
      materialOptions: MaterialOptions(
        startInAllView: true,
        actionBarColor: "#abcdef",
        actionBarTitle: "Example App",
        allViewTitle: "All Photos",
        useDetailsView: false,
        selectCircleStrokeColor: "#000000",
      ),
    );

    if (result == null || result.isEmpty) return null;
    File file = File(await result[0].filePath);
    return file.uri.toString();
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    // We use custom "asset" scheme to distinguish asset images from other files.
    if (key.startsWith('asset://')) {
      final asset = AssetImage(key.replaceFirst('asset://', ''));
      return Image(image: asset);
    } else {
      // Otherwise assume this is a file stored locally on user's device.
      final file = File.fromUri(Uri.parse(key));
      final image = FileImage(file);
      return Image(image: image);
    }
  }
}
