import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  private lazy var controller: UIViewController = ViewController()
  private lazy var navigationController: UINavigationController = self.makeNavigationController()

  // MARK: - Application lifecycle

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()

    return true
  }
}

// MARK: - Factory

private extension AppDelegate {
  func makeNavigationController() -> UINavigationController {
    let navigationController = UINavigationController(rootViewController: self.controller)
    navigationController.navigationBar.prefersLargeTitles = true
    return navigationController
  }
}
