//
//  UILabel+Utils.swift
//  NyghtwelTools
//
//  Created by Alan Liou on 12/17/19.
//  Copyright © 2019 Nyghtwel, Inc. All rights reserved.
//

import UIKit
import Combine

/*
	Supports programmatic style of creating UILabels similar to SwiftUI.
	Ex:
		let text = UILabel().text("hello")
			.textColor(.black)
			.textAlignment(.center)
			.numberOfLines(0)
			.font(.systemFont(ofSize: 14))
*/
extension UILabel {
	/// This should not be used but is here for hot fixes.
	@discardableResult func font(_ font: UIFont) -> UILabel {
		self.font = font
		return self
	}

	@discardableResult func text(_ text: String) -> UILabel {
		self.text = text
		return self
	}

	@discardableResult func textColor(_ textColor: UIColor) -> UILabel {
		self.textColor = textColor
		return self
	}

	@discardableResult func textAlignment(_ textAlignment: NSTextAlignment) -> UILabel {
		self.textAlignment = textAlignment
		return self
	}

	@discardableResult func numberOfLines(_ numberOfLines: Int) -> UILabel {
		self.numberOfLines = numberOfLines
		return self
	}

	@discardableResult func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> UILabel {
		self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
		return self
	}

	@discardableResult func htmlText(_ text: String, encoding: String.Encoding = .utf16) -> UILabel {
		let fontName = font.fontName
		let fontSize = font.pointSize
		let color = textColor.hex ?? "black"
		// Decided to go the style route instead of addAttributes route bc addAttributes does not respect the <b> or <i>
		// properties
		let htmlText = """
			<style>
				html * {
					font-size: \(fontSize);
					color: #\(color);
					font-family: \(fontName);
				}
			</style> \(text)
		"""

		let options: [NSAttributedString.DocumentReadingOptionKey: Any] =
			[.documentType: NSAttributedString.DocumentType.html]

		if let data = htmlText.data(using: .utf16),
			let attributedText = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
			self.attributedText = attributedText
		}
		return self
	}
}
