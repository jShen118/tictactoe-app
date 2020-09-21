//
//  MoveView.swift
//  TicTacToeApp
//
//  Created by Joshua Shen on 1/16/20.
//  Copyright © 2020 Joshua Shen. All rights reserved.
//

import SwiftUI

struct MoveView: View {
    var move: Move
    
    func getNum(_ r: Int, _ c: Int)-> Int {
        if move.coor.row == r && move.coor.col == c {
            return move.xMove ? 1 : 2
        }
        else {return move.tBoard.cells[r][c]}
    }
    
    var body: some View {
        VStack {
            Text("\(move.xMove ? "X" : "O") Move #\(move.moveNumber)").font(.system(size: 25))
            VStack(spacing: 0) {
                ForEach(0..<3) { r in
                    HStack(spacing: 0) {
                        ForEach(0..<3) { c in
                            TTTCellView(num: self.getNum(r, c), recentMove:
                                ((self.move.coor.row == r && self.move.coor.col == c) ? true : false
                            ))
                                .frame(width: 215, height: 215)
                                .border(Color.black, width: 3)
                        }
                    }
                }
            }.border(Color.white, width: 3)
        }
    }
}
