//
//  HLSDownload.swift
//  ExpoBlueskySwissArmy
//
//  Created by Hailey on 7/29/24.
//

import ExpoModulesCore
import WebKit

class HLSDownloadView: ExpoView, WKScriptMessageHandler, WKNavigationDelegate, WKDownloadDelegate {
  var webView: WKWebView!
  var downloaderUrl: URL?
  
  private var outputUrl: URL?
  
  public required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext)
    
    // controller for post message api
    let contentController = WKUserContentController()
    contentController.add(self, name: "onMessage")
    let configuration = WKWebViewConfiguration()
    configuration.userContentController = contentController
    
    // create webview
    let webView = WKWebView(frame: .zero, configuration: configuration)
    
    // Use these for debugging, to see the webview itself
    webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    webView.layer.masksToBounds = false
    webView.backgroundColor = .clear
    webView.contentMode = .scaleToFill
    
    webView.navigationDelegate = self
    
    self.addSubview(webView)
    self.webView = webView
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK - view functions
  
  func download(sourceUrl: URL, progress: @escaping(Float) -> Void) {
    guard let url = self.createUrl(videoUrl: sourceUrl) else {
      return
    }
    print(url)
    self.webView.load(URLRequest(url: url))
  }
  
  func cancel() {
    // Cancel the download
  }
  
  // webview message handling
  
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    guard let response = message.body as? String,
          let data = response.data(using: .utf8),
          let payload = try? JSONDecoder().decode(WebViewActionPayload.self, from: data) else {
      return
    }
    
    print(payload)
    
    switch payload.action {
    case .progress:
      guard let progress = payload.messageFloat else {
        return
      }
      break
    case .complete:
      break
    case .error:
      break
    }
  }
  
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
    guard #available(iOS 14.5, *) else {
      return .cancel
    }
    
    if navigationAction.shouldPerformDownload {
      return .download
    } else {
      return .allow
    }
  }
  
  // MARK - wkdownloaddelegate
  
  @available(iOS 14.5, *)
  func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
    download.delegate = self
  }
  
  @available(iOS 14.5, *)
  func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload) {
    print("here 2")
    download.delegate = self
  }
  
  @available(iOS 14.5, *)
  func download(_ download: WKDownload, decideDestinationUsing response: URLResponse, suggestedFilename: String, completionHandler: @escaping (URL?) -> Void) {
    let directory = NSTemporaryDirectory()
    let fileName = NSUUID().uuidString
    let url = NSURL.fileURL(withPathComponents: [directory, fileName])
    
    self.outputUrl = url
    completionHandler(url)
  }
  
  @available(iOS 14.5, *)
  func downloadDidFinish(_ download: WKDownload) {
    print(self.outputUrl?.absoluteString)
  }
  
  private func progress() {
    // Event handler here
  }
  
  private func createUrl(videoUrl: URL) -> URL? {
    guard let downloaderUrl = self.downloaderUrl else {
      // TODO
      fatalError()
    }
    
    return URL(string: "\(downloaderUrl.absoluteString)?videoUrl=\(videoUrl.absoluteString)")
  }
}

struct WebViewActionPayload: Decodable {
  enum Action: String, Decodable {
    case progress, complete, error
  }
  
  let action: Action
  let messageStr: String?
  let messageFloat: Float?
}
