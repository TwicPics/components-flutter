import 'package:flutter_test/flutter_test.dart';
import 'package:twicpics_components/src/install.dart';

void main() {
  group('Install domain', () {
    test('should accept https domain', () {
      install(domain: 'https://demo.twic.pics');
      expect(config.domain, 'https://demo.twic.pics');
    });

    test('should accept http domain', () {
      install(domain: 'http://demo.twic.pics');
      expect(config.domain, 'http://demo.twic.pics');
    });

    test('should accept and parse domain with a trailing slash', () {
      install(domain: 'https://demo.twic.pics/');
      expect(config.domain, 'https://demo.twic.pics');
    });

    test('should accept and parse domain with a trailing slashes', () {
      install(domain: 'https://demo.twic.pics//');
      expect(config.domain, 'https://demo.twic.pics');
    });

    test('should accept custom domain', () {
      install(domain: 'https://my.custom.domain');
      expect(config.domain, 'https://my.custom.domain');
    });

    test('should throw an exception on invalid domain', () {
      try {
        install(domain: 'htt://demo.twic.pics');
        throw ('expected exception but none received');
      } on ArgumentError catch (e) {
        expect(e.message, 'install domain "htt://demo.twic.pics" is invalid');
      }
    });
  });

  group('Install path', () {
    test('should initialize an empty path', () {
      install(
        domain: 'https://demo.twic.pics',
      );
      expect(config.path, '');
    });

    test('should parse path with a traling slash', () {
      install(domain: 'https://demo.twic.pics', path: 'my-path');
      expect(config.path, 'my-path/');
    });

    test('should remove the slash at the beginning and end ', () {
      install(domain: 'https://demo.twic.pics', path: '//my-path//');
      expect(config.path, 'my-path/');
    });

    test('should throw an exception when path is invalid', () {
      try {
        install(domain: 'https://demo.twic.pics', path: '/');
        throw ('expected exception but none received');
      } on ArgumentError catch (e) {
        expect(e.message, 'install path "/" is invalid');
      }
    });
  });
  group('Install Cache options', () {
    test('should init with cacheCleanOnStartUp = false by default', () {
      install(
        domain: 'https://demo.twic.pics',
      );
      expect(config.cacheCleanOnStartUp, false);
    });
    test('should init cacheCleanOnStartUp to true', () {
      install(domain: 'https://demo.twic.pics', cacheCleanOnStartUp: true);
      expect(config.cacheCleanOnStartUp, true);
    });
    test('should init cacheCleanOnStartUp to false', () {
      install(domain: 'https://demo.twic.pics', cacheCleanOnStartUp: false);
      expect(config.cacheCleanOnStartUp, false);
    });
  });

  group('Install debug', () {
    test('should init debug with false', () {
      install(
        domain: 'https://demo.twic.pics',
      );
      expect(config.debug, false);
    });

    test('should config debug to false', () {
      install(domain: 'https://demo.twic.pics', debug: false);
      expect(config.debug, false);
    });

    test('should config debug to true', () {
      install(domain: 'https://demo.twic.pics', debug: true);
      expect(config.debug, true);
    });
  });

  group('Install step', () {
    test('should init step to 50', () {
      install(
        domain: 'https://demo.twic.pics',
      );
      expect(config.step, 50);
    });
    test('should config step to 100', () {
      install(domain: 'https://demo.twic.pics', step: 100);
      expect(config.step, 100);
    });
  });

  group('Install maxDpr', () {
    test('should init maxDpr to 2', () {
      install(
        domain: 'https://demo.twic.pics',
      );
      expect(config.maxDpr, 2);
    });

    test('should config maxDpr to 3', () {
      install(domain: 'https://demo.twic.pics', maxDpr: 3);
      expect(config.maxDpr, 3);
    });
  });
}
