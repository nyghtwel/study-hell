//
//  UIView+Utils.swift
//  NyghtwelTools
//
//  Created by Alan Liou on 12/17/19.
//  Copyright © 2019 Nyghtwel, Inc. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult func backgroundColor<T: UIView>(_ color: UIColor) -> T {
        backgroundColor = color
        guard let result = self as? T else { fatalError() }
        return result
    }

	@discardableResult func isHidden<T: UIView> (_ isHidden: Bool) -> T {
		self.isHidden = isHidden
		guard let result = self as? T else { fatalError() }
		return result
	}

	@discardableResult func borderWidth<T: UIView>(_ width: CGFloat) -> T {
		layer.borderWidth = width
		guard let result = self as? T else { fatalError() }
		return result
	}

	@discardableResult func borderColor<T: UIView>(_ color: UIColor) -> T {
		layer.borderColor = color.cgColor
		guard let result = self as? T else { fatalError() }
		return result
	}

	@discardableResult func addSublayer(_ layer: CALayer) -> UIView {
		layer.addSublayer(layer)
		return self
	}

    @discardableResult func clipsToBounds<T: UIView>(_ clip: Bool) -> T {
        self.clipsToBounds = clip
        guard let result = self as? T else { fatalError() }
        return result
    }
}

