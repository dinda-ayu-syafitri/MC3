//
//  StatusTrackView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 19/08/24.
//

import SwiftUI
import MessageUI

struct StatusTrackView: View {
    @State private var status: Int = 2
    @EnvironmentObject var router: Router
    @State private var showingMessageCompose = false
    @State private var messageSent = false
   // @State private var isOpened: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
                   VStack {
                       if status == 1{
                           sent()
                       }else{
                           track()
                       }
                   }
            Spacer().frame(height: -50)
                   
            VStack{
                Button {
                    makeCall()
                    sendMessage()
                        
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 340, height: 120)
                            .foregroundStyle(Color.appPink)
                        Text("Call Ayah")
                            .foregroundStyle(Color.white)
                            .font(.title2)
                            .bold()
                    }
                }
                .sheet(isPresented: $showingMessageCompose) {
                    MessageComposeViewControllerWrapper(isPresented: $showingMessageCompose, messageSent: $messageSent)
                }
                .padding()
                
                
                
                Button {
//                     print("open sheet")
//                     self.isOpened = true
                } label: {
                    ZStack{
                        Text("Deactivate Alert")
                            .foregroundStyle(Color.yellowDeactivate)
                            .bold()
                    }
                    .onTapGesture {
                        router.navigateTo(.HomeView)
                    }

                }
                

            }
            Spacer()
        }
        .background(Color(.bg).ignoresSafeArea())
//         .sheet(isPresented: $isOpened, content: {
//             DeactivateView(isActive: $isOpened)
//         })
//         .padding(.horizontal, 16)
//         .padding(.top, 98)
//         .padding(.bottom, 40)
//         .frame(maxWidth: .infinity, maxHeight: .infinity)
//         .background(Color.grayBrand)
//         .ignoresSafeArea()
    }
    
    func makeCall() {
        let phoneNumber = "+6287780605052"
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
            print("Attempting to call: \(phoneNumber)")
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        } else {
            print("Failed to create URL for the phone number.")
        }
    }

    func sendMessage() {
        showingMessageCompose = true
    }
}

struct sent:View {
    var body: some View {
        ZStack{
            Color.white
                .frame(width: 361, height: 535)
                .cornerRadius(10)
                .padding()
            
            VStack{
                Image("sent")
                    .resizable()
                    .frame(width: 297, height: 285)
                    .foregroundStyle(Color.appPinkSecondary)
                Text("SOS Alert Has Been Sent")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.appPinkSecondary)
                    .padding(.top,52)
                
                Text("Emergency notifications has been sent to your emergency contacts")
                    .font(.callout)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top,-4)
                    .padding(.horizontal, 32)
                Spacer().frame(height: 50)
                
            }
            
        }
    }
}

struct track:View {
    var body: some View {
        ZStack{
            Color.white
                .frame(width: 361, height: 535)
                .cornerRadius(10)
                .padding()
            
            VStack{
                Image("tracking")
                    .resizable()
                    .frame(width: 297, height: 285)
                    .foregroundStyle(Color.appPinkSecondary)
                Text("Ayah is tracking you")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.appPinkSecondary)
                    .padding(.top,52)
                
                Text("Your emergency contact is currently tracking your live location")
                    .font(.callout)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top,-4)
                    .padding(.horizontal, 32)
                Spacer().frame(height: 50)
                
            }
            
        }
    }
}

struct MessageComposeViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var messageSent: Bool

    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        var parent: MessageComposeViewControllerWrapper

        init(parent: MessageComposeViewControllerWrapper) {
            self.parent = parent
        }

        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            parent.isPresented = false
            parent.messageSent = (result == .sent)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let composeVC = MFMessageComposeViewController()
        composeVC.body = "Someone is calling you"
        composeVC.recipients = ["+6287780605052"] // You can set the recipient's number here
        composeVC.messageComposeDelegate = context.coordinator
        return composeVC
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}
}

#Preview {
    StatusTrackView()
}
