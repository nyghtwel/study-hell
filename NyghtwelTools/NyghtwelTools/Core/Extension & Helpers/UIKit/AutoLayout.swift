//
//  AutoLayout.swift
//  NyghtwelTools
//
//  Created by Alan Liou on 12/17/19.
//  Copyright © 2019 Nyghtwel, Inc. All rights reserved.
//

import UIKit

extension UIView {
	/// Anchors a UIView's center X-axis to its parent's view center X-axis plus constant
	/// - parameter constant: CGFloat = 0
	public func anchorCenterXToSuperview(constant: CGFloat = 0) {
		translatesAutoresizingMaskIntoConstraints = false
		if let anchor = superview?.centerXAnchor {
			centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
		}
	}

	public func anchor(width: CGFloat? = nil, height: CGFloat? = nil) {
		translatesAutoresizingMaskIntoConstraints = false
		var constraints = [NSLayoutConstraint]()
		if let width = width {
			constraints.append(widthAnchor.constraint(equalToConstant: width))
		}
		if let height = height {
			constraints.append(heightAnchor.constraint(equalToConstant: height))
		}
		NSLayoutConstraint.activate(constraints)
	}

	/// Anchors a UIView's center Y-axis to its parent's view center Y-axis plus constant
	/// - parameter constant: CGFloat = 0
	public func anchorCenterYToSuperview(constant: CGFloat = 0) {
		translatesAutoresizingMaskIntoConstraints = false
		if let anchor = superview?.centerYAnchor {
			centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
		}
	}

	/// Anchors a UIView's center Y-axis and center X-axis to its parent's center Y-axis and center
	/// X-axis
	public func anchorCenterXAndYToSuperview() {
		translatesAutoresizingMaskIntoConstraints = false
		guard let superView = superview else { return }
		NSLayoutConstraint.activate([
			self.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
			self.centerYAnchor.constraint(equalTo: superView.centerYAnchor)
		])
	}

