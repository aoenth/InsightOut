//
//  MonthTab.swift
//  InsightOut
//
//  Created by Kevin Peng on 2021-11-07.
//

import SwiftUI
import InsightOut

struct MonthTab: View {

    @EnvironmentObject var loader: Loader
    @State private var selectedEmotion = 7
    @State private var entries = [Date: [MoodEntry]]()

    var body: some View {
        VStack {
            filter
            MonthView(entries: entries)
        }
    }

    var filter: some View {
        GeometryReader { proxy in
            let width = proxy.size.width

            HStack(spacing: 5) {

                ForEach(Mood.allCases, id: \.self) { mood in

                    Button{

                        selectedEmotion = emotionLookup[String(describing: mood)]!

                    } label:{
                        ZStack {
                            Circle()
                                .fill(Color(String(describing: mood)))
                                .frame(width: width * 0.12, height: width * 0.12)

                            Emoji(mood: mood)
                                .foregroundColor(Color(String(describing: mood)))
                                .frame(width: width * 0.08, height: width * 0.08)
                        }
                    }
                }

                Button{
                    selectedEmotion = emotionLookup["all"]!
                    print(selectedEmotion)
                }label:{
                    ZStack{
                        Circle()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.white)
                        Text("All")
                            .foregroundColor(.black)
                    }
                }
            }
            .frame(width: width, height: width * 0.12)
        }
    }

    func load() {

    }
}

struct MonthTab_Previews: PreviewProvider {
    static var previews: some View {
        MonthTab()
    }
}
