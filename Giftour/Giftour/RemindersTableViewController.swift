//
//  RemindersTableViewController.swift
//  Giftour
//
//  Created by Quinton Negron on 1/10/21.
//  Copyright © 2021 Quinton Negron. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData
var remindersOb = [ReminderItem]()

class RemindersTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let fetchRequest: NSFetchRequest<ReminderItem> = ReminderItem.fetchRequest()
        do{
            let remindob = try persistence.context.fetch(fetchRequest)
            remindersOb = remindob
        }catch{}
    }
    func schedule(nametext: String, desText: String, dateTime: Date){
        let content = UNMutableNotificationContent()
        content.title = nametext
        content.sound = .default
        content.body = desText
    
        let datetime = dateTime
        let schedule = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: datetime), repeats: false)

        let request = UNNotificationRequest(identifier: "notif Optional(\(String(describing: datetime)))", content: content, trigger: schedule)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil{
                print("error")
            }
        })
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remindersOb.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "remind", for: indexPath)
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["notif \(String(describing: remindersOb[indexPath.row].remindAt))"])
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: remindersOb[indexPath.row].remindAt!)
        let backgroundView = UIView()
        cell.selectedBackgroundView = backgroundView
        let nameLabel = cell.viewWithTag(12) as! UILabel
        nameLabel.text = remindersOb[indexPath.row].title
        
        let desLabel = cell.viewWithTag(13) as! UILabel
        desLabel.text = remindersOb[indexPath.row].des
        
        let dateLabel = cell.viewWithTag(14) as! UILabel
        dateLabel.text = strDate
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["notif \(String(describing: remindersOb[indexPath.row].remindAt))"])
            persistence.context.delete(remindersOb[indexPath.row])
            remindersOb.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
