//
//  UICollectionView+Reusable.swift
//  NyghtwelTools
//
//  Created by Alan Liou on 12/17/19.
//  Copyright © 2019 Nyghtwel, Inc. All rights reserved.
//

import UIKit

private struct AssociatedObjectKey {
    static var registeredCells = "registeredCollectionViewCells"
}

extension UICollectionReusableView: Reusable {}

/** Adding ability to auto register cells when dequeue is called on collection views*/
extension UICollectionView {

    private var registeredCells: Set<String> {
        get {
            if objc_getAssociatedObject(self, &AssociatedObjectKey.registeredCells) as? Set<String> == nil {
                self.registeredCells = Set<String>()
            }
            return (objc_getAssociatedObject(self, &AssociatedObjectKey.registeredCells) as? Set<String>) ?? []
        }

        set(newValue) {
            objc_setAssociatedObject(
				self,
				&AssociatedObjectKey.registeredCells,
				newValue,
				objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private func register<T: UICollectionViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)

        if bundle.path(forResource: T.reuseIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: T.reuseIdentifier, bundle: bundle)
            register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }

    /** Dequeue a cell and automatically register it */
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        if !registeredCells.contains(T.reuseIdentifier) {
            registeredCells.insert(T.reuseIdentifier)
            register(T.self)
        }

        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Error dequeuing cell with reuse identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
		ofKind kind: String,
		for indexPath: IndexPath
	) -> T {
        if !registeredCells.contains(T.reuseIdentifier) {
            registeredCells.insert(T.reuseIdentifier)
            registerSupplementaryView(T.self, kind: kind)
        }
        guard let view = dequeueReusableSupplementaryView(
			ofKind: kind,
			withReuseIdentifier: T.reuseIdentifier,
			for: indexPath) as? T
		else {
			fatalError("Error dequeuing suplementary view of kind: \(kind) with reuse identifier: \(T.reuseIdentifier)")
		}
        return view
    }

    private func registerSupplementaryView<T: UICollectionReusableView>(_: T.Type, kind: String) {
        let bundle = Bundle(for: T.self)

        if bundle.path(forResource: T.reuseIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: T.reuseIdentifier, bundle: bundle)
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        } else {
            register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        }
    }
}

