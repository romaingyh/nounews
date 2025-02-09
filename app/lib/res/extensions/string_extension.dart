const _diacriticChars = 'àáâãäåòóôõöøèéêëðçìíîïùúûüñšÿýž';
const _noDiacriticChars = 'aaaaaaooooooeeeeeciiiiuuuunsyyz';

extension StringExtension on String {
  String get capitalizeFirst {
    final value = this;
    if (value.isEmpty) return this;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  // removes all accents and special characters
  String get normalize {
    final value = this;

    if (value.isEmpty) return this;

    return normalizeKeepSpaces.replaceAll(' ', '');
  }

  String get normalizeKeepSpaces {
    final value = this;

    if (value.isEmpty) return this;

    final regex = RegExp(r'[^\w\s]+');

    return value.toLowerCase().withoutDiacritics.replaceAll(regex, '');
  }

  String get withoutDiacritics {
    var value = this;

    for (int i = 0; i < _diacriticChars.length; i++) {
      value = value.replaceAll(_diacriticChars[i], _noDiacriticChars[i]);
    }

    return value;
  }
}
