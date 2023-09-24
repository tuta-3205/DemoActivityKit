import SwiftUI
import ActivityKit

struct ContentView: View {
    // TODO: 4. Create Activity<RengAttributes>
    @State private var activity: Activity<RengAttributes>? = nil
    @State private var timer: Timer?
    @State private var startTime: Date?
    
    var body: some View {
        VStack(spacing: 16.0) {
            Button("Start Activity") {
                // TODO: 4. Tap to Start Activity<RengAttributes>
                start()
            }
            
            Button("Stop Activity") {
                // TODO: 4. Tap to Stop Activity<RengAttributes>
                stop()
            }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
    
    func start() {
        let attribute = RengAttributes(timerName: "Tuta")
        
        startTime = Date()

        let initialState = RengAttributes.ContentState(
            endTime: Date().addingTimeInterval(10),
            startTime: startTime ?? .now,
            inProgress: true
        )

        let content = ActivityContent(state: initialState, staleDate: nil, relevanceScore: 0.0)
        
        activity = try? Activity.request(
            attributes: attribute,
            content: content,
            pushType: nil
        )
        if let _ = activity {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                update()
            }
        }
    }
    
    func stop() {

        print(Date().addingTimeInterval(60))
        let state = RengAttributes.TimerStatus(endTime: .now, startTime: startTime ?? .now, inProgress: true)
        let content = ActivityContent(state: state, staleDate: nil, relevanceScore: 0.0)
        
        Task {
            await activity?.end(content, dismissalPolicy: .immediate)
        }
    }
    
    func toRating() {

        if let endTime = activity?.content.state.endTime {
            let state = RengAttributes.TimerStatus(endTime: endTime, startTime: startTime ?? .now, inProgress: false)
            Task {
                await activity?.update(
                    ActivityContent<RengAttributes.ContentState>(
                        state: state,
                        staleDate: nil
                    )
                )
            }
        }
    }
    
    func update() {
        
        if let endTime = activity?.content.state.endTime {
            if endTime  <= .now{
                timer?.invalidate()
                toRating()
                return
            }
            let state = RengAttributes.TimerStatus(endTime: endTime, startTime: startTime ?? .now, inProgress: true)
            Task {
                await activity?.update(
                    ActivityContent<RengAttributes.ContentState>(
                        state: state,
                        staleDate: nil
                    )
                )
            }
        }
        
    }
}
