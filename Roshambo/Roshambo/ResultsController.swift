//
//  ResultsController.swift
//  Roshambo
//
//  Created by Shantanu Rao on 10/23/15.
//  Copyright © 2015 Shantanu Rao. All rights reserved.
//

import Foundation
import UIKit

enum Shape: String {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
    
    // This function randomly generates an opponent's play
    static func randomShape() -> Shape {
        let shapes = ["Rock", "Paper", "Scissors"]
        let randomChoice = Int(arc4random_uniform(3))
        return Shape(rawValue: shapes[randomChoice])!
    }
    
    static func name(shape: Shape) -> String {
        switch shape {
        case rock:
            return "Rock"
        case paper:
            return "Paper"
        case scissors:
            return "Scissors"
        }
    }
    
}

class ResultsController: UIViewController {
    
    @IBOutlet private weak var resultImage: UIImageView!
    @IBOutlet private weak var resultLabel: UILabel!
    
    @IBOutlet weak var yourImage: UIImageView!
    @IBOutlet weak var opponentImage: UIImageView!
   
    var userChoice: Shape!
    private let opponentChoice: Shape = Shape.randomShape()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        displayResult()
    }
    
    func findWinner (shape1: Shape, shape2: Shape) -> String {
        var result: String
        let rock = Shape.rock
        let paper = Shape.paper
        let scissors = Shape.scissors
        
        switch (shape1, shape2) {
        case (rock, paper), (paper, rock):
            result = "Paper Wins"
        case (paper, scissors), (scissors, paper):
            result = "Scissors Wins"
        case (rock, scissors), (scissors, rock):
            result = "Rock Wins"
        default:
            result = "Tie"
        }
        print(shape1)
        print(shape2)
        print(result) //debug
        return result
    }
    
    private func displayResult() {
        var result: String
        var resultImageName: String
        
        result = findWinner(userChoice, shape2: opponentChoice)
        resultImageName = result.stringByReplacingOccurrencesOfString(" ", withString: "")
        resultImage.image = UIImage(named: resultImageName)
        resultLabel.text = result
        
        yourImage.image = UIImage(named: Shape.name(userChoice))
        opponentImage.image = UIImage(named: Shape.name(opponentChoice))
    }
    
    @IBAction private func playAgain() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
