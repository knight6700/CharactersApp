import SwiftUI
import enum Models.FilterStatus

public struct SegmentView: View {
    @Binding var selectedStatus: FilterStatus?
    let items: [FilterStatus]
    public init(
        selectedStatus: Binding<FilterStatus?>,
        items: [FilterStatus]
    ) {
        self._selectedStatus = selectedStatus
        self.items = items
    }
    public var body: some View {
        HStack(spacing: 16) {
            ForEach(items, id: \.id) { status in
                Text(status.rawValue)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(selectedStatus == status ? Color.purple : Color.gray.opacity(0.5), lineWidth: 2)
                    )
                    .foregroundColor(selectedStatus == status ? Color.purple : Color.black)
                    .onTapGesture {
                        selectedStatus = status
                    }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}
#if DEBUG
#Preview {
    SegmentView(
        selectedStatus: .constant(.alive),
        items: FilterStatus.allCases
    )
}
#endif
