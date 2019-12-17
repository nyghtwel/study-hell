//
//  Reusable.swift
//  NyghtwelTools
//
//  Created by Alan Liou on 12/17/19.
//  Copyright © 2019 Nyghtwel, Inc. All rights reserved.
//

import UIKit

/** This protocol is simply a way to auto generate reuseIds for classes so that we can auto register/dequeue cells */
public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
