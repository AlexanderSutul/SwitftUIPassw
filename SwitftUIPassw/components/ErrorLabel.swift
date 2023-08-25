import SwiftUI

struct ErrorLabelView: View {
    var errorText: String

    var body: some View {
        Text(errorText)
            .multilineTextAlignment(.center)
            .foregroundColor(.red)
    }
}

struct ErrorLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorLabelView(errorText: "Connection error")
    }
}
