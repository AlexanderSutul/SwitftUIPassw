import Foundation

struct PasswordResponse: Codable {
    var password: String
}

enum Result<Success, Error> {
    case success(Success)
    case failure(Error)
}

enum PasswordService {
    static func getNewPassword() async -> Result<PasswordResponse, Error>? {
        guard let hostEnv = EnvironmentVariablesService.getHost() else {
            print("no HOST env variable were provided")
            return nil
        }
        let host = "\(hostEnv)/api/password"
        guard let url = URL(string: host) else {
            print("url is incorrect -> \(host)")
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(PasswordResponse.self, from: data)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
