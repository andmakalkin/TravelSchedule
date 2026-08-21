import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    let isDarkAppearance: Bool
    let onLoadFinished: () -> Void
    let onLoadFailed: (Error) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            onLoadFinished: onLoadFinished,
            onLoadFailed: onLoadFailed
        )
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        
        let initialScript = WKUserScript(
            source: """
            const style = document.createElement("style");
            
            style.textContent = `
                html,
                body,
                .pc-page-constructor,
                .dc-doc-layout.dc-doc-page {
                    background: transparent !important;
                    background-color: transparent !important;
                }
                
                .pc-navigation,
                .dc-subnavigation {
                    display: none !important;
                }
            `;
            
            document.documentElement.appendChild(style);
            """,
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )
        
        configuration.userContentController.addUserScript(
            initialScript
        )
        
        let webView = WKWebView(
            frame: .zero,
            configuration: configuration
        )
        
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        
#if DEBUG
        webView.isInspectable = true
#endif
        
        context.coordinator.pageScript = pageScript
        
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(
        _ webView: WKWebView,
        context: Context
    ) {
        context.coordinator.pageScript = pageScript
        
        guard webView.url != nil,
              !webView.isLoading else {
            return
        }
        
        webView.evaluateJavaScript(
            pageScript,
            completionHandler: nil
        )
    }
    
    private var pageScript: String {
        let themeClass = isDarkAppearance
            ? "g-root_theme_dark"
            : "g-root_theme_light"
        
        let oppositeThemeClass = isDarkAppearance
            ? "g-root_theme_light"
            : "g-root_theme_dark"
        
        return """
        const themeElements = [
            document.body,
            document.querySelector(".pc-page-constructor")
        ];
        
        themeElements.forEach(element => {
            if (element) {
                element.classList.remove("\(oppositeThemeClass)");
                element.classList.add("\(themeClass)");
            }
        });
        """
    }
    
    final class Coordinator: NSObject, WKNavigationDelegate {
        private let onLoadFinished: () -> Void
        private let onLoadFailed: (Error) -> Void
        
        var pageScript = ""
        
        init(
            onLoadFinished: @escaping () -> Void,
            onLoadFailed: @escaping (Error) -> Void
        ) {
            self.onLoadFinished = onLoadFinished
            self.onLoadFailed = onLoadFailed
        }
        
        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation!
        ) {
            webView.evaluateJavaScript(
                pageScript
            ) { [weak self] _, _ in
                self?.onLoadFinished()
            }
        }
        
        func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation!,
            withError error: Error
        ) {
            handle(error)
        }
        
        func webView(
            _ webView: WKWebView,
            didFail navigation: WKNavigation!,
            withError error: Error
        ) {
            handle(error)
        }
        
        private func handle(_ error: Error) {
            if let urlError = error as? URLError,
               urlError.code == .cancelled {
                return
            }
            
            onLoadFailed(error)
        }
    }
}
