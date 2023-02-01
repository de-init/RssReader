import UIKit

class FeedTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let reuseID = "FeedTableViewCell"
    
    private var feedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "test")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private var feedTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            switch traitCollection.userInterfaceStyle {
            case .unspecified, .light:
                return .black
            case .dark:
                return .white
            default:
                return .black
            }
        }
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "unknown"
        return label
    }()

    private var feedDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .gray
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = "unknown"
        return label
    }()
    
    private var feedAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .gray
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = "unknown"
        return label
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(feedImageView)
        contentView.addSubview(feedTitle)
        contentView.addSubview(feedDate)
        contentView.addSubview(feedAuthor)
    }
    
    //MARK: - Configure method
    func configure(imageData: Data, titleText: String, dateText: String, authorText: String) {
        self.feedImageView.image = UIImage(data: imageData)
        self.feedTitle.text = titleText
        self.feedDate.text = dateText
        self.feedAuthor.text = authorText
    }
    
    //MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            feedImageView.heightAnchor.constraint(equalToConstant: 90),
            feedImageView.widthAnchor.constraint(equalToConstant: 140),
            feedImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            feedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            feedTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            feedTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            feedTitle.trailingAnchor.constraint(equalTo: feedImageView.leadingAnchor, constant: -20),
            
            feedDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            feedDate.leadingAnchor.constraint(equalTo: feedTitle.leadingAnchor),
            
            feedAuthor.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            feedAuthor.leadingAnchor.constraint(equalTo: feedDate.trailingAnchor, constant: 10)
        ])
    }
}
