import AppKit
import AuthenticationServices

/// One browser sign-in. It catches its own redirect, so an installed Raycast cannot take it.
@MainActor
final class ExtensionSignInSession: NSObject, ASWebAuthenticationPresentationContextProviding {
    enum Failure: LocalizedError {
        case cancelled
        case backgroundRefresh
        case alreadyOpen

        var errorDescription: String? {
            switch self {
            case .cancelled:
                String(localized: "Sign-in was cancelled.", table: "Extensions")
            case .backgroundRefresh:
                String(
                    localized: "Signing in during a background refresh is not supported.", table: "Extensions"
                )
            case .alreadyOpen:
                String(
                    localized: "A sign-in window is already open. Finish it before starting another.",
                    table: "Extensions")
            }
        }
    }

    private nonisolated let anchor: ASPresentationAnchor
    private var session: ASWebAuthenticationSession?

    override init() {
        anchor = NSApp.keyWindow ?? ASPresentationAnchor()
    }

    /// Resolves with the redirect URL; cancelling the task closes the browser window.
    func run(url: URL, callbackScheme: String) async throws -> URL {
        try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                let session = ASWebAuthenticationSession(
                    url: url, callback: .customScheme(callbackScheme)
                ) { @Sendable redirect, error in
                    if let redirect {
                        continuation.resume(returning: redirect)
                    } else if let error, (error as? ASWebAuthenticationSessionError)?.code != .canceledLogin {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: Failure.cancelled)
                    }
                }
                session.presentationContextProvider = self
                self.session = session
                session.start()
            }
        } onCancel: {
            Task { @MainActor in self.session?.cancel() }
        }
    }

    nonisolated func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        anchor
    }
}
