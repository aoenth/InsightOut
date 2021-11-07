//
//  HomeView.swift.swift
//  InsightOut
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import SwiftUI
import InsightOut

struct HomeView: View {
    @State private var moodStatus = Mood.happiness
    @State private var backgroundColor = Color("happiness")
    @State private var colors = [Color]()

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [backgroundColor, .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                EmotionsOfTheDayView(colors: colors)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(lineWidth: 2)
                            .foregroundColor(.white)
                    )
                    .frame(minHeight: 25, maxHeight: 50)
                    .padding()
                Emoji(mood: moodStatus)
                    .frame(width: 200, height: 200)
                    .foregroundColor(backgroundColor)
                    .padding(50)
                EmojiWheel(moodStatus: $moodStatus, backgroundColor: $backgroundColor, onTap: onTap)
                    .frame(width: 300, height: 300)
                    .padding(.bottom, 50)
            }
        }
    }

    func onTap() {
        let colorName = String(describing: moodStatus)
        let color = Color(colorName)
        colors.append(color)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
