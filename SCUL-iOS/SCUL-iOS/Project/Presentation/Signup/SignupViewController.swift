import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SignupViewController: BaseViewController<SignupViewModel> {
    private let signupButtonDidTap = PublishRelay<(String, String, String)>()
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
    private let signupGuideLabel = UILabel().then {
        $0.labelSetting(text: "회원가입하고\nSCUL을 사용해보세요", font: UIFont.heading3)
    }
    private let nameLabel = UILabel().then {
        $0.labelSetting(text: "이름", font: UIFont.label2)
    }
    private let nameTextField = UITextField().then {
        $0.textFieldSetting(placeholder: "이름", font: UIFont.caption2, isHide: false)
        $0.addLeftAndRightView()
    }
    private let signupLabel = UILabel().then {
        $0.labelSetting(text: "아이디", font: UIFont.label2)
    }
    private let signupTextField = UITextField().then {
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
    private let loginLabel = UILabel().then {
        $0.labelSetting(text: "이미 회원이라면?", font: UIFont.body2)
    }
    private let navigateToLoginButton = UIButton().then {
        $0.buttonSetting(
            text: "로그인 하기",
            font: UIFont.body2,
            titleColor: .Main500
        )
    }
    private let signupButton = UIButton().then {
        $0.buttonSetting(
            text: "회원가입",
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
            signupGuideLabel,
            nameLabel,
            nameTextField,
            signupLabel,
            signupTextField,
            passwordLabel,
            passwordTextField,
            errorLabel,
            eyesButton,
            signupButton
        ].forEach { self.view.addSubview($0) }

        [
            loginLabel,
            navigateToLoginButton
        ].forEach { self.containerView.addSubview($0) }
    }

    public override func setLayout() {
        signupGuideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(128)
            $0.leading.equalToSuperview().inset(25)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(signupGuideLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(25)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }

        signupLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(25)
        }
        signupTextField.snp.makeConstraints {
            $0.top.equalTo(signupLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }

        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(signupTextField.snp.bottom).offset(20)
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

        signupButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(72)
        }

        loginLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }
        navigateToLoginButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(loginLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.top.equalTo(signupButton.snp.top).inset(-40)
            $0.centerX.equalToSuperview()
        }
    }

    public override func bind() {
        let input = SignupViewModel.Input(
            signupButtonDidTap: signupButtonDidTap
        )

        let output = viewModel.transform(input)

        output.signupSuccess
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)

        output.errorDescription.asObservable()
            .bind(onNext: { error in
                self.errorLabel.text = error
            })
            .disposed(by: disposeBag)
    }

    public override func configureViewController() {
        signupTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self

        eyesButton.rx.tap
            .subscribe(onNext: {
                self.isActivateEye.toggle()
            })
            .disposed(by: disposeBag)

        signupButton.rx.tap
            .subscribe(onNext: {
                if let signupText = self.signupTextField.text,
                   let passwordText = self.passwordTextField.text,
                   let nameText = self.nameTextField.text {
                    self.signupButtonDidTap.accept((signupText, passwordText, nameText))
                    print("signupButton DidTap!")
                } else {
                    print("Error: Missing login or password")
                }
            })
            .disposed(by: disposeBag)
    }

    public override func configureNavigation() {}
}

extension SignupViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let loginText = signupTextField.text, let passwordText = passwordTextField.text, let nameText = nameTextField.text,
           !loginText.isEmpty && !passwordText.isEmpty && !nameText.isEmpty {
            signupButton.backgroundColor = .Main500
            signupButton.isEnabled = true
        } else {
            signupButton.isEnabled = false
        }
        return true
    }
}
