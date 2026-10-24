//
//  PigView.swift
//  Pig
//
//  WHAT THIS GAME DOES NOW
//  Pig is a dice game for two players who share one laptop.
//  On your turn, roll the die as many times as you like.
//  Each roll adds to your turn total.
//  Roll a 1 and you lose your turn total, and your turn is over.
//  Click Hold to bank your turn total into your score and end your turn.
//
////  NEW IN LESSON 5
//  The first player to bank 100 points or more wins.//
//  NEW FOR MAKE IT YOURS
//  Added player 3 as well as an accesible button to remove and add it.
//

import SwiftUI

// Each player has their own colour.
// TRY: Change these two colours. Try Color.purple, Color.green or Color.pink.
let playerOneColor: Color = Color.teal
let playerTwoColor: Color = Color.pink
let playerThreeColor: Color = Color.purple

// The game itself: what it remembers, what it shows on the screen,
// and what it does when you click a button.
struct PigView: View {

    // MARK: - Stored properties

    // Each @State variable is something the game remembers.
    // When one of them changes, the screen updates by itself.

    // The points each player has banked. Banked points are safe.
    @State var playerOneScore: Int = 0
    @State var playerTwoScore: Int = 0
    @State var playerThreeScore: Int = 0
    @State var numberOfPlayers: Int = 2
    // Becomes true when somebody wins.
    @State var gameIsOver: Bool = false
    // The first player to reach this score wins.
    let winningScore: Int = 100

    // The points collected so far on this turn.
    // They are not safe until the player clicks Hold.
    @State var turnTotal: Int = 0

    // Whose turn it is: 1 or 2.
    @State var currentPlayer: Int = 1

    // The colour of whoever's turn it is.
    @State var turnColor: Color = playerOneColor

    // How many times the current player has rolled on this turn.
    @State var rollsThisTurn: Int = 0
    
    // The name of the SF Symbol that shows the die.
    @State var dieSymbol: String = "questionmark.square.fill"
    @State var secondDieSymbol: String = "questionmark.square.fill"

    // A message that tells the players what just happened.
    @State var message: String = "Player 1 goes first. Click Roll to start."

    // MARK: - Computed properties

