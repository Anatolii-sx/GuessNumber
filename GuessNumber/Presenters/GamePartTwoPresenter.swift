//
//  GamePartTwoPresenter.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 23.06.2022.
//

import Foundation

// MARK: - GamePartTwoPresenterProtocol (Connection View -> Presenter)
protocol GamePartTwoPresenterProtocol {
    var triesPlayer: Int { get }
    init(view: GamePartTwoViewProtocol)
    func guessButtonTapped(inputedNumber: String)
    func charactersInTextFieldAreChanging()
    func keyboardDoneButtonTapped()
    func touchesBegan()
}

class GamePartTwoPresenter: GamePartTwoPresenterProtocol {
    // MARK: - Public Properties
    var triesPlayer = 1
    let guessNumberComputer = Int.random(
        in: ConditionsOfGame.minNumber.rawValue...ConditionsOfGame.maxNumber.rawValue
    )
    
    // MARK: - Private Properties
    private unowned let view: GamePartTwoViewProtocol
    
    // MARK: - Realization GamePartTwoPresenterProtocol Init (Connection View -> Presenter)
    required init(view: GamePartTwoViewProtocol) {
        self.view = view
    }
    
    // MARK: - Realization GamePartTwoPresenterProtocol Methods (Connection View -> Presenter)
    func guessButtonTapped(inputedNumber: String) {
        checkAnswer(inputedNumber: inputedNumber)
    }
    
    func charactersInTextFieldAreChanging() {
        view.changeComputerResponseVisible(isHidden: true)
    }
    
    func keyboardDoneButtonTapped() {
        view.endEditing(status: false)
    }
    
    func touchesBegan() {
        view.endEditing(status: false)
    }
    
    // MARK: - Private Methods
    private func checkAnswer(inputedNumber: String) {
        guard let inputedNumber = Int(inputedNumber), ConditionsOfGame.minNumber.rawValue...ConditionsOfGame.maxNumber.rawValue ~= inputedNumber else {
            view.showError(
                title: "⛔️",
                message: "Write number from \(ConditionsOfGame.minNumber.rawValue) to \(ConditionsOfGame.maxNumber.rawValue)")
            return
        }
        
        view.changeComputerResponseVisible(isHidden: true)
        
        if guessNumberComputer == inputedNumber {
            view.performSegue(identifier: "ToResultSegue")
        } else if guessNumberComputer < inputedNumber {
            updateInfo(computerResponse: "No, my number is less than yours")
        } else if guessNumberComputer > inputedNumber {
            updateInfo(computerResponse: "No, my number is greater than yours")
        }
    }
    
    private func updateInfo(computerResponse: String) {
        triesPlayer += 1
        view.setComputerResponse(text: computerResponse)
        view.changeComputerResponseVisible(isHidden: false)
        view.updateTriesLabel(tries: triesPlayer)
        print("🤫 Computer guessed: \(guessNumberComputer)")
    }
}
