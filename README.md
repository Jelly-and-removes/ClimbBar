# ClimbBar
<p align="center">
<img src="https://github.com/keisukeYamagishi/ClimbBar/blob/master/doc/climbBarlog.png" width="50%" height="50%">

[![](https://img.shields.io/apm/l/vim-mode.svg)](https://github.com/keisukeYamagishi/Direction/blob/master/LICENSE)
[![](https://img.shields.io/badge/twitter-brew__0__O-blue.svg)](https://twitter.com/brew_0_O)

</p>

# Overview

iOS library that can extend a View that has scrollable elements such as UITableView and UIWebView.

As you can see in the example apps, the scroll bar hides the navigation bar.

I was affected by AirBar.

|github page bild| status |
|:----|:------|
|result|![build](https://github.com/keisukeYamagishi/ClimbBar/workflows/build/badge.svg)|

## Gif

<img src="./doc/climbbar-demo.gif" width=40% height="40%">

## Cocoapods

```
pod 'ClimbBar'
```

## git clone

***Via SSH***: For those who plan on regularly making direct commits, cloning over SSH may provide a better experience (which requires uploading SSH keys to GitHub):

```
$ git clone git@github.com:keisukeYamagishi/ClimbBar.git
```
***Via https***: For those checking out sources as read-only, HTTPS works best:

```
$ git clone https://github.com/keisukeYamagishi/ClimbBar.git
```

## Sample code

```Swift
override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let toHeaderBottom = statusBarHeight + (navigationController?.navigationBar.frame.size.height)!
        let conf = Configuration(range: statusBarHeight...toHeaderBottom)

        climbBar = ClimbBar(configurations: conf,
                            scrollable: tableView)

        climbBar.observer = { [weak self] state in
            guard let self = self else { return }
            self.navigationController?.setAlpha(alpha: CGFloat(state.alpha))
            let navigtionFrame = CGRect(x: 0,
                                        y: state.originY,
                                        width: self.view.frame.size.width,
                                        height: 44)
            self.navigationController?.navigationBar.frame = navigtionFrame
        }
    }
```
