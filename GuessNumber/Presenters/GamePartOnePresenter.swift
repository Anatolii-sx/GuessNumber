//
//  GamePartOnePresenter.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 23.06.2022.
//

import Foundation

// MARK: - GamePartOnePresenterProtocol (Connection View -> Presenter)
protocol GamePartOnePresenterProtocol {
    var triesComputer: Int { get }
    init(view: GamePartOneViewProtocol, guessNumberPlayer: Int)
    func setLabelsText()
    func comparisonButtonTapped(pushedButton: String)
}

class GamePartOnePresenter: GamePartOnePresenterProtocol {
    // MARK: - Public Properties
    var triesComputer = 1
    
    // MARK: - Private Properties
    private var maxChosenNumberComputer = 100
    private var minChosenNumberComputer = 1
    private var currentChosenNumberComputer = Int.random(in: 1...100)
    
    private let maxNumberGame = 100
    private let minNumberGame = 1
    private let guessNumberPlayer: Int
    
    private unowned let view: GamePartOneViewProtocol
    
    // MARK: - Realization GamePartOnePresenterProtocol Init (Connection View -> Presenter)
    required init(view: GamePartOneViewProtocol, guessNumberPlayer: Int) {
        self.view = view
        self.guessNumberPlayer = guessNumberPlayer
    }
    
    // MARK: - Realization GamePartOnePresenterProtocol Methods (Connection View -> Presenter)
    func setLabelsText() {
        view.updateLabels(
            triesComputer: "Try № \(triesComputer)",
            currentChosenNumberComputer: "Your number is - \(currentChosenNumberComputer)"
        )
    }
    
    func comparisonButtonTapped(pushedButton: String) {
        switch pushedButton {
        case "=":
            makeChoiceIfPlayerPushedEqualButton()
        case "<":
            makeChoiceIfPlayerPushedLessButton()
        case ">":
            makeChoiceIfPlayerPushedGreaterButton()
        default:
            break
        }
    }
    
    // MARK: - Computer's Brain
    private func makeChoiceIfPlayerPushedEqualButton() {
        if guessNumberPlayer == currentChosenNumberComputer {
            view.performSegue(identifier: "ToGamePartTwoSegue")
        } else {
            view.showError(title: "😏", message: "Don't lie")
        }
    }
    
    private func makeChoiceIfPlayerPushedLessButton() {
        if guessNumberPlayer < currentChosenNumberComputer {
            maxChosenNumberComputer = currentChosenNumberComputer
            currentChosenNumberComputer = (maxChosenNumberComputer - minChosenNumberComputer) / 2 + minChosenNumberComputer
            triesComputer += 1
            setLabelsText()
        } else {
            view.showError(title: "😏", message: "Don't lie")
        }
    }
    
    private func makeChoiceIfPlayerPushedGreaterButton() {
        if guessNumberPlayer > currentChosenNumberComputer {
            minChosenNumberComputer = currentChosenNumberComputer
            currentChosenNumberComputer = (maxChosenNumberComputer - minChosenNumberComputer) / 2 + minChosenNumberComputer
            
            if currentChosenNumberComputer == minChosenNumberComputer {
                currentChosenNumberComputer = 100
            }
            
            triesComputer += 1
            setLabelsText()
        } else {
            view.showError(title: "😏", message: "Don't lie")
        }
    }
}
