import Foundation

// [Bugsnag iOS Integration guide](https://docs.bugsnag.com/platforms/ios/)
// [Create an account](https://app.bugsnag.com/user/new)
// [Performance guide](https://docs.bugsnag.com/performance/integration-guides/ios/)


// Bugsnag:
// Available integrations:
// -- cocoapod, SPM, carthage, Manual Framework download and embed

// Changes required in App's Info.plist
// -- Add bugsnag API key
// bugsnag (dictionary) > apiKey (string)
//
// API key present in Bugsnag dashboard
// -- API key management for different Enterprise apps?


import RumWrapper
import Bugsnag
// for capturing network request
import BugsnagNetworkRequestPlugin

public class BugsnagWrapper: RUMWrapper {
    
    /// Bugsnag initialization needs to take place ass soon as the app is launched
    ///
    /// As per document
    /// When Using AppDelegate: in `application:didFinishLaunchingWithOptions:`
    /// https://docs.bugsnag.com/platforms/ios/#app-delegate
    ///
    /// when using SwiftUI App, in init()
    /// https://docs.bugsnag.com/platforms/ios/#swiftui-app-life-cycle
    ///
    /// when using App Extensions: in extension ViewController initializer
    /// https://docs.bugsnag.com/platforms/ios/#app-extensions
    
    public override class func activateSDK(
        apiKey: String,
        captureNetworkRequest: Bool = false,
        captureSession: Bool = false
    ) {
        let config = BugsnagConfiguration.loadConfig()
        config.apiKey = apiKey
        
        /// [Auto instrument View Controller](https://docs.bugsnag.com/performance/integration-guides/ios/#instrumenting-view-loads)
//        config.autoInstrumentViewControllers = false
//        config.viewControllerInstrumentationCallback = { viewController in
//            // filter out view controller that does not need tracking
//        }
        
        /**
        [Automatic Breadcrumbs](https://docs.bugsnag.com/platforms/ios/customizing-breadcrumbs/#automatic-breadcrumbs)
        By default, BugSnag captures breadcrumbs for common actions and device changes, including:
        - Low memory warnings
        - Device rotation
        - Screenshot capture
        - Menu presentation
        - Table view selection
        - Window visibility changes
        - Thermal state changes
        - Non-fatal errors
        This can be controlled using the `enabledBreadcrumbTypes` configuration option.
         */
//        config.enabledBreadcrumbTypes = [.navigation]
        
        /// [Capturing network request](https://docs.bugsnag.com/platforms/ios/customizing-breadcrumbs/#capturing-network-requests)
        if captureNetworkRequest {
            config.add(BugsnagNetworkRequestPlugin())
        }
        
        /// Bugsnag automatically tracks session.
        /// [Capturing Session](https://docs.bugsnag.com/platforms/ios/capturing-sessions/#manual-session-handling)
        ///
        /// manually control  session capture using `Bugsnag.startSession()`, `Bugsnag.pauseSession()`, `Bugsnag.resumeSession()`
        /// [Manual Session Handling](https://docs.bugsnag.com/platforms/ios/capturing-sessions/#manual-session-handling)
        config.autoTrackSessions = captureSession
        
        /// [Discarding or amending session](https://docs.bugsnag.com/platforms/ios/capturing-sessions/#discarding-and-amending-sessions)
        config.addOnSession { session in
            /// - `false` to discard session
            /// - `true` to deliver session to Bugsnag
            return false
        }
        
        /// [Attaching custom diagnostics](https://docs.bugsnag.com/platforms/ios/#attaching-custom-diagnostics)
        config.addOnSendError { event in
//            event.addMetadata(false, key: "preAuth", section: "login")
            return true
        }
        
        Bugsnag.start(with: config)
    }
    
    public override class func emitEvent(
        message: String,
        metadata: [String: Any]?
    ) {
        /// [Adding Manual Breadcrumb](https://docs.bugsnag.com/platforms/ios/customizing-breadcrumbs/#adding-manual-breadcrumbs)
        Bugsnag.leaveBreadcrumb(message, metadata: metadata, type: .manual)
    }
    
    
}
