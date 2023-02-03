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
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refresh
    }()
    
    private lazy var navBar: CustomNavigationBar = {
        return CustomNavigationBar(animatingView: self.navTitle, animationStyle: .leftToCenter)
    }()
    
    private var tableView = UITableView()
    private var feedsList: [Feed] = []
    private var viewModel = FeedsViewModel()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        loadingFeeds()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func loadingFeeds() {
        guard let link = URL(string: rssLink) else { return }
        let data = viewModel.fetchData(with: link)
        feedsList = data
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
        tableView.addSubview(refreshControl)
    }
    
    @objc func pullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, qos: .background, execute: {
            self.loadingFeeds()
            self.refreshControl.endRefreshing()
        })
    }
}

//MARK: - UITableViewDelegate
extension FeedsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedsList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemData = feedsList[indexPath.row]
        let vc = ReaderViewController(getImage: itemData.image, getTitle: itemData.title, getDescription: itemData.description, getDate: itemData.date, getAuthor: itemData.author)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension FeedsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseID, for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        let item = feedsList[indexPath.row]
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, qos: .default) {
            cell.configure(model: item)
        }
        return cell
    }
}

//MARK: - scrollViewDidScroll
extension FeedsListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navBar.animateInRelationTo(self.tableView.contentOffset.y / 2)
    }
}