    var body: some View {
        VStack(spacing: 12) {

            // The title at the top of the screen.
            HStack {
                Image(systemName: "dice.fill")
                Text("Pig")
            }
            .font(.largeTitle)
            .bold()

            // The scoreboard: one card for each player.
            HStack(spacing: 16) {
                VStack {
                    Text("Player 1")
                        .font(.headline)
                    Text("\(playerOneScore)")
                        .font(.system(size: 48, weight: .bold))
                        .monospacedDigit()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(playerOneColor.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))

                VStack {
                    Text("Player 2")
                        .font(.headline)
                    Text("\(playerTwoScore)")
                        .font(.system(size: 48, weight: .bold))
                        .monospacedDigit()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(playerTwoColor.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                if numberOfPlayers == 3 {
                    VStack {
                        Text("Player 3")
                            .font(.headline)
                        Text("\(playerThreeScore)")
                            .font(.system(size: 48, weight: .bold))
                            .monospacedDigit()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(playerThreeColor.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }

            Spacer()

            // Say whose turn it is, or that the game is over.
            if !gameIsOver {
                Text("Player \(currentPlayer), your turn")
                    .font(.title)
                    .bold()
                    .foregroundStyle(turnColor)
            } else {
                Text("Game over")
                    .font(.title)
                    .bold()
                    .foregroundStyle(turnColor)
            }

            // The die.
            // TRY: Change the size of the die from 120 to something bigger or smaller.
            if gameIsOver {
                            Image(systemName: "trophy.fill")
                                .font(.system(size: 90))
                                .foregroundStyle(turnColor)
                        } else {
                            HStack(spacing: 16) {
                                Image(systemName: dieSymbol)
                                Image(systemName: secondDieSymbol)
                            }
                            .font(.system(size: 90))
                            .foregroundStyle(turnColor)
                        }

            Text("Turn total: \(turnTotal)    Rolls: \(rollsThisTurn)")
                .font(.title2)
                .bold()
                .monospacedDigit()

            Text(message)
                .font(.headline)
                .foregroundStyle(Color.secondary)
                .multilineTextAlignment(.center)
                .frame(minHeight: 44)

            Spacer()

            // The two buttons a player uses on their turn.
            // The code inside the braces runs when that button is clicked.
            HStack(spacing: 16) {
                Button("Roll", systemImage: "dice") {
                    rollDie()
                
                }
                .buttonStyle(.borderedProminent)

                Button("Hold", systemImage: "hand.raised.fill") {
                    hold()

                }
                .buttonStyle(.bordered)
            }
            .font(.title2)
            .bold()
            .controlSize(.large)
            .tint(turnColor)
            // Nobody can roll or hold once the game is over.
                        .disabled(gameIsOver)

            if numberOfPlayers == 2 {
                Button("Add Player 3") {
                    numberOfPlayers = 3
                    startNewGame()
                }
            } else {
                Button("Remove Player 3") {
                    numberOfPlayers = 2
                    startNewGame()
                }
            }
            
            Button("New Game") {
                startNewGame()
                gameIsOver = false
            }
        }
        .padding(32)
        .fontDesign(.rounded)
        // How big the game's window is on the Mac. It can be made taller or wider.
        .frame(minWidth: 480, minHeight: 680)
    }

    // MARK: - Functions
    
    
    func hold() {
        if currentPlayer == 1 {
                    playerOneScore += turnTotal
                } else if currentPlayer == 2 {
                    playerTwoScore += turnTotal
                } else {
                    playerThreeScore += turnTotal
                }

                // Has any player reached the winning score?
                let someoneHasWon: Bool = hasWon(score: playerOneScore) || hasWon(score: playerTwoScore) || hasWon(score: playerThreeScore)
 
        if someoneHasWon {
            message = "Player \(currentPlayer) wins! Click New Game to play again."
            turnTotal = 0
            gameIsOver = true
        } else {
            message = "Player \(currentPlayer) banked \(turnTotal) points."
            turnTotal = 0
            switchPlayer()
        }
    }
    
    // Picks a random whole number from 1 to 6, just like a real die.
    func rollOneDie() -> Int {
        let roll: Int = Int.random(in: 1...6)
        return roll
    }
     
    // Answers true when a score is high enough to win.
    func hasWon(score: Int) -> Bool {
        return score >= winningScore
    }
    // Rolls the die once for the current player.
    // Rolls two dice for the current player.
        func rollDie() {
            let rollOne: Int = rollOneDie()
            let rollTwo: Int = rollOneDie()

            rollsThisTurn += 1

            dieSymbol = "die.face.\(rollOne).fill"
            secondDieSymbol = "die.face.\(rollTwo).fill"

            if rollOne == 1 || rollTwo == 1 {
                // Rolling a 1 on either die wipes out the turn total and ends the turn.
                message = "Oh no, a 1! Player \(currentPlayer) loses \(turnTotal) points."
                turnTotal = 0
                switchPlayer()
            } else {
                // Any other combination adds normally.
                let rollSum: Int = rollOne + rollTwo
                turnTotal += rollSum
                message = "You rolled \(rollSum). Roll again or hold?"
            }
        
        }
    
    // Passes the turn to the other player.
    func switchPlayer() {
        rollsThisTurn = 0
 
        // The remainder does the switching: 1 becomes 2, and 2 becomes 1.
        if numberOfPlayers == 2 {
                    currentPlayer = currentPlayer % 2 + 1
                } else {
                    if currentPlayer == 1 {
                        currentPlayer = 2
                    } else if currentPlayer == 2 {
                        currentPlayer = 3
                    } else {
                        currentPlayer = 1
                    }
                }

                if currentPlayer == 1 {
                    turnColor = playerOneColor
                } else if currentPlayer == 2 {
                    turnColor = playerTwoColor
                } else {
                    turnColor = playerThreeColor
                }
    }

    // Sets everything back to the way it was at the start.
    func startNewGame() {
        playerOneScore = 0
        playerTwoScore = 0
        playerThreeScore = 0
        turnTotal = 0
        currentPlayer = 1
        turnColor = playerOneColor
        dieSymbol = "questionmark.square.fill"
        secondDieSymbol = "questionmark.square.fill"
        message = "Player 1 goes first. Click Roll to start."
    }
}

#Preview {
    PigView()
}
