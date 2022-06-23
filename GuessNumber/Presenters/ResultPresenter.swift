//
//  ResultPresenter.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 23.06.2022.
//

import Foundation

// MARK: - ResultPresenterProtocol (Connection View -> Presenter)
protocol ResultPresenterProtocol {
    init(view: ResultViewProtocol)
    func getTheWinner(triesComputer: Int, triesPlayer: Int)
}

class ResultPresenter: ResultPresenterProtocol {
    
    // MARK: - Private Properties
    private unowned let view: ResultViewProtocol
    
    // MARK: - Realization ResultPresenterProtocol Init (Connection View -> Presenter)
    required init(view: ResultViewProtocol) {
        self.view = view
    }
    
    // MARK: - Realization ResultPresenterProtocol Methods (Connection View -> Presenter)
    func getTheWinner(triesComputer: Int, triesPlayer: Int) {
        view.changeTriesCountLabels(
            playerScore: "Your's tries count: \(triesPlayer)",
            computerScore: "Computer's tries count: \(triesComputer)"
        )
        
        if triesPlayer == triesComputer {
            view.changeWinnerLabel(text:"Nobody Win")
        } else if triesPlayer < triesComputer {
            view.changeWinnerLabel(text:"You Win")
        } else if triesPlayer > triesComputer {
            view.changeWinnerLabel(text:"Computer Win")
        }
    }
}
