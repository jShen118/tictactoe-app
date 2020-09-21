//
//  TTTBoard.swift
//  TicTacToeApp
//
//  Created by Joshua Shen on 1/13/20.
//  Copyright © 2020 Joshua Shen. All rights reserved.
//

import Foundation


struct TTTBoard: CustomStringConvertible {
    var cells: [[Int]] = Array(repeating: Array(repeating: 0, count: 3), count: 3)
    
    //0 is empty, 1 is x, 2 is 0
    mutating func mark(_ x: Bool, _ r: Int, _ c: Int) {
        cells[r][c] = (x ? 1 : 2)
    }
    
    var description: String {
        var toRet = ""
        for r in 0..<3 {
            for c in 0..<3 {
                toRet += cells[r][c].description
            }
            toRet += "\n"
        }
        return toRet
    }
}




