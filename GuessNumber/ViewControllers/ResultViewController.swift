//
//  ResultViewController.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 22.06.2022.
//

import UIKit

// MARK: - ResultViewProtocol (Connection Presenter -> View)
protocol ResultViewProtocol: AnyObject {
    func changeTriesCountLabels(playerScore: String, computerScore: String)
    func changeWinnerLabel(text: String)
}

class ResultViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var triesPlayerLabel: UILabel!
    @IBOutlet weak var triesComputerLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    // MARK: - Public Properties
    var triesComputer: Int!
    var triesPlayer: Int!
    
    // MARK: - Private Properties
    private var presenter: ResultPresenterProtocol!
    
    // MARK: - Methods Of ViewController's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ResultPresenter(view: self)
        presenter.getTheWinner(triesComputer: triesComputer, triesPlayer: triesPlayer)
    }
}

// MARK: - Realization ResultViewProtocol Methods (Connection Presenter -> View)
extension ResultViewController: ResultViewProtocol {
    func changeTriesCountLabels(playerScore: String, computerScore: String) {
        triesPlayerLabel.text = playerScore
        triesComputerLabel.text = computerScore
    }
    
    func changeWinnerLabel(text: String) {
        winnerLabel.text = text
    }
}
