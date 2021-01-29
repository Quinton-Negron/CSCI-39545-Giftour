//
//  ReminderItem+CoreDataProperties.swift
//  Giftour
//
//  Created by Quinton Negron on 1/10/21.
//  Copyright © 2021 Quinton Negron. All rights reserved.
//

import Foundation
import CoreData

extension ReminderItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReminderItem> {
        return NSFetchRequest<ReminderItem>(entityName: "Notification")
    }

    @NSManaged public var remindAt: Date?
    @NSManaged public var title: String?
    @NSManaged public var des: String?

}
