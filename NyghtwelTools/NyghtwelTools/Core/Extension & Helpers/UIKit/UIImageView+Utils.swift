//
//  UIImageView+Utils.swift
//  NyghtwelTools
//
//  Created by Alan Liou on 12/17/19.
//  Copyright © 2019 Nyghtwel, Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
	@discardableResult func image(_ image: UIImage?) -> UIImageView {
		self.image = image
		return self
	}

	@discardableResult func image(_ image: String) -> UIImageView {
		let image = UIImage(named: image)
		self.image = image
		return self
	}

	@discardableResult func contentMode(_ mode: ContentMode) -> UIImageView {
		self.contentMode = mode
		return self
	}

	@discardableResult func isHidden(_ isHidden: Bool) -> UIImageView {
		self.isHidden = isHidden
		return self
	}

	@discardableResult func isUserInteractionEnabled(_ enabled: Bool) -> UIImageView {
		isUserInteractionEnabled = enabled
		return self
	}
}
