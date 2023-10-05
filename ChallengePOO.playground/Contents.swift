import UIKit

// Definindo uma classe para representar uma tarefa
class Task {
    var title: String
    var isCompleted: Bool

    init(title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

// Definindo uma classe para gerenciar a lista de tarefas
class TaskManager {
    var tasks: [Task] = []

    // Função para adicionar uma tarefa
    func addTask(title: String) {
        let task = Task(title: title, isCompleted: false)
        tasks.append(task)
    }

    // Função para listar todas as tarefas
    func listTasks() {
        for (index, task) in tasks.enumerated() {
            let status = task.isCompleted ? "Concluída" : "Pendente"
            print("\(index + 1). \(task.title) - \(status)")
        }
    }

    // Closure que marca uma tarefa como concluída
    lazy var completeTask: (Int) -> Void = { [weak self] index in
        guard let self = self else { return }
        if index >= 0 && index < self.tasks.count {
            self.tasks[index].isCompleted = true
            print("Tarefa marcada como concluída.")
        } else {
            print("Índice inválido.")
        }
    }

    // Função assíncrona para simular concorrência
    func simulateConcurrency() {
        let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)

        concurrentQueue.async {
            self.addTask(title: "Tarefa 1")
            self.listTasks()
        }

        concurrentQueue.async {
            self.addTask(title: "Tarefa 2")
            self.listTasks()
        }

        concurrentQueue.async {
            self.completeTask(0)
            self.listTasks()
        }

        concurrentQueue.async {
            self.completeTask(1)
            self.listTasks()
        }
    }
}

// Criando uma instância do gerenciador de tarefas
let taskManager = TaskManager()

// Adicionando tarefas
taskManager.addTask(title: "Comprar leite")
taskManager.addTask(title: "Fazer exercícios")

// Listando tarefas
print("Lista de Tarefas:")
taskManager.listTasks()

// Marcar tarefas como concluídas
taskManager.completeTask(0)
taskManager.completeTask(2)

// Listando tarefas novamente
print("\nLista de Tarefas Atualizada:")
taskManager.listTasks()

// Simulando concorrência
taskManager.simulateConcurrency()
