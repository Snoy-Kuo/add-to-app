//
//  LanguageUtil.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/7/2.
//

import LanguageManager_iOS

public extension String {

  ///
  /// Localize the current string to the selected language
  ///
  /// - returns: The localized string
  ///
  func l10n(comment: String = "") -> String {
    guard let bundle = Bundle.main.path(forResource: LanguageManager.shared.currentLanguage.rawValue, ofType: "lproj") else {
        return NSLocalizedString(self, comment: comment)
    }

    let langBundle = Bundle(path: bundle)
    return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: comment)
  }

}
