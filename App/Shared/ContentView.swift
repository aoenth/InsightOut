//
//  ContentView.swift
//  Shared
//
//  Created by Kevin Peng on 2021-11-05.
//

import SwiftUI
import InsightOut
struct ContentView: View {
    @State var moodStatus = Mood.happiness
    @State var backgroundColor = Color("happiness")
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [backgroundColor, .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Emoji(mood: moodStatus)
                    .frame(width: 200, height: 200)
                    .foregroundColor(backgroundColor)
                    .padding(50)
                EmojiWheel(moodStatus: $moodStatus, backgroundColor: $backgroundColor)
                    .frame(width: 300, height: 300)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
