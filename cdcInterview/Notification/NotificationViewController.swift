import UIKit

class NotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableView = UITableView()
    var viewModel: NotificationViewModel?
    private var messages: [NotificationModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Notification"
        setupTableView()
        fetchMessages(viewModel: self.viewModel)
//        navigationController?.navigationBar.backItem?.title = ""

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.backItem?.title = ""
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NotificationViewCell.self, forCellReuseIdentifier: "NotificationCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EmptyCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }

    private func fetchMessages(viewModel: NotificationViewModel?) {
        viewModel?.fetchNotifications { [weak self] messages in
            guard let self, let messages else { return }
            self.messages = messages
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table View Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= messages.count {
            print("超出資料範圍！")
            return tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath)
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath)
        }
        cell.configure(with: messages[indexPath.row])
        return cell
    }

    // MARK: - Table View Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
