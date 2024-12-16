import SnapKit
import UIKit

protocol ProgressView {
    func progress(isLoading: Bool)
}

extension ProgressView where Self: AppViewController {
    func progress(isLoading: Bool) {
        switch isLoading {
        case true:
            var indicatorView = view.subviews.compactMap { $0 as? ActivityIndicatorView }.first
            if indicatorView == nil {
                let progressView = ActivityIndicatorView()
                view.addSubview(progressView)

                progressView.snp.makeConstraints { make in
                    make.centerX.equalTo(view.snp.centerX)
                    make.centerY.equalTo(view.snp.centerY)
                    make.size.equalTo(48)
                }

                indicatorView = progressView
            }
            indicatorView?.isHidden = false
            indicatorView?.startAnimating()

        case false:
            let indicatorView = view.subviews.compactMap { $0 as? ActivityIndicatorView }.first
            indicatorView?.stopAnimating()
            indicatorView?.isHidden = true
        }
    }
}

extension ProgressView where Self: UIViewController {
    func progress(isLoading: Bool) {
        switch isLoading {
        case true:
            var indicatorView = view.subviews.compactMap { $0 as? ActivityIndicatorView }.first
            if indicatorView == nil {
                let progressView = ActivityIndicatorView()
                view.addSubview(progressView)

                progressView.snp.makeConstraints { make in
                    make.centerX.equalTo(view.snp.centerX)
                    make.centerY.equalTo(view.snp.centerY)
                    make.size.equalTo(48)
                }

                indicatorView = progressView
            }
            indicatorView?.isHidden = false
            indicatorView?.startAnimating()

        case false:
            let indicatorView = view.subviews.compactMap { $0 as? ActivityIndicatorView }.first
            indicatorView?.stopAnimating()
            indicatorView?.isHidden = true
        }
    }
}
