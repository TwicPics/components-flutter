![TwicPics Flutter Widget](https://raw.githubusercontent.com/TwicPics/components-flutter/main/resources/flutter-cover.png)

## Overview

### What is TwicPics?

[TwicPics](https://www.twicpics.com/?utm_source=github&utm_medium=organic&utm_campaign=components) is a **Responsive Media Service Solution** (SaaS) that enables **on-demand responsive image & video generation**.

With TwicPics, developers only deal with high-resolution versions of their media while end-users receive **optimized, perfectly sized, device-adapted** versions **delivered from a server close to them**.

TwicPics acts as an **proxy**. It retrieves your master file — from your own web server, cloud storage, or DAM — and generates a **device-adapted** version with **best-in-class compression**, delivered directly to the end-user from the **closest delivery point** available.

### What is TwicPics Flutter Components ?

 `TwicImg` and `TwicVideo` are widgets that make it dead easy to unleash the power of [TwicPics](https://www.twicpics.com/) in your `Flutter` projects.

## Features

- Fast Loading
- Images and videos sized to the pixel
- DPR awareness
- Lazy-loading
- Low Quality Image Placeholder
- Cache management
- CLS optimization
- Smart Cropping
- Many others with [TwicPics Transformations](https://www.twicpics.com/docs/reference/transformations)

## Getting started

The only requirement is to have a `TwicPics account`. If you don't already have one, you can easily create your own [TwicPics account for free](https://account.twicpics.com/signup).

However you can still test the widget with our demo domain: see samples in [/example](https://github.com/TwicPics/components-flutter/tree/main/example) folder.

## Usage

1 - Add `twicpics_components` as a dependency in your `pubspec.yaml` file:

```bash
$ flutter pub add twicpics_components
```

2 - Configure your Flutter application:

```dart
// main.dart

import 'package:twicpics_components/twicpics_components.dart';

void main() {
  install(
    domain: "https://<your-domain>.twic.pics/",
  );
  runApp(...);
}
```

3 - Display a network image:

```dart
// my_widget.dart

import 'package:twicpics_components/twicpics_components.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return TwicImg(
      src: 'path/to/my/image',
    );
  }
}
```

4 - Display a network video:

```dart
// my_widget.dart

import 'package:twicpics_components/twicpics_components.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return TwicVideo(
      src: 'path/to/my/video',
    );
  }
}
```

For more information feel free to consult the project [/example](https://github.com/TwicPics/components-flutter/tree/main/example) folder and / or our [documentation](https://www.twicpics.com/docs/components/flutter).

## Additional information

[TwicPics](https://www.twicpics.com/?utm_source=github&utm_medium=organic&utm_campaign=components) provides the most versatile solution on the market for delivering responsive media.

TwicPics Components are also available [in the most popular javascript frameworks](https://www.npmjs.com/package/@twicpics/components).

## Questions and feedback

Fell free to submit an [issue](https://github.com/TwicPics/components-flutter/issues) or to ask us anything by dropping an email at [support@twic.pics](mailto:support@twic.pics).