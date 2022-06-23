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
}

class GuessNumberPresenter: GuessNumberPresenterProtocol {
    private unowned let view: GuessNumberViewProtocol
    
    // MARK: - Realization GuessNumberPresenterProtocol Init (Connection View -> Presenter)
    required init(view: GuessNumberViewProtocol) {
        self.view = view
    }
}
