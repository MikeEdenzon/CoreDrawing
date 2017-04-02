//
//  DrawingView.swift
//  CoreDrawing
//
//  Created by Michael Edenzon on 4/2/17.
//  Copyright © 2017 Michael Edenzon. All rights reserved.
//

import Foundation
import UIKit

class DrawingView: UIView {
    
    var drawingPath = UIBezierPath()
    var canvasPath = UIBezierPath()
    
    var drawingLayer: CoreDrawingLayer!
    var canvasLayer: CoreDrawingLayer!
    
    var clearButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        drawingLayer = CoreDrawingLayer(frame: self.frame, color: UIColor.blue)
        canvasLayer = CoreDrawingLayer(frame: self.frame, color: UIColor.red)
        
        self.layer.addSublayer(canvasLayer)
        self.layer.addSublayer(drawingLayer)
        
        loadClearButton()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let coalescedTouches = event?.coalescedTouches(for: touch)
        for touch in coalescedTouches! {
            drawingPath.move(to: touch.precisePreviousLocation(in: self))
            drawingPath.addLine(to: touch.preciseLocation(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let coalescedTouches = event?.coalescedTouches(for: touch)
        for touch in coalescedTouches! {
            drawingPath.move(to: touch.precisePreviousLocation(in: self))
            drawingPath.addLine(to: touch.preciseLocation(in: self))
        }
        drawingLayer.path = drawingPath.cgPath
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canvasPath.append(drawingPath)
        drawingPath.removeAllPoints()
        drawingLayer.path = nil
        canvasLayer.path = canvasPath.cgPath
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        canvasPath.append(drawingPath)
        drawingPath.removeAllPoints()
        drawingLayer.path = nil
        canvasLayer.path = canvasPath.cgPath
    }
    
    func clear() {
        drawingPath.removeAllPoints()
        drawingLayer.path = nil
        canvasPath.removeAllPoints()
        canvasLayer.path = nil
    }
    
    func loadClearButton() {
        clearButton = UIButton(frame: CGRect(x: 8, y: 16, width: 100, height: 30))
        clearButton.setTitle("Clear", for: .normal)
        clearButton.setTitleColor(UIColor.blue, for: .normal)
        clearButton.layer.cornerRadius = clearButton.frame.height/4
        clearButton.addTarget(self, action: #selector(self.buttonPressed), for: .touchDown)
        clearButton.addTarget(self, action: #selector(self.buttonCancelled), for: .touchUpOutside)
        clearButton.addTarget(self, action: #selector(self.buttonReleased), for: .touchUpInside)
        self.addSubview(clearButton)
        self.bringSubview(toFront: clearButton)
    }
    
    func buttonPressed() {
        clearButton.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
    }
    
    func buttonCancelled() {
        clearButton.backgroundColor = nil
    }
    
    func buttonReleased() {
        clearButton.backgroundColor = nil
        clear()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
