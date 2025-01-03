import Foundation

open class RUMWrapper {
    
    /// Perform necessary steps required for initializing the SDK
    /// - Parameters:
    ///   - apiKey: an API key for SDK initialization
    ///   - captureNetworkRequest: `true` to enable network request capture, defaults to `false`
    ///   - captureSession: `true` to enable session capture, defaults to `false`
    ///   - environment: deployment environment
    open class func activateSDK(
        apiKey: String,
        appId: String,
        captureNetworkRequest: Bool = false,
        captureSession: Bool = false,
        environment: String
    ) {
        //
    }
    
    open class func emitEvent(message: String, metadata: [String: Any]?) {
        //
    }
    
}
