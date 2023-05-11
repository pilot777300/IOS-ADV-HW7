
import UIKit
import StorageService
import iOSIntPackage
import CoreData
import SwiftUI


class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let notification = LocalNotificationsService()
   
    private lazy var themeSwitcher: UILabel = {
        let swt = UILabel()
        swt.translatesAutoresizingMaskIntoConstraints = false
        swt.clipsToBounds = true
        swt.backgroundColor = .systemGray2
        swt.layer.cornerRadius = 10
        return swt
    }()
    
     lazy var greenThemeCircle: UILabel = {
       let ra = UILabel()
         let editButton = UITapGestureRecognizer(
                 target: self, action: #selector(tapGreenThemeLabel))
         editButton.delegate = self
         ra.addGestureRecognizer(editButton)
        ra.translatesAutoresizingMaskIntoConstraints = false
         ra.clipsToBounds = true
        ra.backgroundColor = .systemGreen
         ra.layer.borderWidth = 2.0
         ra.layer.borderColor = UIColor.white.cgColor
         ra.isUserInteractionEnabled = true
         view.addSubview(ra)
        ra.layer.cornerRadius = 15
        return ra
    }()
    
    private lazy var blackThemeCircle: UILabel = {
       let ra = UILabel()
        let editButton = UITapGestureRecognizer(target: self, action: #selector(tapBlackThemeLabel))
        editButton.delegate = self
        ra.addGestureRecognizer(editButton)
        ra.translatesAutoresizingMaskIntoConstraints = false
        ra.clipsToBounds = true
       ra.backgroundColor = .systemGreen
        ra.layer.borderWidth = 2.0
        ra.layer.borderColor = UIColor.white.cgColor
        ra.backgroundColor = .black
        ra.isUserInteractionEnabled = true
        view.addSubview(ra)
        ra.layer.cornerRadius = 15
        return ra
    }()
    
    private lazy var lightThemeCircle: UILabel = {
       let ra = UILabel()
        let editButton = UITapGestureRecognizer(target: self, action: #selector(tapLightThemeLabel))
        editButton.delegate = self
        ra.addGestureRecognizer(editButton)
        ra.translatesAutoresizingMaskIntoConstraints = false
        ra.clipsToBounds = true
       ra.backgroundColor = .systemGreen
        ra.layer.borderWidth = 1.0
        ra.layer.borderColor = UIColor.black.cgColor
        ra.backgroundColor = .white
        ra.isUserInteractionEnabled = true
        view.addSubview(ra)
        ra.layer.cornerRadius = 15
        return ra
    }()
    
    var navbar = UINavigationBar(frame: .zero)
   
     var tableView = UITableView()
   // public var postData = [Post]()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.applicationIconBadgeNumber = 0
        view.backgroundColor = .white
    
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction), name: NSNotification.Name(rawValue: "GreenButtonTapped"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificBlackBtn), name: NSNotification.Name(rawValue: "BlackButtonTapped"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificWhiteBtn), name: NSNotification.Name(rawValue: "WhiteButtonTapped"),object: nil)
        
        
        #if DEBUG
        user.fullName = "Fake account"
        user.status = "Fake status"
        user.avatar = UIImage(named: "arrow.png") ?? UIImage(systemName: "person")!
        
        #else
        user.fullName = "Герой неба"
        user.status = "Отдыхаю"
        user.avatar = UIImage(named: "A330-300.jpg") ?? UIImage(systemName: "person")!
        #endif
        
        
        
        postData.append(Post(author: "Elon Musk", description: "Ты посмотри, мой друг, какая красота, какая мощь и грация", image: UIImage(named: "A330-300.jpg"), lokes: 12, views: 33))
        postData.append(Post(author: "Юрий Шевчук", description: "Всюду черти! надави брат, на педаль.", image: UIImage(named: "Brothers.tiff")!, lokes: 50, views: 55))
        postData.append(Post(author: "Cергей Крокодилов", description: "Как тебе такое, Илон Маск?", image: UIImage(named: "Boston.jpg")!, lokes: 132, views: 4567))
        postData.append(Post(author: "Donald Trump", description: "Wow!!! Wonderfull Kukuruznik", image: UIImage(named: "Aeroplan.jpeg")!, lokes: 243, views: 427))
        postData.append(Post(author: "Игорь Крутой перец", description: "Как тебе такое, Илон Маск?", image: UIImage(named: "Boston.jpg")!, lokes: 132, views: 4567))
        postData.append(Post(author: "Шуфутинский миша", description: "Wow!!! Wonderfull Kukuruznik", image: UIImage(named: "Aeroplan.jpeg")!, lokes: 243, views: 427))
        
        view.addSubview(tableView)
        setTableView()
        tableView.addSubview(themeSwitcher)
        
        //addNavBar()
        setConstraints()
    
    }
    
   @objc func notificationAction() {
      tableView.reloadData()
    }
    
    @objc func notificBlackBtn() {
        view.backgroundColor = DarkTheme().backgroundColor
        tableView.reloadData()
    }
    
    @objc func notificWhiteBtn() {
        view.backgroundColor = LightTheme().backgroundColor
        tableView.reloadData()
    }
    
    
    @objc func tapGreenThemeLabel() {
        isGreenThemeActivated = true
        isDarkThemeActivated = false
        isLightThemeActivatd = false
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GreenButtonTapped"), object: nil)
       // tableView.reloadData()
    
    }
    
    @objc func tapBlackThemeLabel() {
        isDarkThemeActivated = true
        isGreenThemeActivated = false
        isLightThemeActivatd = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "BlackButtonTapped"), object: nil)
    
    
    }
    
    @objc func tapLightThemeLabel() {
        isLightThemeActivatd = true
        isDarkThemeActivated = false
        isGreenThemeActivated = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "WhiteButtonTapped"), object: nil)
    }
    
   
    
    

        func setTableView() {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorColor = UIColor.black
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Cell")
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.allowsSelection = true
            tableView.dragInteractionEnabled = true
            tableView.dragDelegate = self
            tableView.dropDelegate = self
            if isGreenThemeActivated {
                tableView.backgroundColor = GreenTheme().backgroundColor
            } else if isDarkThemeActivated {
                tableView.backgroundColor = DarkTheme().backgroundColor
            } else if isLightThemeActivatd {
                tableView.backgroundColor = LightTheme().backGroundForPost
            } else  {
                tableView.backgroundColor = .white
            }
        }
    
        func setConstraints() {
            let safeArea = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                
//                navbar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
//                navbar.topAnchor.constraint(equalTo: safeArea.topAnchor),
//                navbar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
//                navbar.heightAnchor.constraint(equalToConstant: 44),

               tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
               tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
               tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
               
               themeSwitcher.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
               themeSwitcher.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
               themeSwitcher.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50),
               themeSwitcher.heightAnchor.constraint(equalToConstant: 50),
               
               greenThemeCircle.topAnchor.constraint(equalTo: themeSwitcher.topAnchor, constant: 10),
               greenThemeCircle.leadingAnchor.constraint(equalTo: themeSwitcher.leadingAnchor, constant: 10),
               greenThemeCircle.bottomAnchor.constraint(equalTo: themeSwitcher.bottomAnchor, constant: -10),
               greenThemeCircle.widthAnchor.constraint(equalToConstant: 30),
               
               blackThemeCircle.topAnchor.constraint(equalTo: themeSwitcher.topAnchor, constant: 10),
               blackThemeCircle.leadingAnchor.constraint(equalTo: greenThemeCircle.trailingAnchor, constant: 10),
               blackThemeCircle.bottomAnchor.constraint(equalTo: themeSwitcher.bottomAnchor, constant: -10),
               blackThemeCircle.widthAnchor.constraint(equalToConstant: 30),
               
               lightThemeCircle.topAnchor.constraint(equalTo: themeSwitcher.topAnchor, constant: 10),
               lightThemeCircle.leadingAnchor.constraint(equalTo: blackThemeCircle.trailingAnchor, constant: 10),
               lightThemeCircle.bottomAnchor.constraint(equalTo: themeSwitcher.bottomAnchor, constant: -10),
               lightThemeCircle.widthAnchor.constraint(equalToConstant: 30),
            
            ])
        }
    func addNavBar () {

        navbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navbar)
        let navItem = UINavigationItem(title: "Профиль")
        let addPictireButton = UIBarButtonItem(title: "Добавить фото", style: .done, target: nil, action: #selector(addPictireButtonPressed))
        navItem.rightBarButtonItem = addPictireButton
        navbar.setItems([navItem], animated: false)
    }
    
    @objc func addPictireButtonPressed() {
        
        }
    
    }
    
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PostTableViewCell
        else {fatalError()}
       
        let thePost = postData[indexPath.row]
        cell.views.text = NSLocalizedString("Views", comment: "") + ":" + "\(thePost.views ?? 0)"
        cell.likes.text =  NSLocalizedString("Likes", comment: "") + ":" + "\(thePost.lokes ?? 0)"
        cell.postAuthor.text = thePost.author
        cell.postTxt.text = thePost.description
        cell.postImage.image = thePost.image
        if isGreenThemeActivated {
            tableView.backgroundColor = GreenTheme().backgroundColor
            cell.backView.backgroundColor = GreenTheme().backgroundColor
            cell.contentView.backgroundColor = GreenTheme().backgroundColor
            cell.postAuthor.backgroundColor = GreenTheme().backgroundColor
            cell.postTxt.backgroundColor = GreenTheme().backgroundColor
            cell.postTxt.textColor = GreenTheme().textColor
            cell.likes.backgroundColor = GreenTheme().backgroundColor
            cell.views.backgroundColor = GreenTheme().backgroundColor
        } else if isDarkThemeActivated {
            tableView.backgroundColor = DarkTheme().backgroundColor
            cell.backView.backgroundColor = DarkTheme().backgroundColor
            cell.contentView.backgroundColor = DarkTheme().backgroundColor
            cell.postAuthor.backgroundColor = DarkTheme().backgroundColor
            cell.postAuthor.textColor = DarkTheme().textColor
            cell.postTxt.backgroundColor = DarkTheme().backgroundColor
            cell.postTxt.textColor = DarkTheme().textColor
            cell.likes.backgroundColor = DarkTheme().backgroundColor
            cell.likes.textColor = DarkTheme().textColor
            cell.views.backgroundColor = DarkTheme().backgroundColor
            cell.views.textColor = DarkTheme().textColor
        } else if isLightThemeActivatd {
            tableView.backgroundColor = LightTheme().backgroundColor
            cell.backView.backgroundColor = LightTheme().backgroundColor
            cell.contentView.backgroundColor = LightTheme().backgroundColor
            cell.postAuthor.backgroundColor = LightTheme().backgroundColor
            cell.postAuthor.textColor = LightTheme().textColor
            cell.postTxt.backgroundColor = LightTheme().backgroundColor
            cell.postTxt.textColor = LightTheme().textColor
            cell.likes.backgroundColor = LightTheme().backgroundColor
            cell.likes.textColor = LightTheme().textColor
            cell.views.backgroundColor = LightTheme().backgroundColor
            cell.views.textColor = LightTheme().textColor
        } else {
            cell.backView.backgroundColor = .white
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = ProfileHeaderView()
        if isGreenThemeActivated == true {
             view.backgroundColor = GreenTheme().backgroundColor
        } else if isDarkThemeActivated == true {
            view.backgroundColor = DarkTheme().backgroundColor
        } else if isLightThemeActivatd == true
        {
            view.backgroundColor = LightTheme().backgroundColor
        } else {
            view.backgroundColor = .systemGray5
        }
        
        view.status.text = user.fullName
        view.profileView.image = user.avatar
        view.newStatus.text = user.status
        let q = PhotosTableViewCell()
        let editButton = UIButton(frame: CGRect(x:0, y:190, width:400, height:150))
        editButton.addTarget(self, action: #selector(showGallery), for: UIControl.Event.touchUpInside)
        view.addSubview(q)
        view.addSubview(editButton)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 320
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thePost = postData[indexPath.row]
        let vc = FavouritePostsViewController()
        let cdm = CoreDataManager()
        let img = UIImage(named: "\(thePost.image!)")
        let compressedImg = img!.jpegData(compressionQuality: 1.0)
        let dataFromCoreManager = vc.coreManager.post1Data
        var stringForCompare = ""
        dataFromCoreManager.forEach{ data  in
             if (thePost.description! ==  data.descript!) {
                 stringForCompare = data.descript!
                 addAlertVcContainsPost()
             }
         }
        if !(thePost.description == stringForCompare) {
            cdm.addNewPost(author: "\(thePost.author!)", text: "\(thePost.description!)", image: compressedImg!)
            self.navigationController?.pushViewController(vc, animated: true)
           // self.tabBarController?.tabBar.items?[0].isEnabled = false
        }
        
      
       
    }
    
    
    @objc func showGallery(sender: UIButton) {
       let vc = PhotosViewController()
          navigationController?.pushViewController(vc, animated: true)
    }
    
    func addAlertVcContainsPost() {
        let alert = UIAlertController(title: "Пост уже в избранном", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
      //  let dateItem = postData[indexPath.row]
        var itemProvider: NSItemProvider!
        if let cell = self.tableView.cellForRow(at: indexPath) as? PostTableViewCell {
            itemProvider = NSItemProvider(object: cell.postTxt.text! as NSString)
        } else if let cell = self.tableView.cellForRow(at: indexPath) as? PostTableViewCell{
            itemProvider = NSItemProvider(object: cell.postImage.image! as UIImage)
                }

        let dragItem = UIDragItem(itemProvider: itemProvider)

              return [
                  dragItem
              ]
    }
    

    
  
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        print("jjjj")
      
    
        let destinationIndexPath: IndexPath

        let section = self.tableView.numberOfSections - 1
        let row = self.tableView.numberOfRows(inSection: section)
        destinationIndexPath = IndexPath(row: row, section: section)
        
      
          coordinator.session.loadObjects(ofClass: NSString.self)  {  stringItems in

            let txt = stringItems as! [String]
            var post = Post()
            post.description = txt.first
            postData.insert(post, at: destinationIndexPath.row)
            self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
           // self?.tableView.reloadData()
    }
        
        coordinator.session.loadObjects(ofClass: UIImage.self) {  pictureItems  in
            
            let image = pictureItems as! [UIImage]
            var post = Post()
            post.image = image.first
            postData.insert(post, at: destinationIndexPath.row)
           // postData.append(post)
            self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
          //  self.tableView.reloadData()
        }
       // self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
        self.tableView.reloadData()
 
        
     
         }
    

    }

    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
     
        return session.canLoadObjects(ofClass: UIImage.self) || session.canLoadObjects(ofClass: NSString.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
       
        if session.localDragSession != nil {
           return UITableViewDropProposal(operation: .forbidden)
         } else {
           return UITableViewDropProposal(
             operation: .copy,
             intent: .insertAtDestinationIndexPath)
         }

    }
    


  
