//
//  GamePartOneViewController.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 22.06.2022.
//

import UIKit


// MARK: - GamePartOneViewProtocol (Connection Presenter -> View)
protocol GamePartOneViewProtocol: AnyObject {
    
}

class GamePartOneViewController: UIViewController {

    var guessNumberPlayer: Int!
    
    // MARK: - Private Properties
    var presenter: GamePartOnePresenterProtocol!
    
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
        
        presenter = GamePartOnePresenter(view: self)
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
                showAlert()
            }
        case "<":
            if guessNumberPlayer < currentChosenNumberComputer {
                maxChosenNumberComputer = currentChosenNumberComputer
                currentChosenNumberComputer = (maxChosenNumberComputer - minChosenNumberComputer) / 2 + minChosenNumberComputer
                triesComputer += 1
                updateLabels()
            } else {
                showAlert()
            }
            
        case ">":
            if guessNumberPlayer > currentChosenNumberComputer {
                minChosenNumberComputer = currentChosenNumberComputer
                currentChosenNumberComputer = (maxChosenNumberComputer - minChosenNumberComputer) / 2 + minChosenNumberComputer
                
                if currentChosenNumberComputer == minChosenNumberComputer {
                    currentChosenNumberComputer = 100
                }
                
                triesComputer += 1
                updateLabels()
            } else {
                showAlert()
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

// MARK: - Alert Controller
extension GamePartOneViewController {
    private func showAlert() {
        let alert = UIAlertController(
            title: "😏",
            message: "Don't lie",
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )
        
        present(alert, animated: true)
    }
}


// MARK: - Realization GamePartOneViewProtocol Methods (Connection Presenter -> View)
extension GamePartOneViewController: GamePartOneViewProtocol {
    
}
