import 'package:twicpics_components/src/types.dart';
import 'package:twicpics_components/src/validate.dart';
import 'package:visibility_detector/visibility_detector.dart';

Config config = Config();

void install( {
    bool? cacheCleanOnStartUp,
    Duration? cacheStalePeriod,
    int? cacheMaxNrOfObjects,
    bool? debug,
    String domain = '',
    double? maxDpr,
    String? path,
    int? step,
    Duration? visibilityUpdateInterval,
} ) {
    if ( rValidDomain.hasMatch( domain ) ) {
        config.domain = domain;
    } else {
        throw ArgumentError( 'install domain "$domain" is invalid' );
    }
    if ( path != null && rInvalidPath.hasMatch( path ) ) {
        throw ArgumentError( 'install path "$path" is invalid' );
    }
    config.domain = rValidDomain.firstMatch( domain )!.group( 1 )!;
    config.path = config.path = path != null ? '${rValidPath.firstMatch( path )!.group( 1 )!}/' : '';

    if ( cacheCleanOnStartUp != null ) {
        config.cacheCleanOnStartUp = cacheCleanOnStartUp;
    }
    if ( cacheStalePeriod != null ) {
        config.cacheStalePeriod = cacheStalePeriod;
    }
    if ( cacheMaxNrOfObjects != null ) {
        config.cacheMaxNrOfObjects = cacheMaxNrOfObjects;
    }
    if ( debug != null ) {
        config.debug = debug;
    }
    if ( maxDpr != null ) {
        config.maxDpr = maxDpr;
    }
    if ( step != null ) {
        config.step = step;
    }
    VisibilityDetectorController.instance.updateInterval = visibilityUpdateInterval ??  const Duration(milliseconds: 50);
}
