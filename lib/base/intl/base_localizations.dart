import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class _BaseLocalizations {
  final Locale locale;
  const _BaseLocalizations(this.locale);
  Object getItem(String key);
  String get cancelText => getItem('cancelText');
  String get confirmText => getItem('confirmText');
  String get tip => getItem('tip');
  String get empty => getItem('empty');
  String get error => getItem('error');
  String get loading => getItem('loading');
  String get unknown => getItem('unknown');
  String get errorTip => getItem('errorTip');
  String get retryText => getItem('retryText');
  String get retryLoadingText => getItem('retryLoadingText');
  String get exitTip => getItem('exitTip');
  String get searchText => getItem('searchText');
}

/// localizations
class BaseLocalizations extends _BaseLocalizations {
  static BaseLocalizations _static = new BaseLocalizations(null);
  const BaseLocalizations(Locale locale) : super(locale);

  static const BaseLocalizationsDelegate delegate =
      const BaseLocalizationsDelegate();

  @override
  Object getItem(String key) {
    Map localData;
    if (locale != null) {
      if (locale.languageCode == 'en') {
        localData = localizedValues[locale.languageCode];
      }
      if (locale.languageCode == 'zh') {
        if (locale.countryCode == 'TW' || locale.scriptCode == 'Hant') {
          localData = localizedValues['zh_Hant'];
        } else {
          localData = localizedValues['zh_Hans'];
        }
      }
      if (locale.languageCode == 'pt') {
        localData = localizedValues['pt_PT'];
      }
    }

    if (localData == null) return localizedValues['en'][key];
    return localData[key];
  }

  static BaseLocalizations of(BuildContext context) {
    return Localizations.of<BaseLocalizations>(context, BaseLocalizations) ??
        _static;
  }

  /// Language Values
  static const Map<String, Map<String, Object>> localizedValues = {
    'en': {
      'cancelText': 'Cancel',
      'confirmText': 'Confirm',
      'tip': "Tips",
      'empty': "empty!",
      'error': "error!",
      'errorTip': "load data error",
      'loading': "loading...",
      'unknown': 'unknown error',
      'retryText': "Try again",
      'retryLoadingText': "Try again...",
      'exitTip': "Double-click on the exit",
      'searchText': "Search"
    },
    'zh_Hans': {
      'cancelText': '取消',
      'confirmText': '确定',
      'tip': "提示",
      'empty': "空空如也~",
      'error': "出错了!",
      'errorTip': "加载数据出错",
      'loading': "加载中...",
      'unknown': '未知错误',
      'retryText': "点击重试",
      'retryLoadingText': "重试中...",
      'exitTip': "双击退出",
      'searchText': "搜索"
    },
    'zh_Hant': {
      'cancelText': '取消',
      'confirmText': '確定',
      'tip': "提示",
      'empty': "空空如也~",
      'error': "出錯了!",
      'errorTip': "加載數據出錯",
      'loading': "加載中...",
      'unknown': '未知錯誤',
      'retryText': "點擊重試",
      'retryLoadingText': "重試中...",
      'exitTip': "雙擊退出",
      'searchText': "搜索"
    },
    'pt_PT': {
      'cancelText': 'cancelar',
      'confirmText': 'confirmar',
      'tip': "Dicas",
      'empty': "Vazio ~",
      'error': "Erro!",
      'errorTip': "Erro Ao carregar dados",
      'loading': "Carregando...",
      'unknown': 'Erro Desconhecido',
      'retryText': "Repertório",
      'retryLoadingText': "Retirando...",
      'exitTip': "Clique duplo para sair",
      'searchText': "Pesquisa"
    },
  };
}

/// picker localizations
class BaseLocalizationsDelegate
    extends LocalizationsDelegate<BaseLocalizations> {
  const BaseLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<BaseLocalizations> load(Locale locale) {
    return SynchronousFuture<BaseLocalizations>(new BaseLocalizations(locale));
  }

  @override
  bool shouldReload(BaseLocalizationsDelegate old) => false;
}
