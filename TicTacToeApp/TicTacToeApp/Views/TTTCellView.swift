//
//  TTTCellView.swift
//  TicTacToeApp
//
//  Created by Joshua Shen on 1/16/20.
//  Copyright © 2020 Joshua Shen. All rights reserved.
//

import SwiftUI


struct TTTCellView: View {
    //does not change
    let num: Int
    let recentMove: Bool
    
    var body: some View {
        GeometryReader { g in
            VStack { //vstack is requred otherwise there is a type conformity error
                if self.num == 0 {
                    Rectangle().fill(Color.white).frame(width: 0.8*g.size.width, height: 0.8*g.size.height)
                } else {
                    if self.num == 1 {
                        XShape().fill(self.recentMove ? Color.purple : Color.blue).frame(width: 0.8*g.size.width, height: 0.8*g.size.height)
                    } else {Circle().stroke(self.recentMove ? Color.purple : Color.red, lineWidth: 0.15*g.size.width).frame(width: 0.65*g.size.width, height: 0.65*g.size.width)}
                }
            }
        }
    }
}

