import Foundation

let ENV_HOST = "HOST"

enum EnvironmentVariablesService {
    static func getHost() -> String? {
        if let host = ProcessInfo.processInfo.environment[ENV_HOST] {
            return host
        }
        return nil
    }
}
