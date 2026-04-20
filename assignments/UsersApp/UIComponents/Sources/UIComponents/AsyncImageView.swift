import SwiftUI
import Kingfisher

public struct AsyncImageView: View {
  public let url: URL?
  public let size: CGFloat

  public init(url: URL?, size: CGFloat = 44) {
    self.url = url
    self.size = size
  }

  public var body: some View {
    KFImage(url)
      .placeholder {
        Image(systemName: "person.circle.fill")
          .resizable()
          .foregroundStyle(.secondary)
      }
      .resizable()
      .scaledToFill()
      .frame(width: size, height: size)
      .clipShape(Circle())
  }
}
