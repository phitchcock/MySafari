//
//  ViewController.swift
//  MySafari
//
//  Created by Peter Hitchcock on 10/1/14.
//  Copyright (c) 2014 Peter Hitchcock. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {

    //IBOutlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!

    //IBActions
    @IBAction func onBackButtonPressed(sender: AnyObject) {

        webView.goBack()

    }

    @IBAction func onForwardButtonPressed(sender: AnyObject) {

        webView.goForward()

    }

    @IBAction func onStopLoadingButtonPressed(sender: AnyObject) {

        webView.stopLoading()
    }

    @IBAction func onReloadButtonPressed(sender: AnyObject) {

        webView.reload()
    }

    @IBAction func comingSoonButtonPressed(sender: AnyObject) {

        var alert = UIAlertView(title: "Comming Soon", message: "Take over the world", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }

    @IBAction func clearURLButtonPressed(sender: AnyObject) {

        urlTextField.text = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUrl("http://www.google.com")

        self.buttonState()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {

        let urlString = urlTextField.text

        urlHelper(urlString)

        urlTextField.endEditing(true)

        return true
    }

    func webViewDidStartLoad(webView: UIWebView) {

        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        self.buttonState()

    }

    func webViewDidFinishLoad(webView: UIWebView) {

        UIApplication.sharedApplication().networkActivityIndicatorVisible = false

        self.buttonState()

    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {

        self.view.endEditing(true)
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
            //urlTextField.text = urlString
            //println("\(urlString)")

        } else {

            loadUrl("http://\(urlString)")
            //urlTextField.text = "http://\(urlString)"
            //println("\(urlString)")

        }
    }

    func buttonState() {

        self.backButton.enabled = self.webView.canGoBack
        self.forwardButton.enabled = self.webView.canGoForward
    }


}

