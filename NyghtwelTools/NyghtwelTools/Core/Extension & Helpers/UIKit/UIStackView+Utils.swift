//
//  UIStackView+Utils.swift
//  NyghtwelTools
//
//  Created by Alan Liou on 12/17/19.
//  Copyright © 2019 Nyghtwel, Inc. All rights reserved.
//

import UIKit

// Supporta a more SwiftUI/programmatic way of creating views using stackviews
@available(iOS 9.0, *)
extension UIView {
	@discardableResult open func vstack(_ views: UIView...) -> UIStackView {
		return _stack(.vertical, views: views)
	}

	@discardableResult open func hstack(_ views: UIView...) -> UIStackView {
		return _stack(.horizontal, views: views)
	}

	// swiftlint:disable identifier_name
	@discardableResult open func _vstack(_ views: [UIView]) -> UIStackView {
		return _stack(.vertical, views: views)
	}

	@discardableResult open func _hstack(_ views: [UIView]) -> UIStackView {
		return _stack(.horizontal, views: views)
	}

	@discardableResult open func vScrollingStack(_ views: UIView...) -> UIStackView {
		let scrollView = UIScrollView()
		addSubview(scrollView)
		scrollView.anchorFillToSuperview()

		let stackView = scrollView._stack(views: views)
		stackView.applyConstraints(.widthEqualToAnchor(scrollView.widthAnchor))
		return stackView
	}

	fileprivate func _stack(
		_ axis: NSLayoutConstraint.Axis = .vertical,
		views: [UIView],
		spacing: CGFloat = 0,
		alignment: UIStackView.Alignment = .fill,
		distribution: UIStackView.Distribution = .fill
	) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        addSubview(stackView)
        stackView.anchorFillToSuperview()
        return stackView
    }
}

extension UIStackView {
    @discardableResult open func margins(_ margins: UIEdgeInsets) -> UIStackView {
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }

    @discardableResult open func padLeft(_ left: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = left
        return self
    }

    @discardableResult open func padTop(_ top: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = top
        return self
    }

    @discardableResult open func padBottom(_ bottom: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.bottom = bottom
        return self
    }

    @discardableResult open func padRight(_ right: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.right = right
        return self
    }

	@discardableResult open func spacing(_ spacing: CGFloat) -> UIStackView {
		self.spacing = spacing
		return self
	}

	@discardableResult open func alignment(_ alighment: UIStackView.Alignment) -> UIStackView {
		self.alignment = alighment
		return self
	}

	@discardableResult open func distribution(_ distribution: UIStackView.Distribution) -> UIStackView {
		self.distribution = distribution
		return self
	}
}

extension UIEdgeInsets {
	static public func allSides(_ side: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: side, left: side, bottom: side, right: side)
	}
}

extension UIStackView {
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
            let removedSubviews = arrangedSubviews.reduce([]) { removedSubviews, subview -> [UIView] in
                self.removeArrangedSubview(subview)
                NSLayoutConstraint.deactivate(subview.constraints)
                subview.removeFromSuperview()
                return removedSubviews + [subview]
            }
            return removedSubviews
        }
}

