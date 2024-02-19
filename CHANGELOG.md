<img align="right" width="25%" src="https://raw.githubusercontent.com/twicpics/components-flutter/main/resources/logo.png">

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Ensures that the `API` is not queried too frequently when resizing viewport.
  
- Fixes multiple calls to `inspect` route when resizing viewport.

## [0.2.1] - 2024-09-18

### Changed

- Chores: simplifies LQIP data retrieval by using `inspect` route.

- Updates brand: TwicPics becomes TwicPics by Frontify.

## [0.2.0] - 2024-07-18

### Added

- Adds `refit` property to `TwicImg` that allows to automatically reframe image to main object(s).

### Fixed

- Fixes example project for MacOS platform: 'Operation not permitted issue' when trying to fetch asset.

## [0.1.1] - 2024-06-16

### Fixed

- Improves responsiveness of cached image display.
- No more unnecessary redrawing when `TwicImg` is placed in a stateful widget tree.

## [0.1.0] - 2024-05-27

### Added

- Add `TwicImg` widget.

[Unreleased]: https://github.com/TwicPics/components/compare/main...dev
[0.2.1]: https://github.com/TwicPics/components-flutter/compare/0.2.0...0.2.1
[0.2.0]: https://github.com/TwicPics/components-flutter/compare/0.1.1...0.2.0
[0.1.1]: https://github.com/TwicPics/components-flutter/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/TwicPics/components-flutter/releases/tag/0.1.0
