//
//  UIColor+Utils.swift
//  NyghtwelTools
//
//  Created by Alan Liou on 12/17/19.
//  Copyright © 2019 Nyghtwel, Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

	var hex: String? { toHex() }

    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else { return nil }

        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
		let a = (components.count >= 4) ? Float(components[3]) : Float(1.0)

		let rInt = (Int)(r * 255)
		let gInt = (Int)(g * 255)
		let bInt = (Int)(b * 255)
		let aInt = (Int)(a * 255)

		return alpha
			? String(format: "%02lX%02lX%02lX%02lX", rInt, gInt, bInt, aInt)
			: String(format: "%02lX%02lX%02lX", rInt, gInt, bInt)
    }
}
