//
//  UIButtonExtension.swift
//  RateTheShowApp
//
//  Created by Анна Никифорова on 14.04.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.25
        pulse.fromValue = 1
        pulse.toValue = 0.96
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
        
    }
    
}
