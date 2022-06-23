//
//  ResultViewController.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 22.06.2022.
//

import UIKit

// MARK: - ResultViewProtocol (Connection Presenter -> View)
protocol ResultViewProtocol: AnyObject {
    
}

class ResultViewController: UIViewController {

    var triesComputer: Int!
    var triesPlayer: Int!
    
    // MARK: - Private Properties
    private var presenter: ResultPresenterProtocol!
    
    @IBOutlet weak var triesPlayerLabel: UILabel!
    @IBOutlet weak var triesComputerLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        triesPlayerLabel.text = "Your's tries count: \(triesPlayer ?? 0)"
        triesComputerLabel.text = "Computer's tries count: \(triesComputer ?? 0)"
        showTheWinner()
        
        presenter = ResultPresenter(view: self)
    }

    func showTheWinner() {
        winnerLabel.isHidden = false
        if triesPlayer == triesComputer {
            winnerLabel.text = "Nobody Win"
        } else if triesPlayer < triesComputer {
            winnerLabel.text = "You Win"
        } else if triesPlayer > triesComputer {
            winnerLabel.text = "Computer Win"
        }
    }
}

// MARK: - Realization ResultViewProtocol Methods (Connection Presenter -> View)
extension ResultViewController: ResultViewProtocol {
    
}
