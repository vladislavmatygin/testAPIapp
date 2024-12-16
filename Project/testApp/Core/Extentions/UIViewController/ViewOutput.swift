@MainActor
protocol ViewOutput: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func viewIsAppearing()

    func didTapClose()
    func didTapBack()

    func traitCollectionDidChange()
}

extension ViewOutput {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
    func viewIsAppearing() {}

    func didTapClose() {}
    func didTapBack() {}

    func traitCollectionDidChange() {}
}
