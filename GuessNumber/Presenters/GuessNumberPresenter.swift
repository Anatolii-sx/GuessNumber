//
//  GuessNumberPresenter.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 23.06.2022.
//

import Foundation

// MARK: - GuessNumberPresenterProtocol (Connection View -> Presenter)
protocol GuessNumberPresenterProtocol {
    init(view: GuessNumberViewProtocol)
    func charactersInTextFieldAreChanging()
    func textFieldDidEndEditing(guessNumber: String)
    func keyboardDoneButtonTapped()
    func touchesBegan()
    func enterNumberButtonTapped(guessNumber: String)
}

class GuessNumberPresenter: GuessNumberPresenterProtocol {
    // MARK: - Private Properties
    private unowned let view: GuessNumberViewProtocol
    
    // MARK: - Realization GuessNumberPresenterProtocol Init (Connection View -> Presenter)
    required init(view: GuessNumberViewProtocol) {
        self.view = view
    }
    
    // MARK: - Realization GuessNumberPresenterProtocol Methods (Connection View -> Presenter)
    func charactersInTextFieldAreChanging() {
        view.changeButtonStatus(isEnabled: true, alpha: 1)
    }
    
    func textFieldDidEndEditing(guessNumber: String) {
        if guessNumber.isEmpty {
            view.changeButtonStatus(isEnabled: false, alpha: 0.5)
        }
    }
    
    func keyboardDoneButtonTapped() {
        view.endEditing(status: false)
    }
    
    func touchesBegan() {
        view.endEditing(status: false)
    }
    
    func enterNumberButtonTapped(guessNumber: String) {
        guard let guessNumber = Int(guessNumber), 1...100 ~= guessNumber else {
            view.showError(title: "⛔️", message: "Write number from 1 to 100")
            return
        }
        view.performSegue(identifier: "ToGamePartOneSegue")
    }
}
