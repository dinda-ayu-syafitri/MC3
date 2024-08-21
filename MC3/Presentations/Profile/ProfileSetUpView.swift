import SwiftUI

struct ProfileSetUpView: View {
//    @StateObject var profileVM = DependencyInjection.shared.profileSetUpViewModel()
    @State var username = "Jonnn"
    @State var phone = "08129312"

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("Create your profile")
                .font(.title2)
                .bold()
                .foregroundColor(.appPink)

            VStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.headline)
                        .bold()
                    
                    TextField("ex. Jane Doe", text: $username)
                        .textFieldStyle(.roundedBorder)
                    
                }
                

                VStack(alignment: .leading) {
                    Text("Phone Number")
                        .font(.headline)
                        .bold()
                    TextField("ex. 6287821285666", text: $phone)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.phonePad)
                }
            }
            Spacer().frame(height: 400)
            Button(action: {
                Task {
                   // await profileVM.submitProfileSetUp()
                }
            }, label: {
                Text("Create profile")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appPink)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
            .padding(.bottom, 32)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    ProfileSetUpView()
}
