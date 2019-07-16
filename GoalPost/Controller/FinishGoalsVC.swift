//
//  FinishGoalsVC.swift
//  GoalPost
//
//  Created by James Volmert on 7/15/19.
//  Copyright © 2019 James Volmert. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalsVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: MaterialButton!
    @IBOutlet weak var pointsTextField: UITextField!
    var goalDescription: String!
    var goalType: GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self
       
    }
    
    func initData(description: String, goalType: GoalType) {
        self.goalDescription = description
        self.goalType = goalType
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func createGoalPressed(_ sender: Any) {
        // pass data into core data
        
    }
    
    func save(completion: (_ finished: Bool) -> () ) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.map { $0.rawValue }
        goal.goalDescriptionValue = Int32(pointsTextField.text!)!
        
    }
}
