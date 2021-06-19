import UIKit

protocol ErrorHandlingViewModelProtocol {
    var errorMessage: ErrorMessage? { get }
    var action: () -> Void { get }
}

final class ErrorHandlingViewController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel = TitleLabel(textAlignment: .center, size: 20)
    private let messageLabel = BodyLabel(textAlignment: .center)
    private let actionBtn = RIButton(color: .systemBlue, title: "")
    private var viewModel: ErrorHandlingViewModelProtocol!
    
    var viewModelFactory: () -> ErrorHandlingViewModelProtocol = {
        fatalError("View model has not been created")
    }
    
    // MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
        bind(viewModel: viewModelFactory())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.hidesBackButton = false
    }
}

// MARK: - Private implementation
private extension ErrorHandlingViewController {
    
    func bind(viewModel: ErrorHandlingViewModelProtocol) {
        self.viewModel = viewModel
        
        if let errorMessage = viewModel.errorMessage {
            configureTitleLabel(with: errorMessage.title)
            configureMessageLabel(with: errorMessage.description ?? "")
            
            if !errorMessage.actionTitle.isEmpty {
                configureActionBtn(with: errorMessage)
            }
        }
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Error"
    }
    
    func configureTitleLabel(with title: String) {
        view.addSubview(titleLabel)
        
        titleLabel.text = title
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configureMessageLabel(with message: String) {
        view.addSubview(messageLabel)
        
        messageLabel.text = message
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func configureActionBtn(with errorMessage: ErrorMessage) {
        view.addSubview(actionBtn)
        
        actionBtn.setTitle(errorMessage.actionTitle, for: .normal)
        actionBtn.addTarget(self, action: #selector(didActionBtnTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            actionBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            actionBtn.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func didActionBtnTapped() {
        viewModel.action()
    }
}
