//
//  ReminderViewController.swift
//  Giftour
//
//  Created by Quinton Negron on 1/10/21.
//  Copyright © 2021 Quinton Negron. All rights reserved.
//
import UIKit
import UserNotifications
import CoreData


protocol RemindDelegate: class {
    func didTapSave(name: String, des:String, remindDate: Date)
}

class ReminderViewController: UIViewController {
    
    weak var remindDelegate: RemindDelegate?
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var desText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
    }
    
    @IBAction func SaveButton() {
        if let nametext = nameText.text, !nametext.isEmpty,
            let destext = desText.text, !destext.isEmpty {
            
            let notifDate = datePicker.date
            RemindersTableViewController().schedule(nametext: nametext, desText:destext, dateTime:notifDate)
            
            _ = navigationController?.popViewController(animated: true)
            
            let ob = ReminderItem(context: persistence.context)
            ob.title = nametext
            ob.des = destext
            ob.remindAt = notifDate
            remindersOb.append(ob)
            persistence.saveContext()
            
            remindDelegate?.didTapSave(name: nametext, des: destext, remindDate: notifDate)
            
        }
    }
    struct Reminder{
        let name: String
        let description: String
        let notifdate: Date
    }
    
}
