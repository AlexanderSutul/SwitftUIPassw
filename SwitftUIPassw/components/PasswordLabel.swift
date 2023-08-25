import SwiftUI

struct PasswordLabelView: View {
    @Binding var isSecured: Bool
    @Binding var password: String

    var body: some View {
        if isSecured {
            SecureField("", text: $password)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .disabled(true)
        } else {
            TextField("", text: $password)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .disabled(true)
        }
    }
}

struct PasswordLabelView_Previews: PreviewProvider {
    static var previews: some View {
        @State var pass = "qwe"
        @State var isSec = false
        PasswordLabelView(isSecured: $isSec, password: $pass)
    }
}
