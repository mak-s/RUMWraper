import Foundation
import RumWrapper
import DatadogCore
import DatadogRUM

// webview tracking
import WebKit
import DatadogWebViewTracking

/// Document suggests using Datadog package v `2.0.0`
/// Current latest is `2.20.0`

public class DatadogWrapper: RUMWrapper {
    
    public override class func activateSDK(
        apiKey: String,
        appId: String,
        captureNetworkRequest: Bool = false,
        captureSession: Bool = false,
        environment: String
    ) {
        // instrument your application
        Datadog.initialize(
            with: Datadog.Configuration(
                clientToken: apiKey,
                env: environment
            ),
            trackingConsent: .granted
        )
        
        RUM.enable(
            with: RUM.Configuration(
                applicationID: appId,
                sessionSampleRate: 50,
                uiKitViewsPredicate: DefaultUIKitRUMViewsPredicate(),
                uiKitActionsPredicate: DefaultUIKitRUMActionsPredicate(),
                urlSessionTracking: RUM.Configuration.URLSessionTracking(),
                trackBackgroundEvents: true
            )
        )
    }
    
    // MARK: - Tracking webView
    
    // returns a tracker
    // caller should manage the returned tracker for the lifetime of webView
    // if tracker is discarded, webView tracking will stop.
    public func track(webView: WKWebView, hosts: Set<String> = []) -> WebViewTracker {
        return WebViewTracker(webView: webView, hosts: hosts)
    }
    
    // MARK: - Tracking Network Reqeust
    
    /// track network request metrics via a given session Delegate
    /// - a session used for network request must use the given session delegate
    /// - Parameter sessionDelegate: a `ULRSessionDelegate` instance used to initialize a`URLSession` instance, that is used for network requests
    public func track(sessionDelegate: URLSessionDelegate) {
        //TODO: ??
        // Documentation API not available
        // URLSessionInstrumentation.enable(with: sessionDelegate)
    }
    
    // MARK: - Tracking SwiftUI views
    /*
     This needs to be done by the client
     or need to expose a modifier that wraps the call
     
     e.g.
      SomeView {
     
      }.trackRUMView(name: "Foo")
     
     */
    
}

/// Starts tracking a webView when initialized
/// Stops tracking the given webView when deinitialized
public class WebViewTracker {
    let webView: WKWebView
    init(webView: WKWebView, hosts: Set<String> = []) {
        self.webView = webView
        WebViewTracking.enable(webView: webView, hosts: hosts)
    }
    
    deinit {
        WebViewTracking.disable(webView: webView)
    }
}
