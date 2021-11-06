//
//  EmojiWheel.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
//

import SwiftUI

struct EmojiWheel: View {
    
    let animationScale = 1.1
    let animationDuration = 0.2
    
    @State var isAnimated = false
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            ZStack {
                PieChart(title: "CHART", data: chartDataSet, separatorColor: Color.white, accentColors: pieColors)
                
                Circle()
                    .fill(Color.white)
                    .onTapGesture {
                        print("hi")
                        isAnimated = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                            isAnimated = false
                        }
                    }
                    .frame(width: width * 0.45, height: width * 0.45)
                    .scaleEffect(isAnimated ? animationScale : 1)
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/(duration: animationDuration))
                Image(systemName: "plus")
                    .font(Font.system(size: width * 0.2, weight: .bold))
                    .frame(width: width * 0.45, height: width * 0.45)
                    .foregroundColor(Color.black)
                    .scaleEffect(isAnimated ? animationScale : 1)
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/(duration: animationDuration))
            }
        }
    }
}

struct EmojiWheel_Previews: PreviewProvider {
    static var previews: some View {
        EmojiWheel()
    }
}
