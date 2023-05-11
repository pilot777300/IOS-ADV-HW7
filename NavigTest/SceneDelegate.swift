

import UIKit

import Firebase
import UserNotifications


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
  let notification = LocalNotificationsService()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        FirebaseApp.configure()
        self.notification.registerForLatestUpdatesIfPossible()
        
        let factory = MyLoginFactory()
              let loginInspector = factory.makeLoginInspector()
               let loginVC = LogInViewController()
               loginVC.loginDelegate = loginInspector
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController =  createTabBarController()
        self.window?.makeKeyAndVisible()
        Firebase.Auth.auth().addStateDidChangeListener { auth, user in
            
            if user == nil {
             //  print("USER NOT FOUND")
              //  self.showAuthController()
            }
        }
    }
    
    func showAuthController(){
        print("NO USER")
        let alert = UIAlertController(title: "Пользователь не найден!", message: "Зарегистрируйтесь", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
        self.window?.rootViewController?.present(alert, animated: true)
        let lvc =  LogInViewController()
//       lvc.signUp = false
 
        
       // let newVC = LogInViewController()
        //self.window?.rootViewController?.navigationController?.pushViewController(newVC, animated: false)
    }
    
    func createFeedViewController() -> UINavigationController {
        let feedViewController = ProfileViewController() //LogInViewController()
        
        feedViewController.title = NSLocalizedString("Feed", comment: "")
        feedViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Feed", comment: ""), image: UIImage(systemName: "doc.richtext"), tag: 0)
        return UINavigationController(rootViewController: feedViewController)
    }
    
    func createProfileViewController() -> UINavigationController {
        let profileViewController = LogInViewController()//MapViewController() //FeedViewController()
 
   profileViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Login", comment: ""), image: UIImage(systemName: "person"), tag: 1)
        profileViewController.title = NSLocalizedString("Login", comment: "")
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26)]
        UINavigationBar.appearance().titleTextAttributes = attributes
   return UINavigationController(rootViewController: profileViewController)
   }
    
    func createFafouriteController() -> UINavigationController {
        let favController = FavouritePostsViewController()
        favController.tabBarItem = UITabBarItem(title: NSLocalizedString("Favourites", comment: ""), image: UIImage(systemName: "heart"), tag: 2)
        favController.title = NSLocalizedString("Favourites", comment: "")
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26)]
        UINavigationBar.appearance().titleTextAttributes = attributes
        return UINavigationController(rootViewController: favController)
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        UITabBar.appearance().backgroundColor = .systemGray4
        tabBarController.viewControllers = [createFeedViewController(), createProfileViewController(), createFafouriteController()]
        return tabBarController
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        do {
            try  Auth.auth().signOut()
        }catch {
            print(error.localizedDescription)
        }
        
        notification.registerForLatestUpdatesIfPossible()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
        notification.registerForLatestUpdatesIfPossible()
    }


}