	/// Anchors a UIView to fill to the constraints of its parent's view
    public func anchorFillToSuperview(padding: UIEdgeInsets = .zero) {
		translatesAutoresizingMaskIntoConstraints = false
		guard let superView = superview else { return }
		NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: padding.top),
            self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: padding.left),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -padding.bottom),
            self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -padding.right)
		])
	}

	/// Adds all the given views as a subview to the view
	/// - parameter views: UIView...
	public func addSubview(_ views: UIView...) {
		for view in views { addSubview(view) }
	}

	/// Adds a subview and constrains it to fill available space.
	///
	/// - Parameter with: The view to add and constrain to fill.
	///
	public func fill(with subview: UIView) {
		self.addSubview(subview)
		NSLayoutConstraint.activate([
			subview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			subview.topAnchor.constraint(equalTo: self.topAnchor),
			subview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			subview.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}

	/// Applies constraint to a view and also sets its translatesAutoresizingMaskIntoConstraints to be false
	/// - Parameter: LayoutConstraints
	//swiftlint:disable cyclomatic_complexity
	//swiftlint:disable function_body_length
	public func applyConstraints(_ constraints: LayoutConstraints...) {
		translatesAutoresizingMaskIntoConstraints = false
		var layouts: [NSLayoutConstraint] = []

		constraints.forEach { constraint in
			switch constraint {
			case .topEqualTo(let anchor, let constant):
				layouts.append(topAnchor.constraint(equalTo: anchor, constant: constant))

			case .topLessThanOrEqualTo(let anchor, let constant):
				layouts.append(topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant))

			case .topGreaterThanOrEqualTo(let anchor, let constant):
				layouts.append(topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant))

			case .leftEqualTo(let anchor, let constant):
				layouts.append(leftAnchor.constraint(equalTo: anchor, constant: constant))

			case .leftLessThanOrEqualTo(let anchor, let constant):
				layouts.append(leftAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant))

			case .leftGreaterThanOrEqualTo(let anchor, let constant):
				layouts.append(leftAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant))

			case .leadingEqualTo(let anchor, let constant):
				layouts.append(leadingAnchor.constraint(equalTo: anchor, constant: constant))

			case .leadingLessThanOrEqualTo(let anchor, let constant):
				layouts.append(leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant))

			case .leadingGreaterThanOrEqualTo(let anchor, let constant):
				layouts.append(leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant))

			case .rightEqualTo(let anchor, let constant):
				layouts.append(rightAnchor.constraint(equalTo: anchor, constant: constant))

			case .rightLessThanOrEqualTo(let anchor, let constant):
				layouts.append(rightAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant))

			case .rightGreaterThanOrEqualTo(let anchor, let constant):
				layouts.append(rightAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant))

			case .trailingEqualTo(let anchor, let constant):
				layouts.append(trailingAnchor.constraint(equalTo: anchor, constant: constant))

			case .trailingLessThanOrEqualTo(let anchor, let constant):
				layouts.append(trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant))

			case .trailingGreaterThanOrEqualTo(let anchor, let constant):
				layouts.append(trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant))

			case  .bottomEqualTo(let anchor, let constant):
				layouts.append(bottomAnchor.constraint(equalTo: anchor, constant: constant))

			case .bottomLessThanOrEqualTo(let anchor, let constant):
				layouts.append(bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant))

			case .bottomGreaterThanOrEqualTo(let anchor, let constant):
				layouts.append(bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant))

			case .widthEqualToConstant(let constant):
				layouts.append(widthAnchor.constraint(equalToConstant: constant))

			case .widthEqualToAnchor(let anchor):
				layouts.append(widthAnchor.constraint(equalTo: anchor))

			case .heightEqualToConstant(let constant):
				layouts.append(heightAnchor.constraint(equalToConstant: constant))

			case .heightEqualToAnchor(let anchor):
				layouts.append(heightAnchor.constraint(equalTo: anchor))

			case .centerXEqualTo(let anchor, let constant):
				layouts.append(centerXAnchor.constraint(equalTo: anchor, constant: constant))

			case .centerYEqualTo(let anchor, let constant):
				layouts.append(centerYAnchor.constraint(equalTo: anchor, constant: constant))
			}
		}
		NSLayoutConstraint.activate(layouts)
	}

	@discardableResult open func height<T: UIView>(
		_ height: CGFloat,
		_ completion: (_ view: UIView) -> Void = { _ in }
	) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        guard let result = self as? T else { fatalError() }
		completion(result)
        return result
    }

	@discardableResult open func width<T: UIView>(
		_ width: CGFloat,
		_ completion: (_ view: UIView) -> Void = { _ in }
	) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        guard let result = self as? T else { fatalError() }
		completion(result)
        return result
    }

	open func append<T: UIView>(_ completion: () -> Void = {}) -> T {
		guard let result = self as? T else { fatalError() }
		completion()
		return result
	}
}

public enum LayoutConstraints {
	case topEqualTo(NSLayoutYAxisAnchor, constant: CGFloat = 0)
	case topLessThanOrEqualTo(NSLayoutYAxisAnchor, constant: CGFloat = 0)
	case topGreaterThanOrEqualTo(NSLayoutYAxisAnchor, constant: CGFloat = 0)

	case leftEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)
	case leftLessThanOrEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)
	case leftGreaterThanOrEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)

	case leadingEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)
	case leadingLessThanOrEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)
	case leadingGreaterThanOrEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)

	case rightEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)
	case rightLessThanOrEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)
	case rightGreaterThanOrEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)

	case trailingEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)
	case trailingLessThanOrEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)
	case trailingGreaterThanOrEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)

	case bottomEqualTo(NSLayoutYAxisAnchor, constant: CGFloat = 0)
	case bottomLessThanOrEqualTo(NSLayoutYAxisAnchor, constant: CGFloat = 0)
	case bottomGreaterThanOrEqualTo(NSLayoutYAxisAnchor, constant: CGFloat = 0)

	case widthEqualToConstant(CGFloat)
	case widthEqualToAnchor(NSLayoutDimension)

	case heightEqualToConstant(CGFloat)
	case heightEqualToAnchor(NSLayoutDimension)

	case centerXEqualTo(NSLayoutXAxisAnchor, constant: CGFloat = 0)
	case centerYEqualTo(NSLayoutYAxisAnchor, constant: CGFloat = 0)
}

