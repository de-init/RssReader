import UIKit

class ReaderViewController: UIViewController {
    //MARK: - Properties
    private var feedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var feedTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private var feedDescription: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        text.textColor = .black.withAlphaComponent(0.8)
        text.textAlignment = .natural
        text.isEditable = false
        return text
    }()
    
    private var feedDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private var feedAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Senders Properties
    private var getImage: String
    private var getTitle: String
    private var getDescription: String
    private var getDate: String
    private var getAuthor: String
    
    //MARK: - Custom Init
    init(getImage: String, getTitle: String, getDescription: String, getDate: String, getAuthor: String) {
        self.getImage = getImage
        self.getTitle = getTitle
        self.getDescription = getDescription
        self.getDate = getDate
        self.getAuthor = getAuthor
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFeed()
    }
    
    //MARK: - viewWillLayoutSubviews
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    
    func getFeed() {
        feedTitle.text = getTitle
        feedDescription.text = getDescription
        feedDate.text = getDate
        feedAuthor.text = getAuthor
    }
}

//MARK: - Setup UI and Constraints
extension ReaderViewController {
    private func setupUI() {
        view.addSubview(feedImage)
        view.addSubview(feedTitle)
        view.addSubview(feedDescription)
        view.addSubview(feedDate)
        view.addSubview(feedAuthor)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            feedImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            feedImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            feedImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            feedImage.heightAnchor.constraint(equalToConstant: 300),
            
            feedTitle.topAnchor.constraint(equalTo: self.feedImage.bottomAnchor, constant: 10),
            feedTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            feedTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            feedDescription.topAnchor.constraint(equalTo: self.feedTitle.bottomAnchor, constant: 20),
            feedDescription.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            feedDescription.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            feedDescription.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            
            feedDate.topAnchor.constraint(equalTo: self.feedDescription.topAnchor, constant: 10),
            feedDate.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            
            feedAuthor.topAnchor.constraint(equalTo: self.feedDescription.topAnchor, constant: 10),
            feedAuthor.leadingAnchor.constraint(equalTo: self.feedDate.trailingAnchor, constant: 10)
        ])
    }
}
