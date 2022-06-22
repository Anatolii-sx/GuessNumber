//
//  GamePartOneViewController.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 22.06.2022.
//

import UIKit

class GamePartOneViewController: UIViewController {

    var guessNumberPlayer: Int!
    
    private let maxNumberGame = 100
    private let minNumberGame = 1
    
    private var currentChosenNumberComputer = Int.random(in: 1...100)
    private var maxChosenNumberComputer = 100
    private var minChosenNumberComputer = 1
    
    private var triesComputer = 1
    
    @IBOutlet var comparisonButtonsPlayer: [UIButton]!
    
    @IBOutlet weak var triesComputerLabel: UILabel!
    @IBOutlet weak var currentChosenNumberComputerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comparisonButtonsPlayer.forEach { button in
            button.layer.borderWidth = 1
            button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            button.backgroundColor = .clear
        }
        updateLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gamePartTwoVC = segue.destination as? GamePartTwoViewController else { return }
        gamePartTwoVC.triesComputer = triesComputer
    }
    
    @IBAction func comparisonButtonTapped(_ sender: UIButton) {
        makeComputerDecision(pushedButton: sender.currentTitle ?? "")
    }
    
    private func makeComputerDecision(pushedButton: String) {
        switch pushedButton {
        case "=":
            if guessNumberPlayer == currentChosenNumberComputer {
                performSegue(withIdentifier: "ToGamePartTwoSegue", sender: nil)
            } else {
                print("Player lied")
            }
        case "<":
            if guessNumberPlayer < currentChosenNumberComputer {
                maxChosenNumberComputer = currentChosenNumberComputer
                currentChosenNumberComputer =  (maxChosenNumberComputer - minChosenNumberComputer) / 2 +   minChosenNumberComputer
                triesComputer += 1
                updateLabels()
            } else {
                print("Player lied")
            }
            
        case ">":
            if guessNumberPlayer > currentChosenNumberComputer {
                minChosenNumberComputer = currentChosenNumberComputer
                currentChosenNumberComputer = (maxChosenNumberComputer - minChosenNumberComputer) / 2 + minChosenNumberComputer
                triesComputer += 1
                updateLabels()
            } else {
                print("Player lied")
            }
            
        default:
            break
        }
    }
    
    private func updateLabels() {
        triesComputerLabel.text = "Try № \(triesComputer)"
        currentChosenNumberComputerLabel.text = "Your number is - \(currentChosenNumberComputer)"
    }
    
    
}
