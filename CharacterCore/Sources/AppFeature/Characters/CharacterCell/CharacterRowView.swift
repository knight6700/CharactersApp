import DesignComponent
import SwiftUI

import enum Models.FilterStatus
import struct Models.MainCharacter

struct CharacterRowView: View {
    let character: MainCharacter

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            CharacterImageView(
                cornerRadius: 12,
                image: character.image
            )
            .frame(width: 80, height: 80)
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.primary)
                Text(character.species)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    character.status == .unknown ? .gray.opacity(0.3) : .clear,
                    lineWidth: 1
                )
                .fill(character.status.color)
        )
    }
}
extension FilterStatus {
    var color: Color {
        switch self {
        case .alive: .cyan.opacity(0.2)
        case .dead: .red.opacity(0.2)
        case .unknown: .white
        }
    }
}
#if DEBUG
#Preview {
    VStack {
        Text("Live")
        CharacterRowView(character: .live)
        Text("Dead")
        CharacterRowView(character: .dead)
        Text("unknown")
        CharacterRowView(character: .unknown)
    }
}
#endif
