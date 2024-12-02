import SwiftUI
import DesignComponent
import struct Models.MainCharacter

public struct CharacterDetailsView: View {

    var viewModel: CharacterDetailsViewModel

    public var body: some View {
        GeometryReader(content: { geometry in
            VStack(alignment: .leading) {
                CharacterImageView(
                    cornerRadius: 25,
                    image: viewModel.state.image
                )
                .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                CharacterInfoView(
                    character: viewModel.state.character
                )
                .padding(.top)
            }
        })
        .edgesIgnoringSafeArea(.top)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    viewModel.trigger(.backButtonTapped)
                }, label: {
                    ZStack {
                        Circle()
                            .frame(width: 40)
                            .foregroundStyle(.white)
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .frame(width: 20, height: 15)
                            .foregroundStyle(.black)
                    }
                })
            }
        }
    }
}
#if DEBUG
#Preview {
    NavigationStack {
        CharacterDetailsView(
            viewModel: CharacterDetailsViewModel(
                state: CharacterDetailsViewModel.State(character: .live),
                appRouter: AppRouter()
            )
        )
    }
}
#endif
