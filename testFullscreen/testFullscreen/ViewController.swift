//
//  ViewController.swift
//  testFullscreen
//
//  Created by Alex Hernandez on 11/13/24.
//
import Cocoa
import WebKit

class ViewController: NSViewController, WKNavigationDelegate {

    var MainWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
       
    }
    
    // Method to handle layout updates when the web view needs it
    override func viewDidLayout() {
        super.viewDidLayout()
        
        // Trigger layout update on webView to avoid invalid bounds
        MainWebView.setNeedsDisplay(MainWebView.bounds)
        MainWebView.layoutSubtreeIfNeeded()
    }
    
    func configureWebView(){
        // Create a WKWebView instance programmatically
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsAirPlayForMediaPlayback = true
        webConfiguration.preferences.isElementFullscreenEnabled = true
        
        MainWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        MainWebView.navigationDelegate = self
        
        // Add the WKWebView as a subview of the main view
        view.addSubview(MainWebView)
        
        // Set up Auto Layout constraints for the web view to fill the parent view
        MainWebView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            MainWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            MainWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            MainWebView.topAnchor.constraint(equalTo: view.topAnchor),
            MainWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Load the YouTube page
        if let url = URL(string: "https://www.youtube.com") {
            let request = URLRequest(url: url)
            MainWebView.load(request)
        }
    }

    // Handle navigation response (you can expand this if needed)
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping @MainActor (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}
