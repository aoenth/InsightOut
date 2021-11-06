//
//  ContentView.swift
//  Shared
//
//  Created by Kevin Peng on 2021-11-05.
//

import SwiftUI
import InsightOut
struct ContentView: View {
    @State var isHappy = true
    @State var mood: Mood = Mood.happiness
    var body: some View {
        VStack {
            
            EmojiIcon(emojiInfo:  EmojiInfo(backgroundColor: Color.black, selectedEmotion: mood, frameSize: 200))
        
        Button {
            withAnimation{
                isHappy.toggle()
            }
            
        } label: {
            Text("CHANGE MOOD")
        }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
