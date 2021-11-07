//
//  CoreDataStack.swift
//  
//
//  Created by Kevin Peng on 2021-11-06.
//

import CoreData

@available(iOS 10, macOS 10.12, *)
public struct CoreDataStack {
    public static let shared = CoreDataStack()

    public static var preview: CoreDataStack = {
        let result = CoreDataStack(inMemory: true)
        let viewContext = result.container.viewContext
        let sut = MoodEntryRepository(context: viewContext)
        let dates = (-30 ..< 30).map { day in
            Calendar.current.date(byAdding: .day, value: day, to: Date())!
        }
        for date in dates {
            let mood = Mood.allCases.randomElement()!
            sut.saveMood(mood, date: date, label: .family)
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error (nsError), (nsError.userInfo)")
        }
        return result
    }()

    public var context: NSManagedObjectContext {
        container.viewContext
    }

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        let bundle = Bundle.module
        let modelURL = bundle.url(forResource: "Model", withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: modelURL)!
        container = NSPersistentContainer(name: "Model", managedObjectModel: model)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
