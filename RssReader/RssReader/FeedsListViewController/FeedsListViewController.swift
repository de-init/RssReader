import UIKit

class FeedsListViewController: UIViewController {
    
    //MARK: - Properties
    private let navTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textColor = .white
        label.text = "Моя лента"
        return label
    }()
    
    private lazy var navBar: CustomNavigationBar = {
        return CustomNavigationBar(animatingView: self.navTitle, animationStyle: .leftToCenter)
    }()
    
    private var tableView = UITableView()
    private let parser = LentaParser()
    private var feedsList: [Feed] = []
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        updateData()
    }
    
    private func updateData() {
        guard let link = URL(string: rssLink) else { return }
        feedsList = parser.parse(url: link)
    }
    
    //MARK: - viewWillLayoutSubviews
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            navBar.heightAnchor.constraint(equalToConstant: 60),
            navBar.bottomAnchor.constraint(equalTo: self.tableView.topAnchor),
        ])
    }
    
    //MARK: - setupUI
    private func setupUI() {
        view.backgroundColor = UIColor(hex: 0x344E41)
        self.navigationController?.navigationBar.isHidden = true
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navTitle)
        view.addSubview(navBar)
    }
    
    //MARK: - Setup Collection View
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
    }
}

//MARK: - UITableViewDelegate
extension FeedsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: - UITableViewDataSource
extension FeedsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseID, for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        let feedItem = feedsList[indexPath.row]
        cell.configure(imageData: feedItem.image, titleText: feedItem.title, dateText: feedItem.date, authorText: feedItem.author)
        return cell
    }
}

//MARK: - scrollViewDidScroll
extension FeedsListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navBar.animateInRelationTo(self.tableView.contentOffset.y / 2)
    }
}
