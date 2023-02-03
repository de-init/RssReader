import UIKit
import RealmSwift

class FeedTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let reuseID = "FeedTableViewCell"
    
    private var feedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "test")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        self.feedDate.text = nil
        self.feedTitle.text = nil
        self.feedAuthor.text = nil
        self.feedImageView.image = nil
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(feedImageView)
        contentView.addSubview(feedTitle)
        contentView.addSubview(feedDate)
        contentView.addSubview(feedAuthor)
    }
    
    //MARK: - Configure method
    func configure(model: FeedModel) {
        guard let url = URL(string: model.feedImage), let data = NSData(contentsOf: url) else { return }
        self.feedImageView.image = UIImage(data: data as Data)
        self.feedTitle.text = model.feedTitle
        self.feedDate.text = model.feedDate
        self.feedAuthor.text = model.feedAuthor
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
