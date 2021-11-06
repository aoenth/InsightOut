//
//  HomeView.swift.swift
//  InsightOut
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import SwiftUI
import InsightOut

struct HomeView: View {
    @State var moodStatus = Mood.happiness
    @State var backgroundColor = Color("happiness")
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [backgroundColor, .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                EmotionsOfTheDayView(colors: .constant([Color("anger"),Color("happiness"),Color("fear"),Color("disgust"),Color("love"),Color("sadness"),Color("surprised")])) //TODO: Get last (10?) colors of the moods from today!
                    .frame(minHeight: 25, maxHeight: 50)
                    .padding()
                Emoji(mood: moodStatus)
                    .frame(width: 200, height: 200)
                    .foregroundColor(backgroundColor)
                    .padding(50)
                EmojiWheel(moodStatus: $moodStatus, backgroundColor: $backgroundColor)
                    .frame(width: 300, height: 300)
                    .padding(.bottom, 50)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
