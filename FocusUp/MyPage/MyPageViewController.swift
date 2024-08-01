//
//  MyPageViewController.swift
//  FocusUp
//
//  Created by 성호은 on 7/24/24.
//

import UIKit
import FSCalendar

// MARK: - calendar header custom
class CustomHeaderView: UIView {
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        let previousImage = UIImage(named: "calendar_arrow_left")
        button.setImage(previousImage, for: .normal)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        let nextImage = UIImage(named: "calendar_arrow_right")
        button.setImage(nextImage, for: .normal)
        return button
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 24)
        label.textColor = UIColor(named: "Primary4")
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(previousButton)
        addSubview(nextButton)
        addSubview(monthLabel)
        
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            previousButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            previousButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            monthLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            monthLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            nextButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func updateMonthLabel(with date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        monthLabel.text = dateFormatter.string(from: date)
    }
}

// MARK: - mypage
class MyPageViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    // MARK: - properties
    @IBOutlet weak var settingButton: UIBarButtonItem!
    @IBOutlet weak var goalRoutineLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var addNewRoutineButton: UIButton!
    @IBOutlet weak var levelStateLabel: UILabel!
    @IBOutlet weak var levelNoticeLabel: UILabel!
    @IBOutlet weak var presentLevelLabel: UILabel!
    @IBOutlet weak var levelProgress: UIProgressView!
    @IBOutlet weak var levelLabel: UIStackView!
    @IBOutlet weak var calendarLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    
    var calendarHeaderView: CustomHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 폰트 적용
        self.goalRoutineLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.addUnderlineToMoreButton()
        self.addNewRoutineButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.levelStateLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.levelNoticeLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        self.presentLevelLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        self.addUnderlineToPresentLevelLabel()
        self.setLevelLabel()
        self.calendarLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.calendarView.appearance.weekdayFont = UIFont(name: "Pretendard-Regular", size: 14)
        
        // addNewRoutineButton 테두리 설정
        self.addNewRoutineButton.layer.cornerRadius = 8
        self.addNewRoutineButton.layer.borderWidth = 1
        self.addNewRoutineButton.layer.borderColor = UIColor(named: "BlueGray3")?.cgColor
        
        // progressView 설정
        levelProgress.layer.cornerRadius = 5
        levelProgress.clipsToBounds = true
        levelProgress.translatesAutoresizingMaskIntoConstraints = false
        levelProgress.progress = 0.0
        self.view.addSubview(levelProgress)
        
        // UIProgressView의 서브뷰인 progress 부분의 모서리 둥글게 만들기
        if let progressLayer = levelProgress.subviews.last {
            progressLayer.layer.cornerRadius = 5
            progressLayer.clipsToBounds = true
        }
        
        NSLayoutConstraint.activate([
            levelProgress.topAnchor.constraint(equalTo: levelNoticeLabel.bottomAnchor, constant: 19),
            levelProgress.bottomAnchor.constraint(equalTo: levelLabel.topAnchor, constant: -11),
            levelProgress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            levelProgress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            levelProgress.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        // 5개의 구간으로 나누어 진행 상황을 업데이트
        updateProgressView(to: 0.2) // 첫 번째 구간 (20%)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateProgressView(to: 0.4) // 두 번째 구간 (40%)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.updateProgressView(to: 0.6) // 세 번째 구간 (60%)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.updateProgressView(to: 0.8) // 네 번째 구간 (80%)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.updateProgressView(to: 1.0) // 다섯 번째 구간 (100%)
        }
        
        // 달력 설정
        calendarView.delegate = self
        calendarView.dataSource = self
        
        setupCalendarHeaderView() // 달력 헤더 설정
        updateHeaderViewForCurrentMonth()
        
        calendarView.scope = .month
        calendarView.scrollDirection = .horizontal // 스크롤 방향
        calendarView.placeholderType = .none // 현재 월만 표시
        
        setupCalendarAppearance()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleLevelSelectionCompletion), name: .didCompleteLevelSelection, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleCancelLevelSelection), name: .didCancelLevelSelection, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setWeekdayLabels() // 요일 영어로 변경
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        // 네비게이션 바 타이틀 설정
        self.navigationItem.title = "마이페이지"
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .systemBackground
        navigationBarAppearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController!.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        // 탭바 아이템 타이틀 설정
        self.tabBarItem.title = "MyPage"
        // 탭바 기본상태, 스크롤상태 background 및 shadow 색상 설정
        if let tabBar = self.tabBarController?.tabBar {
            tabBar.barTintColor = UIColor.systemBackground
            tabBar.standardAppearance.shadowColor = .clear
            tabBar.scrollEdgeAppearance?.shadowColor = .clear
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
        }
        
        if let customFont = UIFont(name: "Pretendard-Regular", size: 18) {
            let textAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: customFont
            ]
            self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        } else {
            print("커스텀 폰트를 로드할 수 없습니다.")
        }
    }

    // MARK: - action
    @IBAction func didTapSettingBtn(_ sender: Any) {
        guard let toSettingVC = self.storyboard?.instantiateViewController(identifier: "SettingViewController") else { return }
        self.navigationController?.pushViewController(toSettingVC, animated: true)
    }
    
    @IBAction func didTapMoreBtn(_ sender: Any) {
        guard let toGoalRoutineListVC = self.storyboard?.instantiateViewController(identifier: "GoalRoutineListViewController") else { return }
        self.navigationController?.pushViewController(toGoalRoutineListVC, animated: true)
    }
    
    @IBAction func didTapAddNewRoutineBtn(_ sender: Any) {
        guard let toGoalRoutineSettingVC = self.storyboard?.instantiateViewController(identifier: "GoalRoutineSettingViewController") else { return }
        self.navigationController?.pushViewController(toGoalRoutineSettingVC, animated: true)
    }
    
    private func addUnderlineToMoreButton() {
        let title = "더보기"
        let font = UIFont(name: "Pretendard-Regular", size: 10)
        let attributedTitle = NSAttributedString(string: title, attributes: [
            .font: font ?? .systemFont(ofSize: 10),
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.black
        ])
        moreButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    private func addUnderlineToPresentLevelLabel() {
        guard let title = presentLevelLabel.text else {
            return
        }
        let attributedTitle = NSAttributedString(string: title, attributes: [
            .font: presentLevelLabel.font ?? UIFont.systemFont(ofSize: 12),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        presentLevelLabel.attributedText = attributedTitle
    }
    
    private func updateProgressView(to progress: Float) {
        if let levelProgress = levelProgress {
            levelProgress.setProgress(progress, animated: true)
        } else {
            print("Error: levelProgress is nil")
        }
    }

    private func setLevelLabel() {
        for case let label as UILabel in levelLabel.arrangedSubviews {
            setLabel(label)
        }
    }
    
    private func setLabel(_ label: UILabel) {
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
    }
    
    @objc private func handleNotification(_ notification: Notification) {
        // Notification에서 전달된 userInfo를 확인
        if let buttonType = notification.userInfo?["buttonType"] as? String, buttonType == "levelButton" {
            handleLevelSelectionCompletion()
        }
    }
    
    @objc private func handleLevelSelectionCompletion() {

        // UI 요소를 숨김
        levelNoticeLabel?.isHidden = true
        presentLevelLabel?.isHidden = true
        levelProgress?.isHidden = true
        levelLabel?.isHidden = true

        // 새로운 레이블 생성 및 설정
        let levelDownLabel = UILabel()
        levelDownLabel.text = "현재 레벨 하향 기능을 사용하였습니다."
        levelDownLabel.font = UIFont(name: "Pretendard-Regular", size: 13)
        levelDownLabel.textColor = UIColor(named: "EmphasizeError")
        levelDownLabel.textAlignment = .center

        let modifyNoticeLabel = UILabel()
        modifyNoticeLabel.text = "하향된 레벨을 사용 중에는 레벨업 도달 횟수가 증가하지 않습니다.\n레벨을 복원할 경우 이전에 저장된 도달 횟수부터 다시 증가합니다."
        modifyNoticeLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        modifyNoticeLabel.textColor = UIColor.black
        modifyNoticeLabel.textAlignment = .center
        modifyNoticeLabel.numberOfLines = 2

        // NSMutableParagraphStyle 생성 및 줄간격 설정
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5 // 원하는 줄간격 값 설정

        // AttributedString 생성
        let attributedString = NSMutableAttributedString(string: modifyNoticeLabel.text ?? "")
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        // 레이블에 AttributedString 설정
        modifyNoticeLabel.attributedText = attributedString

        // 새로운 레이블을 뷰에 추가
        view.addSubview(levelDownLabel)
        view.addSubview(modifyNoticeLabel)

        // 레이블의 오토레이아웃 설정
        levelDownLabel.translatesAutoresizingMaskIntoConstraints = false
        modifyNoticeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            levelDownLabel.leadingAnchor.constraint(equalTo: levelStateLabel.leadingAnchor),
            levelDownLabel.topAnchor.constraint(equalTo: levelStateLabel.bottomAnchor, constant: 19),
            modifyNoticeLabel.leadingAnchor.constraint(equalTo: levelStateLabel.leadingAnchor),
            modifyNoticeLabel.topAnchor.constraint(equalTo: levelDownLabel.bottomAnchor, constant: 10)
        ])
        
        // 저장
        self.levelDownLabel = levelDownLabel
        self.modifyNoticeLabel = modifyNoticeLabel
    }
    
    private var levelDownLabel: UILabel?
    private var modifyNoticeLabel: UILabel?
    
    // MARK: - didTapCompleteButton 메서드
    @objc private func didTapCompleteButton() {
        // 숨겨진 UI 요소를 다시 표시
        levelNoticeLabel?.isHidden = false
        presentLevelLabel?.isHidden = false
        levelProgress?.isHidden = false
        levelLabel?.isHidden = false
        
        // 추가된 레이블을 제거
        levelDownLabel?.removeFromSuperview()
        modifyNoticeLabel?.removeFromSuperview()
    }

    @objc private func didTapMyLevelButton() {
        // handleLevelSelectionCompletion 호출
        handleLevelSelectionCompletion()
    }
    
    @objc private func handleCancelLevelSelection() {
        didTapCompleteButton()
    }
    
    deinit {
        // NotificationCenter에서 옵저버 제거
        NotificationCenter.default.removeObserver(self, name: .didCompleteLevelSelection, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didCancelLevelSelection, object: nil)
    }
}

