import UIKit

class ReaderViewController: UIViewController {
    //MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.frame = view.bounds
        scroll.contentSize = contentSize
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentSize
        return view
    }()

    private var feedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private var feedTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private var feedDescription: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        text.textColor = .black.withAlphaComponent(0.8)
        text.textAlignment = .left
        text.backgroundColor = .clear
        text.isEditable = false
        text.isScrollEnabled = false
        return text
    }()
    
    private var feedDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private var feedAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var sizeTextView: CGFloat {
        return CGFloat(feedDescription.frame.height)
    }
    
    private var contentSize: CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 100)
    }
    
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
        setupUI()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        getFeed()
    }
    
    //MARK: - viewWillLayoutSubviews
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    
    //MARK: - Load Feed Data
    func getFeed() {
        guard let url = URL(string: getImage), let data = NSData(contentsOf: url) else { return }
        feedImage.image = UIImage(data: data as Data)
        feedTitle.text = getTitle
        feedDescription.text = getDescription
        feedDate.text = getDate
        feedAuthor.text = "by" + " " + getAuthor
    }
}

//MARK: - Setup UI and Constraints
extension ReaderViewController {
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(feedImage)
        contentView.addSubview(feedTitle)
        contentView.addSubview(feedDescription)
        contentView.addSubview(feedDate)
        contentView.addSubview(feedAuthor)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            feedImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            feedImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            feedImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            feedImage.heightAnchor.constraint(equalToConstant: 220),
            
            feedTitle.topAnchor.constraint(equalTo: self.feedImage.bottomAnchor, constant: 10),
            feedTitle.leadingAnchor.constraint(equalTo: self.feedImage.leadingAnchor),
            feedTitle.trailingAnchor.constraint(equalTo: self.feedImage.trailingAnchor),
            
            feedDescription.topAnchor.constraint(equalTo: self.feedTitle.bottomAnchor, constant: 10),
            feedDescription.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            feedDescription.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            
            feedDate.topAnchor.constraint(equalTo: self.feedDescription.bottomAnchor, constant: 10),
            feedDate.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            
            feedAuthor.topAnchor.constraint(equalTo: self.feedDescription.bottomAnchor, constant: 10),
            feedAuthor.leadingAnchor.constraint(equalTo: self.feedDate.trailingAnchor, constant: 10)
        ])
    }
    
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navBarAppearance.backgroundColor = UIColor(hex: 0x344E41)
        
        self.navigationItem.title = "Новость"
        
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
