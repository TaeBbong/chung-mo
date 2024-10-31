import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        return true
    }

    override func didSelectPost() {
        if let content = extensionContext?.inputItems.first as? NSExtensionItem,
           let itemProvider = content.attachments?.first {

            if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                // Handle URL
                itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil) { (item, error) in
                    if let url = item as? URL {
                        self.saveToUserDefaults(data: url.absoluteString)
                    }
                    self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                }
            } else if itemProvider.hasItemConformingToTypeIdentifier("public.plain-text") {
                // Handle plain text
                itemProvider.loadItem(forTypeIdentifier: "public.plain-text", options: nil) { (item, error) in
                    if let text = item as? String {
                        self.saveToUserDefaults(data: text)
                    }
                    self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                }
            }
        }
    }

    private func saveToUserDefaults(data: String) {
        let userDefaults = UserDefaults(suiteName: "group.com.taebbong.chungMo")
        userDefaults?.set(data, forKey: "sharedData")
        userDefaults?.synchronize()
    }

    override func configurationItems() -> [Any]! {
        return []
    }
}
