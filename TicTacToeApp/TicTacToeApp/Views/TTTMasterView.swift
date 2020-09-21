//
//  ContentView.swift
//  TicTacToeApp
//
//  Created by Joshua Shen on 1/13/20.
//  Copyright © 2020 Joshua Shen. All rights reserved.
//

import SwiftUI

struct TTTMasterView: View {
    //gameplay stuff
    @State private var tBoard = TTTBoard()
    @State private var xturn = true //x goes first, then o
    @State private var expertMode = false
    
    //alerts
    @State private var cellTakenAlert = false
    @State private var winMessageAlert = false
    @State private var tiedAlert = false
    
    //records
    @State private var numGames = 0
    @State private var numXWins = 0
    @State private var numTies = 0
    @State private var recordSheet = false
    @State private var moves = [Move]()
    
    
    func cellTaken(_ r: Int, _ c: Int)-> Bool {
        return tBoard.cells[r][c] != 0
    }
    
    func newGame() {
        tBoard = TTTBoard()
        xturn = true
        cellTakenAlert = false
    }
    
    func mark(_ xturn: Bool, _ r: Int, _ c: Int, _ exMode: Bool) {
        if emptyCoors().count == 9 {moves = [Move]()}
        if !exMode {
            tBoard.mark(xturn, r, c)
            moves.append(Move(xMove: self.xturn, coor: Coordinate(r, c), tBoard: self.tBoard))
            return
        }
        let randInt = Int.random(in: 1...10)
        if randInt <= 3 {
            let coors = emptyCoors()
            let randIndex = Int.random(in: 0..<coors.count)
            tBoard.mark(xturn, coors[randIndex].row, coors[randIndex].col)
            moves.append(Move(xMove: self.xturn, coor: Coordinate(coors[randIndex].row, coors[randIndex].col), tBoard: self.tBoard))
        } else {
            tBoard.mark(xturn, r, c)
            moves.append(Move(xMove: self.xturn, coor: Coordinate(r, c), tBoard: self.tBoard))
        }
    }
    
    func emptyCoors()-> [Coordinate] {
        var toRet = [Coordinate]()
        for r in 0...2 {
            for c in 0...2 {
                if tBoard.cells[r][c] == 0 {toRet.append(Coordinate(r, c))}
            }
        }
        return toRet
    }
    
    func gameWon()-> Bool {
        let c = tBoard.cells
        if (c[0][0] != 0) && (c[0][0] == c[0][1]) && (c[0][1] == c[0][2]) {return true}
        if (c[1][0] != 0) && (c[1][0] == c[1][1]) && (c[1][1] == c[1][2]) {return true}
        if (c[2][0] != 0) && (c[2][0] == c[2][1]) && (c[2][1] == c[2][2]) {return true}
        if (c[0][0] != 0) && (c[0][0] == c[1][0]) && (c[1][0] == c[2][0]) {return true}
        if (c[0][1] != 0) && (c[0][1] == c[1][1]) && (c[1][1] == c[2][1]) {return true}
        if (c[0][2] != 0) && (c[0][2] == c[1][2]) && (c[1][2] == c[2][2]) {return true}
        if (c[0][0] != 0) && (c[0][0] == c[1][1]) && (c[1][1] == c[2][2]) {return true}
        if (c[0][2] != 0) && (c[0][2] == c[1][1]) && (c[1][1] == c[2][0]) {return true}
        return false
    }
    
    func gameTied()-> Bool {
        return emptyCoors().count == 0
    }
    
    func clickCellAction(_ r: Int, _ c: Int) {
        if !cellTaken(r, c) {
            mark(xturn, r, c, expertMode)
            if gameWon() {
                if xturn {numXWins += 1}
                numGames += 1
                winMessageAlert = true
                return
            }
            if gameTied() {
                numTies += 1
                numGames += 1
                tiedAlert = true
                return
            }
            xturn.toggle()
        } else {cellTakenAlert = true}
    }
    
    var body: some View {
        //notice that .alerts are scattered throuhgout since I can't chain them all on the TTTCellView Button. The last one would override the rest
        VStack(spacing: 10) {
            //top summary line
            HStack(spacing: 5) {
                Text("\(numXWins) X Wins,").foregroundColor(Color.blue)
                Text("\(numGames - numXWins - numTies) O Wins,").foregroundColor(Color.red)
                    .alert(isPresented: self.$cellTakenAlert) {
                        Alert(title: Text("Error"), message: Text("Please Pick Another Move"), dismissButton: .default(Text("Got it!")))
                    }
                Text("\(numTies) Ties, \(numGames) Total Games")
                    .sheet(isPresented: $recordSheet) {
                        ScrollView(.horizontal) {
                            HStack(spacing: 55) {
                                Spacer().frame(width: 5)
                                ForEach(0..<self.moves.count) { i in
                                    MoveView(move: self.moves[i])
                                }
                                Spacer().frame(width: 5)
                            }
                        }
                    }
            }
            //whose turn?
            Text(xturn ? "X Player's Turn" : "O Player's Turn")
                .font(.system(size: 60))
                .foregroundColor(xturn ? Color.blue : Color.red)
                .padding(-10)
                .alert(isPresented: self.$winMessageAlert) {
                    Alert(title: Text("Congratulations, \(self.xturn ? "X" : "O") Player"), message: Text("You Won!!!"),
                          primaryButton: .default(Text("Start New Game")) {
                              self.newGame()
                          }, secondaryButton: .default(Text("See Game Record")) {
                            self.recordSheet = true
                            self.newGame()
                        })
                }
            //expertmode toggle
            Toggle(isOn: $expertMode) {
                Text("Expert Mode")
            } .frame(width: 180)
                .alert(isPresented: self.$tiedAlert) {
                    Alert(title: Text("Oh No!"), message: Text("Neither Player Won"),
                      primaryButton: .default(Text("Start New Game")) {
                          self.newGame()
                      }, secondaryButton: .default(Text("See Game Record")) {
                        self.recordSheet = true
                        self.newGame()
                    })
                }
            //board
            VStack(spacing: 0) {
                ForEach(0..<3) { r in
                    HStack(spacing: 0) {
                        ForEach(0..<3) { c in
                            Button(action: {
                                self.clickCellAction(r, c)
                            }) {
                                TTTCellView(num: self.tBoard.cells[r][c], recentMove: false)
                                    .animation(.default)
                                    .frame(width: 200, height: 200)
                                    .border(Color.black, width: 3)
                            }
                        }
                    }
                }
            }.border(Color.white, width: 3)
        }
    }
}

