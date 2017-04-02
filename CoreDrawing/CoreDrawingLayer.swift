//
//  CoreDrawingLayer.swift
//  CoreDrawing
//
//  Created by Michael Edenzon on 4/2/17.
//  Copyright © 2017 Michael Edenzon. All rights reserved.
//

import Foundation
import UIKit

class CoreDrawingLayer: CAShapeLayer {
    
    init(frame: CGRect, color: UIColor) {
        super.init()
        self.strokeColor = color.withAlphaComponent(0.5).cgColor
        self.fillColor = nil
        self.lineWidth = 5
        self.lineJoin = kCALineJoinRound
        self.lineCap = kCALineCapRound
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
