//
//  ThemeProtocol.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/21/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    static var accent: UIColor { get }
    static var background: UIColor { get }
    static var tint: UIColor { get }
    static var textColor: UIColor { get }
}
