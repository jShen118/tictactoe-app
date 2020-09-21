//
//  XShape.swift
//  TicTacToeApp
//
//  Created by Joshua Shen on 1/16/20.
//  Copyright © 2020 Joshua Shen. All rights reserved.
//

import Foundation
import SwiftUI

struct XShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        //had to do it out on paper first
        path.move(to: CGPoint(x: rect.midX, y: 0.7*rect.maxY))
        path.addLine(to: CGPoint(x: 0.2*rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: 0.8*rect.maxY))
        path.addLine(to: CGPoint(x: 0.3*rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: 0.2*rect.maxY))
        path.addLine(to: CGPoint(x: 0.2*rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: 0.3*rect.maxY))
        path.addLine(to: CGPoint(x: 0.8*rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: 0.2*rect.maxY))
        path.addLine(to: CGPoint(x: 0.7*rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: 0.8*rect.maxY))
        path.addLine(to: CGPoint(x: 0.8*rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: 0.7*rect.maxY))
        return path
    }
}
