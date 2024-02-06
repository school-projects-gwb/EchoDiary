import SwiftUI

struct GrantLocationAccessView: View {
    var body: some View {
        ZStack {
            Color(.accent)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.black)
                
                Text("Allow GPS location access?")
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                
                Text("This will allow your current location to be added to (new) diary entries and shown on the map view.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.all)
                
                Spacer()
                
                VStack {
                    Button {
                        CurrentLocationManager.shared.requestUserLocationAccess()
                    } label: {
                        Text("Manage Access")
                            .padding()
                            .foregroundColor(.accent)
                            .font(.headline)
                    }
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .background(.black)
                    .clipShape(.capsule)
                    .padding()
                }
            }
        }
    }
}

#Preview {
    GrantLocationAccessView()
}
