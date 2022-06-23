//
//  GamePartTwoPresenter.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 23.06.2022.
//

import Foundation

// MARK: - GamePartTwoPresenterProtocol (Connection View -> Presenter)
protocol GamePartTwoPresenterProtocol {
    init(view: GamePartTwoViewProtocol)
}

class GamePartTwoPresenter: GamePartTwoPresenterProtocol {
    private unowned let view: GamePartTwoViewProtocol
    
    // MARK: - Realization GamePartTwoPresenterProtocol Init (Connection View -> Presenter)
    required init(view: GamePartTwoViewProtocol) {
        self.view = view
    }
}
