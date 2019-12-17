//
//  UISwitch+Utils.swift
//  NyghtwelTools
//
//  Created by Alan Liou on 12/17/19.
//  Copyright © 2019 Nyghtwel, Inc. All rights reserved.
//

import UIKit

extension UISwitch {
    @discardableResult func onValueChanged(_ closure: @escaping UISwitchTargetClosure) -> UISwitch {
        targetClosure = closure
        addTarget(self, action: #selector(UISwitch.closureAction), for: .valueChanged)
        return self
    }

//    @discardableResult func bind(_ binding: Binding<Bool>) -> UISwitch {
//        binding.sink { value in
//            self.isOn = value
//        }
//
//        onValueChanged { uiSwitch in
//            binding.wrappedValue = uiSwitch.isOn
//        }
//        return self
//    }

	@discardableResult func onTintColor(_ color: UIColor) -> UISwitch {
		onTintColor = color
		return self
	}

	/// Assumes the default height of switch is 31px
	@discardableResult func offTintColor(_ color: UIColor) -> UISwitch {
		// Plus 1 to avoid the outline I see in the background
		layer.cornerRadius = frame.height / 2 + 1
		backgroundColor = color
		return self
	}
}

typealias UISwitchTargetClosure = (UISwitch) -> Void

class UISwitchClosureWrapper: NSObject {
    let closure: UISwitchTargetClosure
    init(_ closure: @escaping UISwitchTargetClosure) {
        self.closure = closure
    }
}

extension UISwitch {
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    private var targetClosure: UISwitchTargetClosure? {
        get {
            guard
				let closureWrapper =
					objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UISwitchClosureWrapper
				else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(
				self,
				&AssociatedKeys.targetClosure,
				UISwitchClosureWrapper(newValue),
				objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}

