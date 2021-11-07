//
//  File.swift
//  
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import Foundation
import CoreData

public class MoodEntryRepository: MoodEntryLoader {
    private let context: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    let fetchRequest = MoodEntryObject.createFetchRequest()
    let dateSortDescriptor = NSSortDescriptor(key: "time", ascending: true)
    
    let calendar = Calendar.current
    
    func fetchWith(request: NSFetchRequest<MoodEntryObject>) -> [MoodEntryObject]? {
        do {
            let moodMOs = try context.fetch(fetchRequest)
            
            return moodMOs
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    public func moods(forDate: Date) -> [MoodEntry] {
        var moods = [MoodEntry]()
        
        let startDate = calendar.startOfDay(for: forDate)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        
        fetchRequest.predicate = NSPredicate(format: "time >= %@ AND time < %@", startDate as NSDate, endDate as NSDate)
        fetchRequest.sortDescriptors = [dateSortDescriptor]
        
        if let moodMOs = fetchWith(request: fetchRequest) {
            for moodMO in moodMOs {
                if let mood = Mood(rawValue: moodMO.mood),
                   let label = Label(rawValue: moodMO.label) {
                    moods.append(MoodEntry(time: moodMO.time, mood: mood, label: label))
                }
            }
        }
        
        return moods
    }
    
    public func moods(forWeekStarting: Date) -> [Date : [MoodEntry]] {
        
        let startDate = calendar.startOfDay(for: forWeekStarting)
        let endDate = calendar.date(byAdding: .day, value: 7, to: startDate)! // only 7 here since +1 will be added in moods(startDate: Date, endDate: Date)
        
        let moods = moods(startDate: startDate, endDate: endDate)
        
        return moods
    }

    public func moods(startDate: Date, endDate: Date) -> [Date : [MoodEntry]] {
        var moods = [Date: [MoodEntry]]()
        
        let startDate = calendar.startOfDay(for: startDate)
        
        fetchRequest.predicate = NSPredicate(format: "time >= %@ AND time < %@", startDate as NSDate, endDate as NSDate)
        fetchRequest.sortDescriptors = [dateSortDescriptor]
        
        if let moodMOs = fetchWith(request: fetchRequest) {
            for moodMO in moodMOs {
                if let mood = Mood(rawValue: moodMO.mood),
                   let label = Label(rawValue: moodMO.label) {
                    let time = calendar.startOfDay(for: moodMO.time)
                    let moodEntry = MoodEntry(time: moodMO.time, mood: mood, label: label)
                    moods[time, default: []].append(moodEntry)
                }
            }
        }
        
        return moods
    }
    
    public func saveMood(_ mood: Mood, date: Date, label: Label) {
        let newMoodEntryObject = MoodEntryObject(context: context)
        newMoodEntryObject.time = date
        newMoodEntryObject.mood = mood.rawValue
        newMoodEntryObject.label = label.rawValue
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
