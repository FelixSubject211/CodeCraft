//
//  CodeEditorViewModel.swift
//  CodeCraft
//
//  Created by Felix Fischer on 22.09.24.
//

import Combine
import Foundation
import CodeEditorView
import LanguageSupport

class CodeEditorViewModel: ObservableObject {
    @Published var code: String = """
    function createHashMap(size = 100) {
        const buckets = Array(size).fill(null).map(() => []);

        function hash(key) {
            let hashValue = 0;
            for (let i = 0; i < key.length; i++) {
                hashValue = (hashValue + key.charCodeAt(i) * i) % size;
            }
            return hashValue;
        }

        function set(key, value) {
            const index = hash(key);
            const bucket = buckets[index];
            
            for (let i = 0; i < bucket.length; i++) {
                const [bucketKey] = bucket[i];
                if (bucketKey === key) {
                    bucket[i] = [key, value];
                    return;
                }
            }

            bucket.push([key, value]);
        }

        function get(key) {
            const index = hash(key);
            const bucket = buckets[index];

            for (let i = 0; i < bucket.length; i++) {
                const [bucketKey, bucketValue] = bucket[i];
                if (bucketKey === key) {
                    return bucketValue;
                }
            }

            return undefined;
        }

        function remove(key) {
            const index = hash(key);
            const bucket = buckets[index];

            for (let i = 0; i < bucket.length; i++) {
                const [bucketKey] = bucket[i];
                if (bucketKey === key) {
                    bucket.splice(i, 1);
                    return true;
                }
            }

            return false;
        }

        return {
            set,
            get,
            remove,
        };
    }

    const myHashMap = createHashMap();
    myHashMap.set("name", "Felix");
    console.log(myHashMap.get("name"));
    myHashMap.remove("name");
    console.log(myHashMap.get("name"));
    """
    @Published var position = CodeEditor.Position()
    @Published var messages: Set<TextLocated<Message>> = Set()
    
    private let router: Router
    private let repository: CodeExecutionRepository
    private var cancellables = Set<AnyCancellable>()

    init(router: Router, repository: CodeExecutionRepository) {
        self.router = router
        self.repository = repository
        setupBindings()
    }
    
    private func setupBindings() {
        repository.output
            .receive(on: RunLoop.main)
            .sink { [weak self] output in
                self?.messages = Set(output.compactMap {
                    switch($0.status) {
                    case .success:
                        return nil
                    case .failure(lineNumber: let lineNumber):
                        return TextLocated(location: .init(oneBasedLine: lineNumber, column: 0), entity: Message(
                            category: .error,
                            length: 1,
                            summary: $0.output,
                            description: nil
                        ))
                    }
                })
            }
            .store(in: &cancellables)
    }

    func executeCode() {
        repository.execute(code: code)
        router.push(.codeOutputIfIOS)
    }
}
