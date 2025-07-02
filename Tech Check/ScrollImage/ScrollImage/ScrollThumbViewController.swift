import UIKit

class ScrollThumbViewController: UIViewController, UIScrollViewDelegate {

    let scrollView = UIScrollView()
    let thumbImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.frame = view.bounds
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        // 콘텐츠 추가
        let content = UIStackView()
        content.axis = .vertical
        content.spacing = 16

        for i in 0..<100 {
            let label = UILabel()
            label.text = "Item \(i)"
            label.backgroundColor = .systemGray5
            label.textAlignment = .center
            label.frame.size.height = 60
            content.addArrangedSubview(label)
        }

        scrollView.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: scrollView.topAnchor),
            content.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            content.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // 🐶 이미지 썸뷰 (dogProfile은 Assets에 있어야 함)
        thumbImageView.image = UIImage(named: "dog_thumb.png") ?? UIImage(systemName: "pawprint.circle.fill")
        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.clipsToBounds = true
        thumbImageView.layer.cornerRadius = 15
        thumbImageView.backgroundColor = UIColor.yellow.withAlphaComponent(0.6)
        thumbImageView.frame = CGRect(x: view.bounds.width - 40, y: 0, width: 30, height: 30)
        view.addSubview(thumbImageView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let visibleHeight = scrollView.frame.height
        let offsetY = scrollView.contentOffset.y

        guard contentHeight > visibleHeight else { return }

        let scrollRatio = offsetY / (contentHeight - visibleHeight)
        let thumbRange = visibleHeight - thumbImageView.frame.height
        let thumbY = scrollRatio * thumbRange

        thumbImageView.frame.origin.y = thumbY
    }
}
