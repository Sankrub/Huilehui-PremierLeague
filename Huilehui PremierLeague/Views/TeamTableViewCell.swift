import UIKit

protocol TeamTableViewCellDelegate: AnyObject { // This delegate is handle every auction in TableView below
    func didTapPlayback(for team: Team)
}

class TeamTableViewCell: UITableViewCell {
    
    static let cellId = "TeamTableViewCell"
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var badgeImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var playbackBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var foundedLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        return label
    }()
    
    private lazy var jobLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .white
        return label
    }()
    
    private lazy var infoLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private weak var delegate: TeamTableViewCellDelegate?
    private var team: Team?
    
    // MARK: -Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 10
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.team = nil
        self.delegate = nil
        self.contentView.subviews.forEach { $0.removeFromSuperview()}
    }
    
    func configure(with item: Team, delegate: TeamTableViewCellDelegate){
        self.team = item
        self.delegate = delegate // use self because we use the private one
        
        playbackBtn.addTarget(self, action: #selector(didTapPlayback), for: .touchUpInside)
        
        containerView.backgroundColor = item.id.background
        
        badgeImgView.image = item.id.badge
        playbackBtn.setImage(item.isPlaying ? Assets.pause : Assets.play, for: .normal) // if true so pause if not so play
        
        nameLbl.text = item.name
        foundedLbl.text = item.founded
        jobLbl.text = "Current \(item.manager.job.rawValue): \(item.manager.name)"
        infoLbl.text = item.info
        
        self.contentView.addSubview(containerView)
        
        containerView.addSubview(contentStackView)
        containerView.addSubview(badgeImgView)
        containerView.addSubview(playbackBtn)
        
        contentStackView.addArrangedSubview(nameLbl)
        contentStackView.addArrangedSubview(foundedLbl)
        contentStackView.addArrangedSubview(jobLbl)
        contentStackView.addArrangedSubview(infoLbl)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            badgeImgView.heightAnchor.constraint(equalToConstant: 50),
            badgeImgView.widthAnchor.constraint(equalToConstant: 50),
            badgeImgView.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            badgeImgView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: badgeImgView.trailingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: playbackBtn.leadingAnchor, constant: -8),
            
            playbackBtn.heightAnchor.constraint(equalToConstant: 44),
            playbackBtn.widthAnchor.constraint(equalToConstant: 44),
            playbackBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            playbackBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            
            
        ])
    }
    
    @objc func didTapPlayback(){ //objc is because using selector
        if let team = team {
            delegate?.didTapPlayback(for: team)
        }
    }
}
