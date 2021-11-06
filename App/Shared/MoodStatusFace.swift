//
//  MoodStatusFace.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
//

import SwiftUI
import InsightOut
struct MoodStatusFace: View {
    let mood: Mood
    var body: some View {
       
        Emoji(mood: mood)
    }
}

struct MoodStatusFace_Previews: PreviewProvider {
    static var previews: some View {
        MoodStatusFace(mood: Mood.happiness)
    }
}
