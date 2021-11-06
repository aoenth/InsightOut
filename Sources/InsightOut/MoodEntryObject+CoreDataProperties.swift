//
//  MoodEntryObject+CoreDataProperties.swift
//  InsightOut
//
//  Created by Kevin Peng on 2021-11-06.
//
//

import Foundation
import CoreData

extension MoodEntryObject {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<MoodEntryObject> {
        return NSFetchRequest<MoodEntryObject>(entityName: "MoodEntryObject")
    }

    @NSManaged public var label: Int32
    @NSManaged public var mood: Int32
    @NSManaged public var time: Date

}
