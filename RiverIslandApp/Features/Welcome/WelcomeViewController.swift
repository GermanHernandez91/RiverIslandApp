import UIKit

protocol WelcomeViewModelProtocol {
    var title: String { get }
    
    func didActionBtnTapped()
}

final class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel = TitleLabel(textAlignment: .center, size: 24)
    private let subtitleLabel = SubtitleLabel(size: 20)
    private let actionButton = RIButton(color: .systemBlue, title: .actionTitle)
    private var viewModel: WelcomeViewModelProtocol!
    
    var viewModelFactory: () -> WelcomeViewModelProtocol = {
        fatalError("View model has not been created")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureUI()
        
        bind(viewModel: viewModelFactory())
    }
}

// MARK: - Private implementation
private extension WelcomeViewController {
    
    func bind(viewModel: WelcomeViewModelProtocol) {
        self.viewModel = viewModel
        
        navigationItem.title = viewModel.title
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func configureUI() {
        configureTitleLabel()
        configureSubtitleLabel()
        configureActionButton()
    }
    
    @objc func actionBtnTapped() {
        viewModel.didActionBtnTapped()
    }
}

// MARK: - UI Components
private extension WelcomeViewController {
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = .title
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureSubtitleLabel() {
        view.addSubview(subtitleLabel)
        
        subtitleLabel.text = .subtitle
        subtitleLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func configureActionButton() {
        view.addSubview(actionButton)
        
        actionButton.addTarget(self, action: #selector(actionBtnTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

fileprivate extension String {
    static let title = "Welcome to the RiverIsland App"
    static let subtitle = "Tap the button below and discover the best cloth collection for you"
    static let actionTitle = "ENTER"
}
