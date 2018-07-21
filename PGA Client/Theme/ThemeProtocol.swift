//
//  ThemeProtocol.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/21/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var mainFontName: String { get }
    var accent: UIColor { get }
    var background: UIColor { get }
    var tint: UIColor { get }
}
