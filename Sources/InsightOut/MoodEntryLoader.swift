//
//  File.swift
//  
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import Foundation

public protocol MoodEntryLoader {
    func moods(forDate: Date) -> [MoodEntry]
    func moods(forWeekStarting: Date) -> [Date: [MoodEntry]]
    func moods(startDate: Date, endDate: Date) -> [Date: [MoodEntry]]
    func saveMood(_ mood: Mood, date: Date, label: Label)
}
