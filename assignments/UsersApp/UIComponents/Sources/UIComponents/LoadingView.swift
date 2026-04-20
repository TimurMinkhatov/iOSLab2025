import SwiftUI

public struct LoadingView: View {
  public let message: String

  public init(message: String = "Loading...") {
    self.message = message
  }

  public var body: some View {
    VStack(spacing: 12) {
      ProgressView()
        .scaleEffect(1.2)
      Text(message)
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
