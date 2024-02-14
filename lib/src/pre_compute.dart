import 'package:twicpics_components/src/types.dart';

VideoOptions preComputeVideoOptions( {
    num? duration,
    num? from,
    num? posterFrom,
    num? to,
} ) {
    return VideoOptions(
        videoTransform: '${
                from != null ? '/from=$from' : ''
            }${
                to != null ? '/to=$to' : ''
            }${
                duration != null ? '/duration=$duration' : ''
            }',
        posterTransform: ( posterFrom != null || from != null ) ?
            '/from=${ posterFrom ?? from }' :
            ''
    );
}