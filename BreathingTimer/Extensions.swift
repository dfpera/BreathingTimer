//
//  Extensions.swift
//  BreathingTimer
//
//  Created by Daniele on 2017-05-17.
//  Copyright © 2017 Daniele Perazzolo. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func letter(spacing: Float) {
        if let textString = text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
