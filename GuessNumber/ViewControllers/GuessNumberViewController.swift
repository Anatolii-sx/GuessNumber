//
//  GuessNumberViewController.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 22.06.2022.
//

import UIKit

class GuessNumberViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var guessNumberTF: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    // MARK: - Methods Of ViewController's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guessNumberTF.delegate = self
        enterButton.isEnabled = false
        enterButton.alpha = 0.5
        addDoneButtonForNumberKeyboard()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gamePartOneVC = segue.destination as? GamePartOneViewController else { return }
        gamePartOneVC.guessNumberPlayer = Int(guessNumberTF.text ?? "1")
    }
    
    // MARK: - IBActions
    @IBAction func enterNumberButton() {
        guard let guessNumber = Int(guessNumberTF.text ?? ""), 1...100 ~= guessNumber else {
            showAlert()
            return
        }
        performSegue(withIdentifier: "ToGamePartOneSegue", sender: nil)
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        enterButton.isEnabled = true
        enterButton.alpha = 1
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let guessNumberTF = guessNumberTF.text else { return }
        if guessNumberTF.isEmpty {
            enterButton.isEnabled = false
            enterButton.alpha = 0.5
        }
    }
    
    // MARK: - Keyboard
    // Add done button for number keyboard
    private func addDoneButtonForNumberKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        guessNumberTF.inputAccessoryView = keyboardToolbar
        
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
extension GuessNumberViewController {
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
