import SwiftUI

struct MainView: View {
    @State private var showModal = false

    var body: some View {
        VStack {
            Spacer()

            Button(action: {
                showModal = true
            }) {
                Text("사진 편집 모달 열기")
                    .font(.title2)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .sheet(isPresented: $showModal) {
            ModalImageEditorView()
        }
    }
}

#Preview {
    MainView()
}
