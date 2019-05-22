# ClimbBar
<p align="center">
<img src="https://github.com/keisukeYamagishi/ClimbBar/blob/master/doc/climbBarlog.png" width="50%" height="50%">

[![](https://img.shields.io/apm/l/vim-mode.svg)](https://github.com/keisukeYamagishi/Direction/blob/master/LICENSE)
[![](https://img.shields.io/badge/twitter-brew__0__O-blue.svg)](https://twitter.com/brew_0_O)

</p>

# Overview

iOS library that can extend a View that has scrollable elements such as UITableView and UIWebView.

As you can see in the example apps, the scroll bar hides the navigation bar.

|travis| status |
|:----|:------|
|result|![](https://travis-ci.org/keisukeYamagishi/ClimbBar.svg?branch=master)|

## Cocoapods

```
pod 'ClimbBar'
```

## git clone

***Via SSH***: For those who plan on regularly making direct commits, cloning over SSH may provide a better experience (which requires uploading SSH keys to GitHub):

```
$ git clone git@github.com:keisukeYamagishi/Direction.git
```
***Via https***: For those checking out sources as read-only, HTTPS works best:

```
$ git clone https://github.com/keisukeYamagishi/Direction.git
```

## Sample code

```Swift
override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
       
        let conf = Configuration(range: UIApplication.shared.statusBarFrame.height..<UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!)
        
        self.title = "ViewController"
        
        self.climbBar = ClimbBar(configurations: conf,
                                 scrollable: self.tableView,
                                 state: { (state) in
                                    self.navigationController!.setAlpha(alpha: CGFloat(state.alpha))
                                    self.navigationController?.navigationBar.frame = CGRect(x: 0,
                                                                                            y: state.originY,
                                                                                            width: self.view.frame.size.width,
                                                                                            height: 44)
        })
    }

```

