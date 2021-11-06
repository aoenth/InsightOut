//
//  EmojiWheel.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
//

import SwiftUI
import InsightOut

struct EmojiWheel: View {
    
    let animationScale = 1.1
    let animationDuration = 0.2

    @State private var isAnimated = false
    @Binding var moodStatus: Mood
    @Binding var backgroundColor: Color
    let onTap: () -> Void

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            ZStack {
                EmojiPieChart(data: emojiChartDataSet, moodStatus: $moodStatus, backgroundColor: $backgroundColor)
                
                ZStack {
                    Circle()
                        .fill(Color.white)
                    
                        .frame(width: width * 0.45, height: width * 0.45)
                        .scaleEffect(isAnimated ? animationScale : 1)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/(duration: animationDuration))
                    Image(systemName: "plus")
                        .font(Font.system(size: width * 0.2, weight: .bold))
                        .frame(width: width * 0.45, height: width * 0.45)
                        .foregroundColor(backgroundColor)
                        .scaleEffect(isAnimated ? animationScale : 1)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/(duration: animationDuration)) 
                }
                .onTapGesture {
                    onTap()
                    print("hi")
                    isAnimated = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        isAnimated = false
                    }
                }
            }
        }
    }
}

struct EmojiWheel_Previews: PreviewProvider {
    @State static var moodStatus = Mood.happiness
    @State static var backgroundColor = Color("happiness")
    static var previews: some View {
        EmojiWheel(moodStatus: $moodStatus, backgroundColor: $backgroundColor) { }
    }
}
