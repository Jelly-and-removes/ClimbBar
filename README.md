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
|result|[![](https://travis-ci.org/keisukeYamagishi/ClimbBar.svg?branch=master)](https://travis-ci.org/keisukeYamagishi/ClimbBar)|

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

## Use it 



### Custom bar

ClimbBar uses contentInset to move the scroll elements, so

As in the picture below

#### Storyboard

![](https://github.com/keisukeYamagishi/ClimbBar/blob/master/doc/contentInset.png)

####  Code

```
self.scrollable.contentInsetAdjustmentBehavior = .never
```

### Apple offical site
UIScrollView.ContentInsetAdjustmentBehavior
Constants indicating how safe area insets are added to the adjusted content inset.

Please use it as Never.

[UIScrollView.ContentInsetAdjustmentBehavior (Apple)](https://developer.apple.com/documentation/uikit/uiscrollview/contentinsetadjustmentbehavior)

***BUT Look at the following***

If you use UINavigationController, it will work without using it.

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

## Adjust position sample code

check it bellow link file

https://github.com/keisukeYamagishi/ClimbBar/blob/master/ClimbBarExample/CollectionViewController.swift

Use this logic to "UINavigationaBar" and "CollectionView" position  can adjust it

```
// MARK: UIScrollViewDelegate
extension CollectionViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let statusBarFrame = UIApplication.shared.statusBarFrame
        let navigationFrame = self.navigationController?.navigationBar.frame
        
        if self.collectionView.contentOffset.y < (statusBarFrame.size.height + (navigationFrame?.size.height)!)
            && ((statusBarFrame.size.height + (navigationFrame?.size.height)!) + 100) > self.collectionView.contentOffset.y {
            UIView.animate(withDuration: 0.23, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
                self.climbBar.adjustScrollable()
                let navigtionFrame = CGRect(x: 0,
                                            y: UIApplication.shared.statusBarFrame.size.height,
                                            width: self.view.frame.size.width,
                                            height: 44)
                self.navigationController?.navigationBar.frame = navigtionFrame
            })
        }
    }
}
```

