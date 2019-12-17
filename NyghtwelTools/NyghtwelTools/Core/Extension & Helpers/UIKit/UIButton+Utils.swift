//
//  UIButton+Utils.swift
//  NyghtwelTools
//
//  Created by Alan Liou on 12/17/19.
//  Copyright © 2019 Nyghtwel, Inc. All rights reserved.
//

import UIKit

/*
	Supports SwiftUI.programmatic way of creating UIButton
	If you want to change the button type, then type must be called at the end
*/
extension UIButton {
	@discardableResult func text(_ title: String) -> UIButton {
		setTitle(title, for: .normal)
		return self
	}

	@discardableResult func textColor(_ color: UIColor) -> UIButton {
		setTitleColor(color, for: .normal)
		return self
	}

	@discardableResult func font(_ font: UIFont) -> UIButton {
		titleLabel?.font = font
		return self
	}

    @discardableResult func titleEdgeInsets(_ insets: UIEdgeInsets) -> UIButton {
        contentEdgeInsets = insets
        return self
    }

	@discardableResult func backgroundColor(_ color: UIColor) -> UIButton {
		backgroundColor = color
		return self
	}

	// Not sure if adding target to self here would work need to test to verify
	@discardableResult func target(_ target: Any?, action: Selector) -> UIButton {
		addTarget(target, action: action, for: .touchUpInside)
		return self
	}

	@discardableResult func image(_ image: UIImage?) -> UIButton {
		setImage(image, for: .normal)
		return self
	}

	@discardableResult func image(_ image: String) -> UIButton {
		let image = UIImage(named: image)
		setImage(image, for: .normal)
		return self
	}

	@discardableResult func tintColor(_ color: UIColor) -> UIButton {
		tintColor = color
		return self
	}

	@discardableResult func onTouchUpInside(_ closure: @escaping UIButtonTargetClosure) -> UIButton {
		targetClosure = closure
		addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
		return self
	}

	@discardableResult func roundCorners(
		_ corners: CACornerMask =
			[.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner],
		radius: CGFloat
    ) -> UIButton {

		clipsToBounds = true
		// this needs to be set to false to apply to shadows
		layer.masksToBounds = false
		if #available(iOS 11, *) {
			layer.cornerRadius = radius
			layer.maskedCorners = corners
		} else {
			var cornerMask = UIRectCorner()
			if corners.contains(.layerMinXMinYCorner) { cornerMask.insert(.topLeft) }
			if corners.contains(.layerMaxXMinYCorner) { cornerMask.insert(.topRight) }
			if corners.contains(.layerMinXMaxYCorner) { cornerMask.insert(.bottomLeft) }
			if corners.contains(.layerMaxXMaxYCorner) { cornerMask.insert(.bottomRight) }
			let path = UIBezierPath(
				roundedRect: self.bounds,
				byRoundingCorners: cornerMask,
				cornerRadii: CGSize(width: radius, height: radius))

			let mask = CAShapeLayer()
			mask.path = path.cgPath
			self.layer.mask = mask
		}
        return self
	}
}

typealias UIButtonTargetClosure = (UIButton) -> Void

class UIButtonClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}

extension UIButton {
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }

    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard
				let closureWrapper =
					objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIButtonClosureWrapper
				else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(
				self,
				&AssociatedKeys.targetClosure,
				UIButtonClosureWrapper(newValue),
				objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}