// MARK: - 달력 설정
extension MyPageViewController {
    
    // 요일 영어로 변경
    private func setWeekdayLabels() {
        let weekdaySymbols = ["S", "M", "T", "W", "T", "F", "S"]
        for (index, label) in calendarView.calendarWeekdayView.weekdayLabels.enumerated() {
            label.text = weekdaySymbols[index]
            label.font = UIFont(name: "Pretendard-Regular", size: 12)
            label.textColor = UIColor(red: 0.42, green: 0.44, blue: 0.45, alpha: 1)
        }
    }
    
    // 달력 헤더 설정
    private func setupCalendarHeaderView() {
        calendarHeaderView = CustomHeaderView()
        view.addSubview(calendarHeaderView)
        
        calendarHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarHeaderView.topAnchor.constraint(equalTo: calendarView.topAnchor),
            calendarHeaderView.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor),
            calendarHeaderView.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor),
            calendarHeaderView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        calendarHeaderView.previousButton.addTarget(self, action: #selector(didTapPreviousMonthButton), for: .touchUpInside)
        calendarHeaderView.nextButton.addTarget(self, action: #selector(didTapNextMonthButton), for: .touchUpInside)
        
        calendarView.calendarHeaderView.isHidden = true
    }
    
    private func setupCalendarAppearance() {
        // FSCalendar appearance 설정
        calendarView.appearance.todayColor = UIColor.clear // 현재 날짜의 배경색 제거
        calendarView.appearance.todaySelectionColor = UIColor.clear // 선택된 현재 날짜의 배경색 제거
        calendarView.appearance.selectionColor = UIColor.clear // 기본 선택 배경색 제거
        calendarView.appearance.titleSelectionColor = UIColor.black // 선택된 날짜의 제목 색상 설정
        calendarView.appearance.titleTodayColor = UIColor.black // 현재 날짜의 제목 색상 설정
    }
    
    @objc private func didTapPreviousMonthButton() {
        let currentPage = calendarView.currentPage
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentPage)!
        calendarView.setCurrentPage(previousMonth, animated: true)
    }
    
    @objc private func didTapNextMonthButton() {
        let currentPage = calendarView.currentPage
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentPage)!
        calendarView.setCurrentPage(nextMonth, animated: true)
    }
    
    private func updateHeaderViewForCurrentMonth() {
        let currentPage = calendarView.currentPage
        calendarHeaderView.updateMonthLabel(with: currentPage)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        updateHeaderViewForCurrentMonth()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        // 기본 배경색을 투명으로 설정
        return UIColor.clear
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        // 선택된 날짜의 제목 색상 설정
        return appearance.titleDefaultColor // 기본 제목 색상 유지
    }
}
