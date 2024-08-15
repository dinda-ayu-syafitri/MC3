//
//  ContentView.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 09/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MessageNotificationViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button(action: {
                viewModel.sendPushNotification(token: "cKq5y-NsdEoasmnLdure3u:APA91bHxwDFm5uwlGZNIzLxphEt3Qy1iRAG10LNFy_df1sZkESiIGX4JsXY9nQC9tK1N1t59lX7-wblSgi9lNGBPAPSBaphPfmSPRRWwEowXnETgORDVpVwT7WxjljFZBhzLU8lSvvIc", title: "MC3 App!", body: "Notification triggered from button!", locationLink: "locationLInk 123", senderFCM: "test 123")
            }, label: {
                Text("Send A Notification")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
