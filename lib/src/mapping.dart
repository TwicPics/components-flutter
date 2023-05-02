import 'package:flutter/widgets.dart' hide Placeholder;
import 'package:twicpics_components/src/types.dart';

final Map<Alignment, String> mappingAlignment = {
    Alignment.bottomCenter: 'bottom',
    Alignment.bottomLeft: 'bottom-left',
    Alignment.bottomRight: 'bottom-right',
    Alignment.center: 'center',
    Alignment.centerLeft: 'left',
    Alignment.centerRight: 'right',
    Alignment.topCenter: 'top',
    Alignment.topLeft: 'top-left',
    Alignment.topRight: 'top-right',
};

final Map<BoxFit, String> mappingFit = {
    BoxFit.contain: 'contain',
    BoxFit.cover: 'cover',
};

final Map<TwicPlaceholder, String> mappingPlaceholder = {
    TwicPlaceholder.maincolor: 'maincolor',
    TwicPlaceholder.meancolor: 'meancolor',
    TwicPlaceholder.none: '',
    TwicPlaceholder.preview: 'preview',
};