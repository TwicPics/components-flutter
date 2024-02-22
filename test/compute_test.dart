import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twicpics_components/src/compute.dart';
import 'package:twicpics_components/src/install.dart';
import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/src/utils.dart';

void main() {
  group('computeActualSize', () {
    test('should round width down to the nearest 50 pixels', () {
      Size actualSize = computeActualSize(
          lqip: false,
          dpr: 1,
          step: 50,
          viewSize: Size(
            width: 252,
            height: 252,
          ));
      expect(actualSize.height, 250);
      expect(actualSize.width, 250);
    });
    test('should round width down to the nearest 100 pixels', () {
      Size actualSize = computeActualSize(
          lqip: false,
          dpr: 1,
          step: 100,
          viewSize: Size(
            width: 250,
            height: 250,
          ));
      expect(actualSize.height, 200);
      expect(actualSize.width, 200);
    });

    test('should take into account the value of the DPR', () {
      Size actualSize = computeActualSize(
          lqip: false,
          dpr: 2,
          step: 100,
          viewSize: Size(
            width: 250,
            height: 250,
          ));
      expect(actualSize.height, 400);
      expect(actualSize.width, 400);
    });

    test('should compute placeholder size with a square ratio', () {
      Size actualSize = computeActualSize(
          lqip: true,
          dpr: 1,
          step: 100,
          viewSize: Size(
            width: 250,
            height: 250,
          ));
      expect(actualSize.height, 1000);
      expect(actualSize.width, 1000);
    });

    test('should compute placeholder size with a ratio = "2"', () {
      Size actualSize = computeActualSize(
          lqip: true,
          dpr: 1,
          step: 100,
          viewSize: Size(
            width: 250,
            height: 125,
          ));
      expect(actualSize.height, 500);
      expect(actualSize.width, 1000);
    });
  });

  group('computeAlignment', () {
    test('should fallback to Alignment.center', () {
      expect(computeAlignment(), Alignment.center);
    });
    test('should not consider anchor when fit is cover', () {
      expect(computeAlignment(fit: BoxFit.cover, anchor: Alignment.topCenter),
          Alignment.center);
    });
    test('should return anchor when fit is contain', () {
      expect(computeAlignment(fit: BoxFit.contain, anchor: Alignment.topCenter),
          Alignment.topCenter);
    });
    test('alignment should take precedence over anchor when fit is contain',
        () {
      expect(
          computeAlignment(
              fit: BoxFit.contain,
              alignment: Alignment.bottomLeft,
              anchor: Alignment.topCenter),
          Alignment.bottomLeft);
    });
  });

  group('computePreTransform', () {
    test('should return empty string', () {
      String preTransform = computePreTransform(fit: BoxFit.cover);
      expect(preTransform, '/*');
    });
    test('should return simple preTransform', () {
      String preTransform =
          computePreTransform(fit: BoxFit.cover, preTransform: 'flip=x');
      expect(preTransform, '/flip=x/*');
    });
    test('should return preTransform with defined focus', () {
      String preTransform = computePreTransform(
          fit: BoxFit.cover, focus: 'auto', preTransform: 'flip=x');
      expect(preTransform, '/flip=x/focus=auto/*');
    });
    test('should return preTransform with focus according to anchor', () {
      String preTransform = computePreTransform(
          fit: BoxFit.cover, anchor: Alignment.center, preTransform: 'flip=x');
      expect(preTransform, '/flip=x/focus=center/*');
    });
    test('focus should take precedence', () {
      String preTransform = computePreTransform(
          fit: BoxFit.cover,
          focus: 'auto',
          anchor: Alignment.center,
          preTransform: 'flip=x');
      expect(preTransform, '/flip=x/focus=auto/*');
    });
    test('should not take focus or anchor into account', () {
      String preTransform = computePreTransform(
          fit: BoxFit.contain,
          focus: 'auto',
          anchor: Alignment.center,
          preTransform: 'flip=x');
      expect(preTransform, '/flip=x/*');
    });
    test('should return a flip + refit transform', () {
      String preTransform = computePreTransform(
          anchor: Alignment.topRight,
          fit: BoxFit.cover,
          focus: 'auto',
          preTransform: 'flip=x',
          refit: '15p');
      expect(preTransform, '/flip=x/refit=WxH(15p)@top-right');
    });
  });

  group('computeRefit', () {
    test('should return null as there is no refit option', () {
      expect(computeRefit(fit: BoxFit.cover), null);
    });
    test('should return WxH as fit is cover', () {
      expect(computeRefit(fit: BoxFit.cover, refit: ''), 'WxH');
    });
    test('should return auto as fit is contain', () {
      expect(computeRefit(fit: BoxFit.contain, refit: ''), 'auto');
    });
    test(
        'should return WxH with padding as fit is cover and padding is defined',
        () {
      expect(computeRefit(fit: BoxFit.cover, refit: '15p'), 'WxH(15p)');
    });
    test(
        'should return auto with padding as fit is contain and padding is defined',
        () {
      expect(computeRefit(fit: BoxFit.contain, refit: '15p'), 'auto(15p)');
    });
    test('should return @left as anchor is set to centerLeft and fit is cover',
        () {
      expect(
          computeRefit(
              anchor: Alignment.centerLeft, fit: BoxFit.cover, refit: ''),
          'WxH@left');
    });
    test(
        'should not return @left as fit is contain even if an anchor is requested',
        () {
      expect(
          computeRefit(
              anchor: Alignment.centerLeft, fit: BoxFit.contain, refit: ''),
          'auto');
    });
    test(
        'should return padding and anchor as padding is defined, fit is cover and anchor set',
        () {
      expect(
          computeRefit(
              anchor: Alignment.centerLeft, fit: BoxFit.cover, refit: '15p,10'),
          'WxH(15p,10)@left');
    });
  });

  group('computeUrl', () {
    install(
      domain: 'https://demo.twic.pics',
    );
    test('should compute url with cover transformation', () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.cover,
            src: 'media:cat.jpg',
            viewSize: Size(width: 400, height: 300),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/cover=400x300');
    });
    test('should compute url with cover transformation and manage default step',
        () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.cover,
            src: 'media:cat.jpg',
            viewSize: Size(width: 451, height: 451),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/cover=450x450');
    });
    test('should compute url with contain transformation', () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.contain,
            src: 'media:cat.jpg',
            viewSize: Size(width: 400, height: 300),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/contain=400x300');
    });
    test('should compute url with dpr 2', () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.contain,
            src: 'media:cat.jpg',
            dpr: 2,
            viewSize: Size(width: 400, height: 300),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/contain=800x600');
    });
    test('should compute url with step = 100', () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.contain,
            src: 'media:cat.jpg',
            step: 100,
            viewSize: Size(width: 455, height: 355),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/contain=400x312');
    });
    test('should compute url with step = 100 and dpr2', () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.contain,
            src: 'media:cat.jpg',
            step: 100,
            dpr: 2,
            viewSize: Size(width: 455, height: 355),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/contain=800x624');
    });
    test('should compute url with a refit auto as fit is set to contain', () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.cover,
            src: 'media:cat.jpg',
            refit: '15p',
            viewSize: Size(width: 500, height: 500),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/refit=500x500(15p)');
    });
    test('should compute url with a refit auto as fit is set to contain', () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.contain,
            src: 'media:cat.jpg',
            refit: '15p',
            viewSize: Size(width: 500, height: 500),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/refit=auto(15p)/contain=500x500');
    });
    test('should compute url with placeholder = preview', () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.contain,
            src: 'media:cat.jpg',
            lqip: true,
            placeholder: TwicPlaceholder.preview,
            viewSize: Size(width: 400, height: 400),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/contain=1000x1000/output=preview');
    });
    test('should compute url with placeholder = maincolor', () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.contain,
            src: 'media:cat.jpg',
            lqip: true,
            placeholder: TwicPlaceholder.maincolor,
            viewSize: Size(width: 400, height: 400),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/contain=1000x1000/output=maincolor');
    });
    test(
        'should compute url with cover transformation and intrinsic dimensions greater than the size of the view ',
        () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.cover,
            src: 'media:cat.jpg',
            viewSize: Size(width: 400, height: 300),
            intrinsic: Size(width: 500, height: 500),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/cover=400x300');
    });
    test(
        'should compute url with cover transformation and intrinsic dimensions lower than the size of the view',
        () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.cover,
            src: 'media:cat.jpg',
            viewSize: Size(width: 800, height: 800),
            intrinsic: Size(width: 500, height: 500),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/cover=500x500');
    });
    test(
        'should compute url with cover transformation, intrinsic dimensions greater than the size of the view and a portrait ratio',
        () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.cover,
            src: 'media:cat.jpg',
            viewSize: Size(width: 500, height: 800),
            intrinsic: Size(width: 500, height: 500),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/cover=312x500');
    });
    test(
        'should compute url with cover transformation, intrinsic dimensions greater than the size of the view and a landscape ratio',
        () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.cover,
            src: 'media:cat.jpg',
            viewSize: Size(width: 800, height: 500),
            intrinsic: Size(width: 500, height: 500),
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/cover=500x312');
    });
    test('should compute url a refit cover transformation', () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.cover,
            src: 'media:cat.jpg',
            viewSize: Size(width: 800, height: 500),
            refit: '',
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/refit=800x500');
    });
    test('should compute url a refit auto transformation', () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.contain,
            src: 'media:cat.jpg',
            viewSize: Size(width: 800, height: 500),
            refit: '',
          )),
          'https://demo.twic.pics/cat.jpg?twic=v1/refit=auto/contain=800x500');
    });
    test('should compute url with poster = false', () {
      expect(
          computeUrl(UrlData(
            fit: BoxFit.cover,
            poster: false,
            src: 'media:video/skater.mp4',
            viewSize: Size(width: 800, height: 500),
          )),
          'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=800x500');
    });
    test('should compute url with poster = true', () {
      expect(
          computeUrl(
            UrlData(
              fit: BoxFit.cover,
              poster: true,
              src: 'media:video/skater.mp4',
              viewSize: Size(width: 800, height: 500),
            ),
          ),
          'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=800x500/output=image');
    });

    VideoOptions videoOptions = VideoOptions(
      videoTransform: '/from=2.1/to=4.5',
      posterTransform: '/from=2.1',
    );
    test('should compute url with poster = true with video slicing from, to',
        () {
      expect(
          computeUrl(
            UrlData(
              fit: BoxFit.cover,
              poster: true,
              src: 'media:video/skater.mp4',
              videoOptions: videoOptions,
              viewSize: Size(width: 800, height: 500),
            ),
          ),
          'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=800x500/from=2.1/output=image');
    });
    test('should compute url with video slicing from, to', () {
      expect(
          computeUrl(
            UrlData(
              fit: BoxFit.cover,
              src: 'media:video/skater.mp4',
              videoOptions: videoOptions,
              viewSize: Size(width: 800, height: 500),
            ),
          ),
          'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=800x500/from=2.1/to=4.5');
    });

    VideoOptions videoOptions2 = VideoOptions(
      videoTransform: '/to=3/duration=4',
      posterTransform: '',
    );
    test('should compute url with video slicing to, duration', () {
      expect(
          computeUrl(
            UrlData(
              fit: BoxFit.cover,
              src: 'media:video/skater.mp4',
              videoOptions: videoOptions2,
              viewSize: Size(width: 800, height: 500),
            ),
          ),
          'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=800x500/to=3/duration=4');
    });
    test('should compute url with poster and video slicing to, duration', () {
      expect(
          computeUrl(
            UrlData(
              fit: BoxFit.cover,
              poster: true,
              src: 'media:video/skater.mp4',
              videoOptions: videoOptions2,
              viewSize: Size(width: 800, height: 500),
            ),
          ),
          'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=800x500/output=image');
    });

    VideoOptions videoOptions3 = VideoOptions(
      videoTransform: '/to=3/duration=4',
      posterTransform: '/from=4',
    );
    test(
        'should compute url with poster and video slicing to, duration and posterFrom',
        () {
      expect(
          computeUrl(
            UrlData(
              fit: BoxFit.cover,
              poster: true,
              src: 'media:video/skater.mp4',
              videoOptions: videoOptions3,
              viewSize: Size(width: 800, height: 500),
            ),
          ),
          'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=800x500/from=4/output=image');
    });
    test(
        'should compute preview url with poster and video slicing to, duration and posterFrom',
        () {
      expect(
          computeUrl(
            UrlData(
              fit: BoxFit.cover,
              lqip: true,
              placeholder: TwicPlaceholder.preview,
              src: 'media:video/skater.mp4',
              videoOptions: videoOptions3,
              viewSize: Size(width: 800, height: 500),
            ),
          ),
          'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=1000x625/from=4/output=preview');
    });
  });
  group('computeUrls', () {
    install(
      domain: 'https://demo.twic.pics',
    );
    test('should compute urls without preview nor poster', () {
      final urls = computeUrls(
        fit: BoxFit.cover,
        placeholder: TwicPlaceholder.none,
        mediaType: MediaType.image,
        src: 'media:cat.jpg',
        viewSize: Size(width: 400, height: 300),
      );
      expect(
        urls.media,
        'https://demo.twic.pics/cat.jpg?twic=v1/cover=400x300',
      );
      expect(
        urls.placeholder,
        null,
      );
      expect(
        urls.poster,
        null,
      );
    });
    test('should compute urls with preview but no poster', () {
      final urls = computeUrls(
        fit: BoxFit.cover,
        placeholder: TwicPlaceholder.preview,
        mediaType: MediaType.image,
        src: 'media:cat.jpg',
        viewSize: Size(width: 400, height: 300),
      );
      expect(
        urls.media,
        'https://demo.twic.pics/cat.jpg?twic=v1/cover=400x300',
      );
      expect(
        urls.placeholder,
        'https://demo.twic.pics/cat.jpg?twic=v1/cover=1000x750/output=preview',
      );
      expect(
        urls.poster,
        null,
      );
    });
    test('should compute urls with preview and poster', () {
      final urls = computeUrls(
        fit: BoxFit.cover,
        placeholder: TwicPlaceholder.preview,
        mediaType: MediaType.video,
        src: 'media:video/skater.mp4',
        videoOptions: VideoOptions(
          videoTransform: '/to=3/duration=4',
          posterTransform: '/from=4',
        ),
        viewSize: Size(width: 400, height: 300),
      );
      expect(
        urls.media,
        'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=400x300/to=3/duration=4',
      );
      expect(
        urls.placeholder,
        'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=1000x750/from=4/output=preview',
      );
      expect(
        urls.poster,
        'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=400x300/from=4/output=image',
      );
    });
    test('should compute urls with poster but no preview', () {
      final urls = computeUrls(
        fit: BoxFit.cover,
        placeholder: TwicPlaceholder.none,
        mediaType: MediaType.video,
        src: 'media:video/skater.mp4',
        videoOptions: VideoOptions(
          videoTransform: '/to=3/duration=4',
          posterTransform: '/from=4',
        ),
        viewSize: Size(width: 400, height: 300),
      );
      expect(
        urls.media,
        'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=400x300/to=3/duration=4',
      );
      expect(
        urls.placeholder,
        null,
      );
      expect(
        urls.poster,
        'https://demo.twic.pics/video/skater.mp4?twic=v1/cover=400x300/from=4/output=image',
      );
    });
  });
  group('computeViewSize', () {
    test('should compute viewSize with ratio="1"', () {
      Size viewSize = computeViewSize(width: 1000, ratio: 1);
      expect(viewSize.height, 1000);
      expect(viewSize.width, 1000);
    });

    test('should compute viewSize with ratio="2"', () {
      Size viewSize = computeViewSize(width: 1000, ratio: 1 / (2));
      expect(viewSize.height, 500);
      expect(viewSize.width, 1000);
    });

    test('ratio should take precedence over height', () {
      Size viewSize =
          computeViewSize(width: 1000, height: 1000, ratio: 1 / (2));
      expect(viewSize.height, 500);
      expect(viewSize.width, 1000);
    });

    test('should handle hero asset aka ratio = "none"', () {
      Size viewSize = computeViewSize(width: 800, height: 600, ratio: 0);
      expect(viewSize.height, 600);
      expect(viewSize.width, 800);
    });

    test('should throw an exception when unconstrained width', () {
      try {
        computeViewSize(width: 0, height: 1000, ratio: 1);
        throw ('expected exception but none received');
      } on ArgumentError catch (e) {
        expect(e.message, buildErrorMessage('unconstrained width'));
      }
      try {
        computeViewSize(width: double.infinity, height: 1000, ratio: 1);
        throw ('expected exception but none received');
      } on ArgumentError catch (e) {
        expect(e.message, buildErrorMessage('unconstrained width'));
      }
    });

    test('should throw an exception when unconstrained height', () {
      try {
        computeViewSize(width: 1000, height: double.infinity, ratio: 0);
        throw ('expected exception but none received');
      } on ArgumentError catch (e) {
        expect(e.message, buildErrorMessage('unconstrained height'));
      }
      try {
        computeViewSize(width: 1000, height: 0, ratio: 0);
        throw ('expected exception but none received');
      } on ArgumentError catch (e) {
        expect(e.message, buildErrorMessage('unconstrained height'));
      }
    });
  });
}
