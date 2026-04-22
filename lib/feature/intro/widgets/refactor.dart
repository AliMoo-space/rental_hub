import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/feature/localization/presentation/cubit/locale_cubit.dart';
import 'package:rental_hub/l10n/app_localizations.dart';

class IntroLanguageButton extends StatelessWidget {
  const IntroLanguageButton({
    required this.l10n,
    this.iconColor = Colors.black,
    super.key,
  });

  final AppLocalizations l10n;
  final Color iconColor;

  String _localizedLanguageName(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return l10n.arabic;
      case 'en':
        return l10n.english;
      default:
        return languageCode.toUpperCase();
    }
  }

  Future<void> _showLanguageSheet(
    BuildContext context,
    String currentLanguageCode,
  ) {
    final supportedLocales = AppLocalizations.supportedLocales;

    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  l10n.language,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              ...supportedLocales.map((locale) {
                final isSelected = locale.languageCode == currentLanguageCode;

                return ListTile(
                  title: Text(_localizedLanguageName(locale.languageCode)),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () async {
                    await context.read<LocaleCubit>().setLanguage(
                      languageCode: locale.languageCode,
                      supportedLocales: supportedLocales,
                    );

                    if (sheetContext.mounted) {
                      Navigator.of(sheetContext).pop();
                    }
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localeCode = context.select(
      (LocaleCubit cubit) => cubit.state.locale.languageCode,
    );

    return IconButton(
      onPressed: () => _showLanguageSheet(context, localeCode),
      tooltip:
          '${l10n.language}: ${localeCode == 'ar' ? l10n.english : l10n.arabic}',
      icon: Icon(Icons.language, color: iconColor, size: 24.sp),
    );
  }
}
