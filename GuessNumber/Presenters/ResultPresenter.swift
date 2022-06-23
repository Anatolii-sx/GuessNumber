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
}

class ResultPresenter: ResultPresenterProtocol {
    private unowned let view: ResultViewProtocol
    
    // MARK: - Realization ResultPresenterProtocol Init (Connection View -> Presenter)
    required init(view: ResultViewProtocol) {
        self.view = view
    }
}
