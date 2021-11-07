
//
//  OverviewView.swift
//  InsightOut
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import SwiftUI
import InsightOut

extension Dictionary where Value: Equatable {
    func key(from value: Value) -> Key? {
        return self.first(where: { $0.value == value })?.key
    }
}

struct OverviewView: View {
    @EnvironmentObject var loader: Loader

    @State private var selectedTime = 0
    
    @State private var selectedEmotion = 7

    @State private var entries = [Date: [MoodEntry]]()
    @State private var monthEntries = [Date: [MoodEntry]]()

    let emotionLookup = [
        "happiness":0,
        "sadness":1,
        "love":2,
        "fear":3,
        "disgust":4,
        "surprised":5,
        "anger":6,
        "all":7
    ]

    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [Color(emotionLookup.key(from: selectedEmotion) ?? "white"), .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack{

                if selectedEmotion == 0 {
                    EmptyView()
                } else {
                    MonthView(entries: monthEntries)
                }

                Picker("Tap Me", selection: $selectedTime) {
                    Text("Week").tag(0)
                    Text("Month").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                

            }.padding()
        }.onAppear(perform: load)
    }

    func load() {
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        entries = loader.moods(forWeekStarting: startDate)


        let startDateForMonth = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        monthEntries = loader.moods(forWeekStarting: startDateForMonth)
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
            .environmentObject(Loader(context: CoreDataStack.preview.context))
    }
}
