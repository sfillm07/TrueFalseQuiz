//
//  ArithmeticViewController.swift
//  TrueFalseStarter
//
//  Created by Sean Fillmore on 11/6/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ArithmeticViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitGame() {
        self.dismiss(animated: true, completion: nil)
    }

}
