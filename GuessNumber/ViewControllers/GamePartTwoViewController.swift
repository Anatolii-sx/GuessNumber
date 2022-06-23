//
//  GamePartTwoViewController.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 22.06.2022.
//

import UIKit

// MARK: - GamePartTwoViewProtocol (Connection Presenter -> View)
protocol GamePartTwoViewProtocol: AnyObject {
    
}

class GamePartTwoViewController: UIViewController, UITextFieldDelegate {

    var triesComputer: Int!
    let guessNumberComputer = Int.random(in: 1...100)
    
    // MARK: - Private Properties
    private var presenter: GamePartTwoPresenterProtocol!
    
    private var triesPlayer = 1
    
    @IBOutlet weak var triesPlayerLabel: UILabel!
    @IBOutlet weak var inputedNumberTF: UITextField!
    @IBOutlet weak var computerResponseLabel: UILabel!
    
    @IBOutlet weak var guessButton: UIButton!
    
    @IBAction func guessButtonTapped() {
        
        guard let inputedNumberTF = Int(inputedNumberTF.text ?? ""), 1...100 ~= inputedNumberTF else {
            showAlert()
            return
        }
        
        computerResponseLabel.isHidden = true
        
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
        addDoneButtonForNumberKeyboard()
        
        presenter = GamePartTwoPresenter(view: self)
        print(guessNumberComputer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.triesComputer = triesComputer
        resultVC.triesPlayer = triesPlayer
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        computerResponseLabel.isHidden = true
        return true
    }
    
    private func updateTriesLabel() {
        triesPlayerLabel.text = "Try № \(triesPlayer)"
    }
    
    // MARK: - Keyboard
    // Add done button for number keyboard
    private func addDoneButtonForNumberKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        inputedNumberTF.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }
    
    // Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: - Alert Controller
extension GamePartTwoViewController {
    private func showAlert() {
        let alert = UIAlertController(
            title: "⛔️",
            message: "Write number from 1 to 100",
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


// MARK: - Realization GamePartTwoViewProtocol Methods (Connection Presenter -> View)
extension GamePartTwoViewController: GamePartTwoViewProtocol {
    
}
