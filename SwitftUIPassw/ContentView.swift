import SwiftUI

struct ContentView: View {
    @State private var isSecure = true
    @State private var isLoading = false
    @State private var isCopied = false

    @State private var currentPassword = String(repeating: "*", count: 10)
    @State private var errorText = ""

    var body: some View {
        VStack {
            VStack {
                Text("PassGenApp")
                    .font(.title3)

                HStack(alignment: .center) {
                    if !currentPassword.isEmpty {
                        PasswordLabelView(isSecured: $isSecure, password: $currentPassword)
                    } else {
                        ProgressView()
                    }
                }
                .frame(height: 180)
                HStack(spacing: 32) {
                    Button(!isSecure ? "HIDE" : "SHOW", action: show)
                        .frame(width: 80)
                        .padding(8)

                    Button("GET NEW", action: {
                        Task { await getNew() }
                    })
                    .frame(width: 100)
                    .buttonStyle(.borderedProminent)
                    .disabled(isLoading)

                    Button(isCopied ? "Copied" : "COPY", action: copyToClipboard)
                        .frame(width: 80)
                        .disabled(isCopied)
                        .padding(8)
                }
                if !errorText.isEmpty {
                    ErrorLabelView(errorText: errorText)
                        .padding(.top, 64)
                }
            }
            Spacer()
        }
        .padding()
        .onAppear { Task { await getNew() } }
    }

    func show() {
        isSecure.toggle()
    }

    func getNew() async {
        isLoading = true
        errorText = ""

        let passwordResult = await PasswordService.getNewPassword()

        switch passwordResult {
        case .success(let passwordResponse):
            currentPassword = passwordResponse.password
        case .failure(let err):
            errorText = err.localizedDescription
        default:
            break
        }
        isLoading = false
    }

    func copyToClipboard() {
        UIPasteboard.general.string = currentPassword
        isCopied = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isCopied = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
