//
//  Move.swift
//  TicTacToeApp
//
//  Created by Joshua Shen on 1/16/20.
//  Copyright © 2020 Joshua Shen. All rights reserved.
//

import Foundation

struct Move {
    var xMove: Bool
    var coor: Coordinate
    var tBoard: TTTBoard
    
    //tBoard only has previous moves, coor is coordinate of new move
    var moveNumber: Int {
        var moveCount = 0
        for r in 0...2 {
            for c in 0...2 {
                if tBoard.cells[r][c] != 0 {moveCount += 1}
            }
        }
        return moveCount / 2 + 1
    }
}

