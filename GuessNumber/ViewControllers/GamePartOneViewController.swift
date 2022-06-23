//
//  GamePartOneViewController.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 22.06.2022.
//

import UIKit


// MARK: - GamePartOneViewProtocol (Connection Presenter -> View)
protocol GamePartOneViewProtocol: AnyObject {
    func updateLabels(triesComputer: String, currentChosenNumberComputer: String)
    func showError(title: String, message: String)
    func performSegue(identifier: String)
}

class GamePartOneViewController: UIViewController {

    // MARK: - Public Properties
    var guessNumberPlayer: Int!
    
    // MARK: - Private Properties
    var presenter: GamePartOnePresenterProtocol!
    
    // MARK: - IBOutlets
    @IBOutlet var comparisonButtonsPlayer: [UIButton]!
    @IBOutlet weak var triesComputerLabel: UILabel!
    @IBOutlet weak var currentChosenNumberComputerLabel: UILabel!
    
    // MARK: - Methods Of ViewController's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = GamePartOnePresenter(view: self, guessNumberPlayer: guessNumberPlayer)
        setButtons()
        presenter.setLabelsText()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gamePartTwoVC = segue.destination as? GamePartTwoViewController else { return }
        gamePartTwoVC.triesComputer = presenter.triesComputer
    }
    
    // MARK: - IBActions
    @IBAction func comparisonButtonTapped(_ sender: UIButton) {
        presenter.comparisonButtonTapped(pushedButton: sender.currentTitle ?? "")
    }
    
    // MARK: - Private Properties
    private func setButtons() {
        comparisonButtonsPlayer.forEach { button in
            button.layer.borderWidth = 1
            button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            button.backgroundColor = .clear
        }
    }
}

// MARK: - Alert Controller
extension GamePartOneViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )
        
        present(alert, animated: true)
    }
}

// MARK: - Realization GamePartOneViewProtocol Methods (Connection Presenter -> View)
extension GamePartOneViewController: GamePartOneViewProtocol {
    func updateLabels(triesComputer: String, currentChosenNumberComputer: String) {
        triesComputerLabel.text = triesComputer
        currentChosenNumberComputerLabel.text = currentChosenNumberComputer
    }
    
    func showError(title: String, message: String) {
        showAlert(title: title, message: message)
    }
    
    func performSegue(identifier: String) {
        performSegue(withIdentifier: identifier, sender: nil)
    }
}
