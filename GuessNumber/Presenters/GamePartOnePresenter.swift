//
//  GamePartOnePresenter.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 23.06.2022.
//

import Foundation

// MARK: - GamePartOnePresenterProtocol (Connection View -> Presenter)
protocol GamePartOnePresenterProtocol {
    init(view: GamePartOneViewProtocol)
}

class GamePartOnePresenter: GamePartOnePresenterProtocol {
    private unowned let view: GamePartOneViewProtocol
    
    // MARK: - Realization GamePartOnePresenterProtocol Init (Connection View -> Presenter)
    required init(view: GamePartOneViewProtocol) {
        self.view = view
    }
}
