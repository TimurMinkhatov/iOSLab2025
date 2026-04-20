import SwiftUI

public struct UserCardView: View {
  public let name: String
  public let username: String
  public let email: String

  public init(name: String, username: String, email: String) {
    self.name = name
    self.username = username
    self.email = email
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(name)
        .font(.headline)
      Text("@\(username)")
        .font(.subheadline)
        .foregroundStyle(.blue)
      Text(email)
        .font(.caption)
        .foregroundStyle(.secondary)
    }
    .padding(12)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12))
  }
}
