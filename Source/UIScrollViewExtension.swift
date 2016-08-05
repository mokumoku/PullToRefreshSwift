//
//  PullToRefreshConst.swift
//  PullToRefreshSwift
//
//  Created by Yuji Hato on 12/11/14.
//
import Foundation
import UIKit

public extension UIScrollView {
    
    private func refreshViewWithTag(tag:Int) -> PullToRefreshView? {
        let pullToRefreshView = viewWithTag(tag)
        return pullToRefreshView as? PullToRefreshView
    }

    public func addPullRefreshHandler(refreshCompletion :((Void) -> Void)?) {
        self.addPullRefresh(refreshCompletion: refreshCompletion)
    }
    
    public func addPushRefreshHandler(refreshCompletion :((Void) -> Void)?) {
        self.addPushRefresh(refreshCompletion: refreshCompletion)
    }
    
    private func addPullRefresh(refreshCompletion :(((Void) -> Void)?), options: PullToRefreshOption = PullToRefreshOption()) {
        let refreshViewFrame = CGRect(x: 0, y: -PullToRefreshConst.height, width: self.frame.size.width, height: PullToRefreshConst.height)
        let refreshView = PullToRefreshView(options: options, frame: refreshViewFrame, refreshCompletion: refreshCompletion)
        refreshView.tag = PullToRefreshConst.pullTag
        addSubview(refreshView)
    }
    
    private func addPushRefresh(refreshCompletion :(((Void) -> Void)?), options: PullToRefreshOption = PullToRefreshOption()) {
        let refreshViewFrame = CGRect(x: 0, y: contentSize.height, width: self.frame.size.width, height: PullToRefreshConst.height)
        let refreshView = PullToRefreshView(options: options, frame: refreshViewFrame, refreshCompletion: refreshCompletion,down: false)
        refreshView.tag = PullToRefreshConst.pushTag
        addSubview(refreshView)
    }
    
    public func startPullRefresh() {
        let refreshView = self.refreshViewWithTag(tag: PullToRefreshConst.pullTag)
        refreshView?.state = .refreshing
    }
    
    public func stopPullRefreshEver(ever:Bool = false) {
        let refreshView = self.refreshViewWithTag(tag: PullToRefreshConst.pullTag)
        if ever {
            refreshView?.state = .finish
        } else {
            refreshView?.state = .stop
        }
    }
    
    public func removePullRefresh() {
        let refreshView = self.refreshViewWithTag(tag: PullToRefreshConst.pullTag)
        refreshView?.removeFromSuperview()
    }
    
    public func startPushRefresh() {
        let refreshView = self.refreshViewWithTag(tag: PullToRefreshConst.pushTag)
        refreshView?.state = .refreshing
    }
    
    public func stopPushRefreshEver(ever:Bool = false) {
        let refreshView = self.refreshViewWithTag(tag: PullToRefreshConst.pushTag)
        if ever {
            refreshView?.state = .finish
        } else {
            refreshView?.state = .stop
        }
    }
    
    public func removePushRefresh() {
        let refreshView = self.refreshViewWithTag(tag: PullToRefreshConst.pushTag)
        refreshView?.removeFromSuperview()
    }
    
    // If you want to PullToRefreshView fixed top potision, Please call this function in scrollViewDidScroll
    public func fixedPullToRefreshViewForDidScroll() {
        let pullToRefreshView = self.refreshViewWithTag(tag: PullToRefreshConst.pullTag)
        if !PullToRefreshConst.fixedTop || pullToRefreshView == nil {
            return
        }
        var frame = pullToRefreshView!.frame
        if self.contentOffset.y < -PullToRefreshConst.height {
            frame.origin.y = self.contentOffset.y
            pullToRefreshView!.frame = frame
        }
        else {
            frame.origin.y = -PullToRefreshConst.height
            pullToRefreshView!.frame = frame
        }
    }
}
