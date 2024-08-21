import SwiftUI

struct ContentView: View {
    @StateObject var watchConnector = iOSToWatchConnector()
    @EnvironmentObject var router: Router
    @AppStorage(KeyUserDefaultEnum.status.toString) private var logStatus: Bool = false

    var body: some View {
        RouterView {
            ZStack {
                if logStatus {
                   OnboardingViewWrapper()
                } else {
                    LoginView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
