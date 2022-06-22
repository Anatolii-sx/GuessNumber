//
//  GamePartTwoViewController.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 22.06.2022.
//

import UIKit

class GamePartTwoViewController: UIViewController, UITextFieldDelegate {

    var triesComputer: Int!
    let guessNumberComputer = Int.random(in: 1...100)
    
    private var triesPlayer = 1
    
    @IBOutlet weak var triesPlayerLabel: UILabel!
    @IBOutlet weak var inputedNumberTF: UITextField!
    @IBOutlet weak var computerResponseLabel: UILabel!
    
    @IBOutlet weak var guessButton: UIButton!
    
    @IBAction func guessButtonTapped() {
        guard let inputedNumberTF = Int(inputedNumberTF.text ?? "") else { return }
        
        if guessNumberComputer == inputedNumberTF {
            performSegue(withIdentifier: "ToResultSegue", sender: nil)
        } else if guessNumberComputer < inputedNumberTF {
            triesPlayer += 1
            computerResponseLabel.text = "No, my number is less than yours"
            computerResponseLabel.isHidden = false
            updateTriesLabel()
        } else if guessNumberComputer > inputedNumberTF {
            triesPlayer += 1
            computerResponseLabel.text = "No, my number is greater than yours"
            computerResponseLabel.isHidden = false
            updateTriesLabel()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        inputedNumberTF.delegate = self
        updateTriesLabel()
        
        print(guessNumberComputer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.triesComputer = triesComputer
        resultVC.triesPlayer = triesPlayer
    }
    
    private func updateTriesLabel() {
        triesPlayerLabel.text = "Try № \(triesPlayer)"
    }
}
