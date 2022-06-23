//
//  GamePartTwoViewController.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 22.06.2022.
//

import UIKit

// MARK: - GamePartTwoViewProtocol (Connection Presenter -> View)
protocol GamePartTwoViewProtocol: AnyObject {
    func setComputerResponse(text: String)
    func changeComputerResponseVisible(isHidden: Bool)
    func updateTriesLabel(tries: Int)
    func endEditing(status: Bool)
    func showError(title: String, message: String)
    func performSegue(identifier: String)
}

class GamePartTwoViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var triesPlayerLabel: UILabel!
    @IBOutlet weak var computerResponseLabel: UILabel!
    @IBOutlet weak var inputedNumberTF: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    
    // MARK: - Public Properties
    var triesComputer: Int!
    
    // MARK: - Private Properties
    private var presenter: GamePartTwoPresenterProtocol!
    
    // MARK: - Methods Of ViewController's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        inputedNumberTF.delegate = self
        presenter = GamePartTwoPresenter(view: self)
        addDoneButtonForNumberKeyboard()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.triesComputer = triesComputer
        resultVC.triesPlayer = presenter.triesPlayer
    }
    
    // MARK: - IBActions
    @IBAction func guessButtonTapped() {
        presenter.guessButtonTapped(inputedNumber: inputedNumberTF.text ?? "")
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        presenter.charactersInTextFieldAreChanging()
        return true
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
        presenter.keyboardDoneButtonTapped()
    }
    
    // Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        presenter.touchesBegan()
    }
}

// MARK: - Alert Controller
extension GamePartTwoViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
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
    
    func setComputerResponse(text: String) {
        computerResponseLabel.text = text
    }
    
    func changeComputerResponseVisible(isHidden: Bool) {
        computerResponseLabel.isHidden = isHidden
    }
    
    func updateTriesLabel(tries: Int) {
        triesPlayerLabel.text = "Try № \(tries)"
    }
    
    func endEditing(status: Bool) {
        view.endEditing(status)
    }
    
    func showError(title: String, message: String) {
        showAlert(title: title, message: message)
    }
    
    func performSegue(identifier: String) {
        performSegue(withIdentifier: identifier, sender: nil)
    }
}
