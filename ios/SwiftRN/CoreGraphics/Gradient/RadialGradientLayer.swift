//
//  RadialGradientLayer.swift
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/9/22.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

import UIKit

class RadialGradientLayer: CALayer {
 
    override init()
    {
        super.init()
        setNeedsDisplay()
        needsDisplayOnBoundsChange = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    var center: CGPoint {
        return CGPoint(x: bounds.width/2, y: bounds.height/2)
    }
    
    var radius: CGFloat {
        return (bounds.width + bounds.height)/2
    }
    
    var colors: [UIColor] = [UIColor.lightGray, UIColor.black] {
        didSet {
            setNeedsDisplay()
        }
    }
    
   
    
    
    override func draw(in ctx: CGContext) {
        var cgColors: [CGColor] {
            return colors.map({ (color) -> CGColor in
                return color.cgColor
            })
        }
        ctx.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else {

            return
        }
        ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
    }
}
