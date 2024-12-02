import SwiftUI
import Kingfisher

public struct CharacterImageView: View {
    let cornerRadius: CGFloat
    let image: URL?
    public init(
        cornerRadius: CGFloat,
        image: URL?
    ) {
        self.cornerRadius = cornerRadius
        self.image = image
    }
    public var body: some View {
        KFImage(image)
            .resizable()

            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}
