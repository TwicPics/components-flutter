<img align="right" width="25%" src="https://raw.githubusercontent.com/twicpics/components-flutter/main/resources/logo.png">

# TwicPics Flutter Widget Samples

## How to install

Add the `twicpics_components` package to your `Flutter` project by running:

```bash
$ flutter pub add twicpics_components
```

## How to setup

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

If you don't already have a TwicPics domain, you can easily create your own [TwicPics account for free](https://account.twicpics.com/signup).

## How to use

`TwicImg` comes as a `Flutter Widget` and is used as [such](https://docs.flutter.dev/ui/widgets-intro).

### Basic usage

Remember, the widget does not expose height nor width properties.

The image __occupies the whole width of its container__.

Its height is determined according to the desired `ratio`.

The __default ratio is 1__ (which generates a square variant of your master image).

This will display a smart cropped image with an aspect-ratio of 1:

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

### Bulk loading

When embedding `TwicImg` in a lazily loading-compatible tree, it is recommended to disable `TwcImg`'s lazy-loading feature:

```dart
// my_widget.dart

class GridSample extends StatelessWidget {
  const GridSample({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      crossAxisCount: 3,
      children: [
        TwicImg(
          src: 'path/to/my/image',
          eager: true,
        ),
        // ...
      ]
    );
  }
}
```

### Choose your focus

You can control the crop function by using the `focus` property.

Read more about [focus](https://www.twicpics.com/docs/reference/transformations#focus).

```dart
// my_widget.dart

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return TwicImg(
      src: 'path/to/my/image',
      focus: 'auto',
    );
  }
}
```

### Display a landscape image

Setting a value to `ratio` property changes the aspect-ratio of the generated and displayed image.

This will display a smart cropped image with an aspect-ratio of 4/3.

```dart
// my_widget.dart

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return TwicImg(
      src: 'path/to/my/image',
      ratio: '4/3',
    );
  }
}
```

### Display a portrait image

This will display a smart cropped image with an aspect-ratio of 3/4.

```dart
// my_widget.dart

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return TwicImg(
      src: 'path/to/my/image',
      ratio: '3/4',
    );
  }
}
```

### Working with ratio="none"

Allows to display an image with a __free height__ while respecting its __natural aspect-ratio__.

#### Hero image

An image that occupies all available space:

```dart
// my_widget.dart

import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class HeroSample extends StatelessWidget {
  const HeroSample({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TwicImg(
        src: 'path/to/my/image.jpg',
          ratio: 'none',
        ),
    );
  }
}
```

#### Hero banner

You can specify the height of your image while respecting its __natural aspect-ratio__ and optimizing your Cumulative Layout Shift (CLS) metric.

```dart
// my_widget.dart

import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: TwicImg(
        src: 'path/to/my/image.jpg',
        ratio: 'none',
      ),
    );
  }
}
```

### Reframe your image

You can **reframe** your image on the **main subject(s)** it contains.

In **cover** `mode`, the resulting image will respect `ratio` while maximizing the area occupied by the main subject(s).

In **contain** `mode`, the image will be cropped as close as possible to the main subject(s).

To activate automatic cropping, simply add the `refit` property to your component.

Read more about [refit](https://www.twicpics.com/docs/reference/transformations#refit).

```dart
// my_widget.dart

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return TwicImg(
      anchor: TwicPosition.right, // will align main subject(s) with the right border
      src: 'path/to/my/image',
      mode: TwicMode.cover, // will maximize the area occupied by the main subject(s) in a squared area
      refit: '10p', // will add a 10% padding around the main subject(s)
    );
  }
}
```

```dart
// my_widget.dart

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return TwicImg(
      src: 'path/to/my/image',
      mode: TwicMode.contain, // will crop the image as close as possible to main subject(s)
      refit: true, // default refit without any padding
    );
  }
}
```

### Working with Row Widget

When using [Row Widget](https://api.flutter.dev/flutter/widgets/Row-class.html) you have to __constrain available width__ for `TwicImg` as in:

```dart
import 'package:flutter/material.dart';
import 'package:twicpics_components/twicpics_components.dart';

class RowSample extends StatelessWidget {
  const RowSample({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100, //fixed width
          child: TwicImg(
            src:'path/to/my/image.jpg',
          ),
        ),
        Expanded( // makes child fills the available space
          child: TwicImg(
            src:'path/to/my/image.jpg',
          ),
        ),
      ],
    );
  }
}
```

### Using TwicPics transformations

You can access [TwicPics Transformation](https://www.twicpics.com/docs/reference/transformations) through  `preTransform` property.

This will display a variant of your master image for which background has been removed using artificial intelligence:

```dart
// grid_sample.dart

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return TwicImg(
      src: 'path/to/my/image',
      preTransform: 'background=remove',
    );
  }
}
``` 

## Questions and feedback

Fell free to submit an [issue](https://github.com/TwicPics/components/issues) or to ask us anything by dropping an email at [support@twic.pics](mailto:support@twic.pics).