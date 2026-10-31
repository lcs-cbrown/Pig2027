# Pig
You against one or two people. You roll two dice, and depending on the numbers you get, you either lose or have the option of holding and saving your score. First one to 100 wins! 
 
## How to play
 
1. You roll two die and have the option of keeping your number or rolling it again to add up.
2. If you roll a one, your whole turn total is lost!
3. If you roll two ones, your entire saved score is lost!!
4. The first person to 100 points wins. 
 
## What I added
 
- I added a player 3 option that can be added and removed with the click of a button.
- I added two dice, as well as a feature that when you roll only one die, your whole turn total is lost.
- I added a feature that resets a player's total score if they roll dobule 1s.
- I changed the colours of the player boxes to green and teal, and player 3's box to blue for aesthetic purposes.
- I added a confetti feature that appears when a player wins the game, because it looks fun!


## How it works

** Three Players **: You now have the option to play with three players, accesible with the click of a button. Clicking the button to addor remove the player in the middle of a game resets the scores, to make it fair for all players. 

The idea uses a `@State var`, `numberOfPlayers`, an `Int` that tracks whether 2 or 3 players are playing, and a `@State var`, `playerThreeScore`, an `Int` to store Player 3's points. A button toggles `numberOfPlayers` between 2 and 3 and calls `startNewGame()`. An if/else block inside the scoreboard checks if `numberOfPlayers == 3` to conditionally display Player 3's card, while `switchPlayer()` uses if/else if statements to cycle through players 1, 2, and 3 depending on the active mode.

```swift
        @State var numberOfPlayers: Int = 2
```

```swift
    @State var playerThreeScore: Int = 0
```

```swift
                
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
```

 ** Two Dice **: This allows for two dice to now be rolled. If you roll one 1, it resets your turn total. If you roll two ones, it resets your entire current score. Any other combination of numbers is added.
 
 The idea uses two `@State var` properties, `dieSymbol` and `secondDieSymbol`, both `Strings`, to display two dice images side-by-side using `HStack`. Inside `rollDie()`, two separate random numbers are generated using `rollOneDie()`. An if/else if chain checks the combined results: rolling a single 1 (`rollOne == 1 || rollTwo == 1`) resets `turnTotal = 0` and calls `switchPlayer()`, while rolling double 1s (`rollOne == 1 && rollTwo == 1`) uses conditional logic to reset the current player's banked score (`playerOneScore`, `playerTwoScore`, or `playerThreeScore`) back to 0 before ending their turn.
 
 ```swift
     @State var dieSymbol: String = "questionmark.square.fill"
    @State var secondDieSymbol: String = "questionmark.square.fill"
```

```swift
    func rollDie() {
        let rollOne: Int = rollOneDie()
        let rollTwo: Int = rollOneDie()
        
        rollsThisTurn += 1
        
        dieSymbol = "die.face.\(rollOne).fill"
        secondDieSymbol = "die.face.\(rollTwo).fill"
        
        if rollOne == 1 && rollTwo == 1 {
            // Double 1s resets the player's total banked score AND turn total.
            if currentPlayer == 1 {
                playerOneScore = 0
            } else if currentPlayer == 2 {
                playerTwoScore = 0
            } else {
                playerThreeScore = 0
            }
            message = "Double 1s! Player \(currentPlayer) loses their ENTIRE score!"
            turnTotal = 0
            switchPlayer()
        } else if rollOne == 1 || rollTwo == 1 {
            // Single 1 wipes out just the turn total and ends the turn.
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
```



 
## Credits
 
- The starting game was written by Mr. Gordon.
- The player 3 option: Gemini (in browser) suggested lines. I checked them and added them into Xcode.
- The two dice option and feature: Gemini (in broswer) suggested lines. I checked them and added them into Xcode.
- The resetting to 0 if roll double 1s/confetti feature: Gemini (in broswer) suggested lines. I checked them and added them into Xcode.

## Testing
**Double Ones** 
Chosen Input: Dice fixed at 1 and 1; Player 1’s score starts at 40 for the test; Player 1 rolls
Should Happen: Player 1’s score goes from 40 to 0, and it is Player 2’s turn
Did Happen: yes




