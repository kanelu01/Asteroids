//
//  PictureViewController.swift
//  Asteroids
//
//  Created by Lucas Kane on 4/21/16.
//  Copyright © 2016 Lucas Kane. All rights reserved.
//


import UIKit

class PsychologistViewController: UIViewController
{
    
    @IBAction func Brad(sender: UIButton) {
        performSegueWithIdentifier("Brad", sender: nil)
    }
    @IBAction func Spaceship(sender: UIButton) {
        performSegueWithIdentifier("Spaceship", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon =  destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let hvc = destination as? GameScene {
            if let identifier = segue.identifier{
                switch identifier {
                case "Brad": hvc.gameImage = UIImage(contentsOfFile: "Brad")
                case "Spaceship": hvc.gameImage = UIImage(contentsOfFile: "Spaceship")
                default: hvc.gameImage = UIImage(contentsOfFile: "Spaceship")
                }
            }
        }
    }
    
}

