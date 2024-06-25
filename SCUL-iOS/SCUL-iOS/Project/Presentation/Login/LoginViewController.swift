import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

class LoginViewController: BaseViewController<LoginViewModel> {
    private let loginButtonDidTap = PublishRelay<(String, String)>()
    private let errorLabelPublish = PublishRelay<String>()
    private let navigateToSignupButtonDidTap = PublishRelay<Void>()
    private var isActivateEye = false {
        didSet {
            var eyesImage: UIImage {
                isActivateEye ? .EyesOn!: .EyesOff!
            }
            passwordTextField.isSecureTextEntry = !isActivateEye
            eyesButton.setImage(eyesImage, for: .normal)
        }
    }

    private let containerView = UIView()
    private let loginGuideLabel = UILabel().then {
        $0.labelSetting(text: "로그인하고\nSCUL을 사용해보세요", font: UIFont.heading3)
    }
    private let loginLabel = UILabel().then {
        $0.labelSetting(text: "아이디", font: UIFont.label2)
    }
    private let loginTextField = UITextField().then {
        $0.textFieldSetting(placeholder: "아이디", font: UIFont.caption2, isHide: false)
        $0.addLeftAndRightView()
    }
    private let passwordLabel = UILabel().then {
        $0.labelSetting(text: "비밀번호", font: UIFont.label2)
    }
    private let passwordTextField = UITextField().then {
        $0.textFieldSetting(placeholder: "비밀번호", font: UIFont.caption2, isHide: true)
        $0.addLeftAndRightView()
    }
    private let errorLabel = UILabel().then {
        $0.labelSetting(text: "", font: .body2)
        $0.textColor = .Main800
    }
    private let eyesButton = UIButton().then {
        $0.setImage(.EyesOff, for: .normal)
    }
    private let signupLabel = UILabel().then {
        $0.labelSetting(text: "아직 회원이 아니라면?", font: UIFont.body2)
    }
    private let navigateToSignupButton = UIButton().then {
        $0.buttonSetting(
            text: "회원가입 하기",
            font: UIFont.body2,
            titleColor: .Main500
        )
    }
    private let loginButton = UIButton().then {
        $0.buttonSetting(
            text: "로그인",
            font: UIFont.button2,
            titleColor: nil
        )
        $0.backgroundColor = .Gray300
        $0.layer.cornerRadius = 4
        $0.isEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
    }

    public override func addView() {
        [
            containerView,
            loginGuideLabel,
            loginLabel,
            loginTextField,
            passwordLabel,
            passwordTextField,
            eyesButton,
            loginButton,
            errorLabel
        ].forEach { self.view.addSubview($0) }

        [
            signupLabel,
            navigateToSignupButton
        ].forEach { self.containerView.addSubview($0) }
    }

    public override func setLayout() {
        loginGuideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(128)
            $0.leading.equalToSuperview().inset(25)
        }

        loginLabel.snp.makeConstraints {
            $0.top.equalTo(loginGuideLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(25)
        }
        loginTextField.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }

        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(loginTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(25)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(25)
        }
        eyesButton.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(12)
            $0.centerY.equalTo(passwordTextField)
        }

        loginButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(72)
        }

        signupLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }
        navigateToSignupButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(signupLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.top).inset(-40)
            $0.centerX.equalToSuperview()
        }
    }

    public override func bind() {
        let input = LoginViewModel.Input(
            loginButtonDidTap: loginButtonDidTap,
            navigateToSignupButtonDidTap: navigateToSignupButtonDidTap,
            idText: loginTextField.rx.text.orEmpty.asObservable(),
            passwordText: passwordTextField.rx.text.orEmpty.asObservable(),
            loginButtonSignal: loginButton.rx.tap.asObservable()
        )

        let output = viewModel.transform(input)

        output.errorDescription.asObservable()
            .bind(onNext: { error in
                self.errorLabel.text = error
            })
            .disposed(by: disposeBag)
    }

    public override func configureViewController() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.rx.tap
            .subscribe(onNext: { _ in
                if let loginText = self.loginTextField.text,
                   let passwordText = self.passwordTextField.text {
                    self.loginButtonDidTap.accept((loginText, passwordText))
                } else {
                    print("Error: Missing login or password")
                }
            })
            .disposed(by: disposeBag)

        navigateToSignupButton.rx.tap
            .subscribe(onNext: { _ in
                self.navigateToSignupButtonDidTap.accept(())
            })
            .disposed(by: disposeBag)

        eyesButton.rx.tap
            .subscribe(onNext: {
                self.isActivateEye.toggle()
            })
            .disposed(by: disposeBag)
    }

    public override func configureNavigation() {}
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let loginText = loginTextField.text, let passwordText = passwordTextField.text,
           !loginText.isEmpty && !passwordText.isEmpty {
            loginButton.backgroundColor = .Main500
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
        return true
    }
}
