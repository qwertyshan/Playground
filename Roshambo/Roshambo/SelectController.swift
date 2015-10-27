//
//  ViewController.swift
//  Roshambo
//
//  Created by Shantanu Rao on 10/23/15.
//  Copyright © 2015 Shantanu Rao. All rights reserved.
//

import UIKit

class SelectController: UIViewController {

    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    
    override func viewDidLoad() {
        rockButton.titleLabel?.hidden = true
        paperButton.titleLabel?.hidden = true
        scissorsButton.titleLabel?.hidden = true
    }

    
    @IBAction private func playPaper(sender: UIButton) {
        performSegueWithIdentifier("play", sender: sender)
    }
    
    private func getUserShape(sender: UIButton) -> Shape {
        let shape: Shape
        switch sender {
        case rockButton:
            shape = Shape.rock
        case paperButton:
            shape = Shape.paper
        default:
            shape = Shape.scissors
        }
        return shape
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "play" {
            let vc = segue.destinationViewController as! ResultsController
            vc.userChoice = getUserShape(sender as! UIButton)
        }
    }
    
}

