//
//  GamePartOneViewController.swift
//  GuessNumber
//
//  Created by Анатолий Миронов on 22.06.2022.
//

import UIKit

class GamePartOneViewController: UIViewController {

    var guessNumberPlayer: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(guessNumberPlayer ?? 0)
    }
}
