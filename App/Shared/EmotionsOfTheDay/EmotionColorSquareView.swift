//
//  EmotionColorSquareView.swift
//  InsightOut
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import SwiftUI

struct EmotionColorSquareView: View {
    var color: Color
    
    var body: some View {
        Rectangle()
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundColor(color)
    }
}

struct EmotionColorSquareView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionColorSquareView(color: .red)
            .previewLayout(.sizeThatFits)
    }
}
