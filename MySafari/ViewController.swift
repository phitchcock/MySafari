//
//  ViewController.swift
//  MySafari
//
//  Created by Peter Hitchcock on 10/1/14.
//  Copyright (c) 2014 Peter Hitchcock. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate {

    //IBOutlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var navigationLabel: UILabel!

    //Apple Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreen()
        self.buttonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //IBActions
    @IBAction func onBackButtonPressed(sender: AnyObject) {
        self.webView.goBack()
    }

    @IBAction func onForwardButtonPressed(sender: AnyObject) {
        self.webView.goForward()
    }

    @IBAction func onStopLoadingButtonPressed(sender: AnyObject) {
        self.webView.stopLoading()
    }

    @IBAction func onReloadButtonPressed(sender: AnyObject) {
        self.webView.reload()
    }

    @IBAction func comingSoonButtonPressed(sender: AnyObject) {
        var alert = UIAlertView(title: "Comming Soon", message: "Take over the world", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let urlString = urlTextField.text
        urlHelper(urlString)
        self.urlTextField.endEditing(true)
        return true
    }

    //Functions
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.buttonState()

    }

    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        let thisURL = webView.request?.URL.absoluteString
        self.urlTextField.text = thisURL
        self.buttonState()

        let returnedString = webView.stringByEvaluatingJavaScriptFromString("document.title")
        self.navigationLabel.text = returnedString
        println("\(returnedString)")

    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {

        var scroll:CGPoint = scrollView.panGestureRecognizer.translationInView(scrollView.superview!)

        if(scroll.y > 0) {

            self.urlTextField.alpha += 0.5
        
        } else {

            self.urlTextField.alpha -= 0.5

        }

    }

    //Helpers
    func loadUrl(urlString: NSString) {
        let url = NSURL(string: urlString)
        let urlRequest = NSURLRequest(URL: url)
        self.webView.loadRequest(urlRequest)
    }

    func urlHelper(urlString: NSString) {
        
        if urlString.hasPrefix("http://") {
            loadUrl(urlString)
            self.urlTextField.text = urlString

        } else {
            loadUrl("http://\(urlString)")
            self.urlTextField.text = "http://\(urlString)"
        }
    }

    func homeScreen() {
        self.loadUrl("http://www.mobile-patterns.com/")
    }

    func buttonState() {
        self.backButton.enabled = self.webView.canGoBack
        self.forwardButton.enabled = self.webView.canGoForward
    }

}

