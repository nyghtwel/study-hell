//
//  String+Utils.swift
//  NyghtwelTools
//
//  Created by Alan Liou on 12/17/19.
//  Copyright © 2019 Nyghtwel, Inc. All rights reserved.
//

import Foundation

extension String {

	/// Syntactic sugar for string localization from a file.
	/// Usage examples are:
	func localizedFrom(_ file: LocalizedFile) -> String {
		return NSLocalizedString(self, tableName: file.rawValue, bundle: Bundle.main, value: "", comment: "")
	}

	enum LocalizedFile: String {
		case media = "mock"
	}
}

