import SwiftUI

struct CustomTabBar: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "house.fill")
            Spacer()
            Image(systemName: "magnifyingglass")
            Spacer()
            Image(systemName: "person.fill")
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .shadow(radius: 5)
    }
}
