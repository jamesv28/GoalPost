//
//  GoalsVC
//  GoalPost
//
//  Created by James Volmert on 7/8/19.
//  Copyright © 2019 James Volmert. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var goals: [Goal] = []
    
    @IBAction func addGoalPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentDetail(createGoalVC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
    }

    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell" ) as? GoalCell else { return UITableViewCell() }
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(ofIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.progressForGoal(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        addAction.backgroundColor = #colorLiteral(red: 0.5411764706, green: 0.168627451, blue: 0.8862745098, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.4117647059, blue: 0.3803921569, alpha: 1)
        
        return [deleteAction, addAction]
    }
}

extension GoalsVC {
    
    func progressForGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalDescriptionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("progress successfully saved")
        }
        catch {
            debugPrint("progress not updated \(error.localizedDescription)")
        }
    }
    
    func removeGoal(ofIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    
    func fetch(completion: (_ complete: Bool) -> () ) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            // explicitly casting this as a goals array below see if this works
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        }
        catch {
           debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        
        }
        
        
    }
}
