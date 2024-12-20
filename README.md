# Infrastructure Deployment

Этот репозиторий содержит конфигурации и скрипты для развёртывания сервисов **TimeController** и **OrderCloser** в контейнерах Docker.

## Структура репозиториев

Предполагается, что все три репозитория расположены следующим образом:

```
parent_directory/
├── time-controller/
├── orders-closer/
└── kultomat-infrastructure/
```

## Шаги по развёртыванию

1. **Клонируйте репозитории на сервер:**

2. **Перейдите в директорию kultomat-infrastructure:**

    ```bash
    cd kultomat-infrastructure
    ```

3. **Настройте переменные окружения:**

   - Отредактируйте файл .env, указав необходимые значения.

4. **Разверните сервисы:**
   ```bash
   ./scripts/deploy.sh
   ```

## Обновление сервисов

Для обновления сервисов повторите шаги с 3 по 4, если необходимо обновить секреты иначе только 4

### **Взаимодействие сервисов**

**TimeController** будет обращаться к **OrderCloser** по внутреннему имени сервиса и порту.
Например, в коде **TimeController** для отправки запроса к **OrderCloser**:
```python
import requests

ORDER_CLOSER_URL = "http://ordercloser:8000/api/endpoint"

response = requests.post(ORDER_CLOSER_URL, json=payload)
```

