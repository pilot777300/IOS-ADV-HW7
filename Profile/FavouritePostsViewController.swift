
import UIKit
import CoreData

class FavouritePostsViewController: UIViewController {

    var tableView =  UITableView()
    let coreManager = CoreDataManager.shared
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setupConstraints()
        view.backgroundColor = .white
        //self.title = "Избранные"
    }
   
    fileprivate func setUpTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemGray4
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavPostTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
    }
    
    fileprivate func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
         
        
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
extension FavouritePostsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreManager.post1Data.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        coreManager.reloadPosts()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavPostTableViewCell
        else {
            fatalError()
        }
        
       let post = coreManager.post1Data[indexPath.row]

        if let data = post.image {
        let image = UIImage(data: data)
            if isGreenThemeActivated {
                cell.backView.backgroundColor = GreenTheme().backgroundColor
                cell.postAuthor.backgroundColor = GreenTheme().backgroundColor
                cell.postText.backgroundColor = GreenTheme().backgroundColor
                view.backgroundColor = GreenTheme().backgroundColor
                tableView.backgroundColor = GreenTheme().backgroundColor
            } else if isDarkThemeActivated {
                cell.backView.backgroundColor = DarkTheme().backgroundColor
                cell.postAuthor.backgroundColor = DarkTheme().backgroundColor
                cell.postAuthor.textColor = DarkTheme().textColor
                cell.postText.backgroundColor = DarkTheme().backgroundColor
                cell.postText.textColor = DarkTheme().textColor
                view.backgroundColor = DarkTheme().backgroundColor
                tableView.backgroundColor = DarkTheme().backgroundColor
            } else if isLightThemeActivatd {
                cell.backView.backgroundColor = .systemGray5
                cell.postAuthor.backgroundColor = .systemGray5
                cell.postAuthor.textColor = LightTheme().textColor
                cell.postText.backgroundColor = .systemGray5
                cell.postText.textColor = LightTheme().textColor
                view.backgroundColor = .systemGray4
                tableView.backgroundColor = .systemGray4
            }
            cell.postAuthor.text = post.author
            cell.postText.text = post.descript
            cell.postImage.image = image
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let post = coreManager.post1Data[indexPath.row]
            coreManager.deletePost(post: post)
            tableView.reloadData()
        }
    }
}
