//
//  CreateGoalVC.swift
//  GoalPost
//
//  Created by James Volmert on 7/11/19.
//  Copyright © 2019 James Volmert. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: MaterialButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var goalType : GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.deselectColor()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func nextBtnPressed(_ sender: Any) {
    }
    @IBAction func shortBtnPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.deselectColor()
        
    }
    @IBAction func longBtnPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.deselectColor()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
    
        // go back to GoalVC
        dismissDetail()
    }
    
}
