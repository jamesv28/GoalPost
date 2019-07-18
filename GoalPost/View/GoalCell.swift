//
//  GoalCell.swift
//  GoalPost
//
//  Created by James Volmert on 7/9/19.
//  Copyright © 2019 James Volmert. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLabel: UILabel!
    
    @IBOutlet weak var timeDescriptionLabel: UILabel!
    
    @IBOutlet weak var timeInvolvementNumber: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    func configureCell(goal: Goal) {
        
        self.goalDescriptionLabel.text = goal.goalDescription
        self.timeDescriptionLabel.text = goal.goalType
        self.timeInvolvementNumber.text = String(describing: goal.goalProgress)
        
        if goal.goalProgress == goal.goalDescriptionValue {
            self.completionView.isHidden = false
        }
        else {
            self.completionView.isHidden = true
        }
        
    }
}
