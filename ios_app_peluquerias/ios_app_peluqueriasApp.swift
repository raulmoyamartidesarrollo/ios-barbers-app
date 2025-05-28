import SwiftUI
import FirebaseCore

// Paso 1: Delegado de aplicación para Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

// Paso 2: Tu app principal
@main
struct ios_app_peluqueriasApp: App {
    // Vinculamos el delegado para Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            StartScreen() // o tu pantalla inicial
        }
    }
}
