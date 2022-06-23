//
//  GuessNumberViewController.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 22.06.2022.
//

import UIKit

// MARK: - GuessNumberViewProtocol (Connection Presenter -> View)
protocol GuessNumberViewProtocol: AnyObject {
    func changeButtonStatus(isEnabled: Bool, alpha: CGFloat)
    func endEditing(status: Bool)
    func showError(title: String, message: String)
    func performSegue(identifier: String)
}

class GuessNumberViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var guessNumberTF: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    // MARK: - Private Properties
    private var presenter: GuessNumberPresenterProtocol!
    
    // MARK: - Methods Of ViewController's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guessNumberTF.delegate = self
        presenter = GuessNumberPresenter(view: self)
        presenter.textFieldDidEndEditing(guessNumber: guessNumberTF.text ?? "")
        addDoneButtonForNumberKeyboard()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gamePartOneVC = segue.destination as? GamePartOneViewController else { return }
        gamePartOneVC.guessNumberPlayer = Int(guessNumberTF.text ?? "1")
    }
    
    // MARK: - IBActions
    @IBAction func enterNumberButton() {
        presenter.enterNumberButtonTapped(guessNumber: guessNumberTF.text ?? "")
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        presenter.charactersInTextFieldAreChanging()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.textFieldDidEndEditing(guessNumber: guessNumberTF.text ?? "")
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
        presenter.keyboardDoneButtonTapped()
    }
    
    // Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        presenter.touchesBegan()
    }
}

// MARK: - Alert Controller
extension GuessNumberViewController {
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

// MARK: - Realization GuessNumberViewProtocol Methods (Connection Presenter -> View)
extension GuessNumberViewController: GuessNumberViewProtocol {
    func changeButtonStatus(isEnabled: Bool, alpha: CGFloat) {
        enterButton.isEnabled = isEnabled
        enterButton.alpha = alpha
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
