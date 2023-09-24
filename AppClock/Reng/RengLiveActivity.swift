//
//  RengLiveActivity.swift
//  Reng
//
//  Created by tran.anh.tub on 15/09/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct RatingView: View {
    @State private var username: String = ""
    
    var body: some View {
        Text("Vui lòng cho đánh giá")
                      
        VStack {
            Button("Start Activity") {
                print("submit")
            }
        }
        
    }
}


struct RengLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RengAttributes.self) { context in
            // TODO: 2. Create Live Activity Ui with Swift UI
            let currentTime = Date().timeIntervalSince1970
            let startTime = context.state.startTime.timeIntervalSince1970
            let endTime = context.state.endTime.timeIntervalSince1970

            let elapsedTime = currentTime - startTime
            let totalTime = endTime - startTime

            let progress = Float(elapsedTime / totalTime)
            
            VStack {
                Text(context.attributes.timerName)
                              .font(.headline)
                if context.state.inProgress {
                    Text("Đơn hàng đang đến")
                    ProgressView(value: progress)
                } else {
                    RatingView()
                }
            }
            .padding(.all)
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            // TODO: 3. Create DynamicIsland UI with Swift UI
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                }
            } compactLeading: {
                Image(systemName: "star")
                    .font(.system(size: 30))
                    .foregroundColor(.gray)
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("Min")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

//struct RengLiveActivity_Previews: PreviewProvider {
//    static let attributes = RengAttributes(timerName: "Me")
//    static let contentState = RengAttributes.ContentState(endTime: Date().addingTimeInterval(60), startTime: .now, inProgress: true)
//
//    static let contentStateSubmit = RengAttributes.ContentState(endTime: Date().addingTimeInterval(60), startTime: .now, inProgress: false)
//
//    static var previews: some View {
//        attributes
//            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
//            .previewDisplayName("Compact")
//        attributes
//            .previewContext(contentStateSubmit, viewKind: .dynamicIsland(.expanded))
//            .previewDisplayName("Submit")
//        attributes
//            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
//            .previewDisplayName("Minimal")
//        attributes
//            .previewContext(contentState, viewKind: .content)
//            .previewDisplayName("Notification")
//    }
//}
