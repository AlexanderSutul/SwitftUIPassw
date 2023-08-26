import Foundation

struct PasswordResponse: Codable {
    var password: String
}

enum Result<Success, Error> {
    case success(Success)
    case failure(Error)
}

enum GetNewPasswordError: Error {
    case invalidResponseError(Error)
    case invalidEnvVariable(variableName: String)
    case invalidUrl(url: String)
}

enum PasswordService {
    static func getNewPassword() async -> Result<PasswordResponse, GetNewPasswordError>? {
        guard let host = EnvironmentVariablesService.getHost() else {
            return .failure(.invalidEnvVariable(variableName: ENV_HOST))
        }

        let strUrl = "\(host)/api/password"
        guard let url = URL(string: strUrl) else {
            return .failure(.invalidUrl(url: strUrl))
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(PasswordResponse.self, from: data)
            return .success(response)
        } catch {
            return .failure(.invalidResponseError(error))
        }
    }
}
