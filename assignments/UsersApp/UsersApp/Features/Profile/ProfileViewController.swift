//
//  ProfileViewController.swift
//  UsersApp
//
//  Created by Timur Minkhatov on 15/04/2026.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {

  private let user: User

  private let avatarView: UIImageView = {
    let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.layer.cornerRadius = 44
      imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let cardView: UIView = {
    let view = UIView()
    view.backgroundColor = .secondarySystemBackground
    view.layer.cornerRadius = 16
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.08
    view.layer.shadowOffset = CGSize(width: 0, height: 4)
    view.layer.shadowRadius = 8
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 22, weight: .bold)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .medium)
    label.textColor = .systemBlue
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let emailLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    label.textColor = .secondaryLabel
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let phoneLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15)
    label.textColor = .secondaryLabel
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let divider: UIView = {
    let view = UIView()
    view.backgroundColor = .separator
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let followButton: UIButton = {
    var config = UIButton.Configuration.filled()
    config.title = "Follow"
    config.cornerStyle = .large
    let button = UIButton(configuration: config)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  // MARK: - Init

  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupUI()
    configure(with: user)
    followButton.addTarget(self, action: #selector(followTapped), for: .touchUpInside)
  }

  // MARK: - Configure

  func configure(with user: User) {
    nameLabel.text = user.name
    usernameLabel.text = "@\(user.username)"
    emailLabel.text = user.email
    phoneLabel.text = user.phone

    let avatarURL = URL(string: "https://i.pravatar.cc/150?u=\(user.id)")
    avatarView.kf.setImage(
      with: avatarURL,
      placeholder: UIImage(systemName: "person.circle.fill"))
  }

  // MARK: - Setup

  private func setupUI() {
    view.addSubview(avatarView)
    view.addSubview(cardView)

    cardView.addSubview(nameLabel)
    cardView.addSubview(usernameLabel)
    cardView.addSubview(divider)
    cardView.addSubview(emailLabel)
    cardView.addSubview(phoneLabel)

    view.addSubview(followButton)

    NSLayoutConstraint.activate([
      avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
      avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      avatarView.widthAnchor.constraint(equalToConstant: 88),
      avatarView.heightAnchor.constraint(equalToConstant: 88),

      cardView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: -20),
      cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

      nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 36),
      nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
      nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),

      usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
      usernameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
      usernameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),

      divider.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 16),
      divider.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
      divider.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
      divider.heightAnchor.constraint(equalToConstant: 1),

      emailLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
      emailLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
      emailLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),

      phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
      phoneLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
      phoneLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
      phoneLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),

      followButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 32),
      followButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      followButton.widthAnchor.constraint(equalToConstant: 200),
      followButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  // MARK: - Actions

  @objc 
    private func followTapped() {
    let isFollowing = followButton.configuration?.title == "Unfollow"
    var config = followButton.configuration
    config?.title = isFollowing ? "Follow" : "Unfollow"
    config?.baseBackgroundColor = isFollowing ? .systemBlue : .systemGray
    followButton.configuration = config
  }
}
