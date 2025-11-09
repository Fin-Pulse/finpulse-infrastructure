# FinPulse Infrastructure

Содержит всю инфраструктуру для поднятия всей backend части, включая микросервисы, хранилища, брокеры сообщений, ML-сервис.

# Файл .env
Создайте файл .env в той же директории, что и docker-compose.prod.yml:

```bash
# Database
DB_PASSWORD=your_strong_production_password_here

# JWT Secret (очень важный!)
JWT_SECRET=your_very_strong_jwt_secret_key_min_32_chars

# Bank API credentials
BANK_CLIENT_ID=team214
BANK_CLIENT_SECRET=your_bank_client_secret_here

# MinIO credentials
MINIO_ROOT_USER=minioadmin
MINIO_ROOT_PASSWORD=strong_minio_password_here
MINIO_PUBLIC_URL=http://localhost:9000/ml-charts
```

## Запуск
Используем docker-compose.prod.yml

```bash
docker-compose -f docker-compose.prod.yml up -d
```

## Возможные ошибки

### Миграции не применились
Если миграции БД не были применены автоматически, перезапустите сервис миграций:

```bash
docker-compose -f docker-compose.prod.yml restart liquibase-migrations
```

Или принудительно пересоздайте контейнер:
```bash
docker-compose -f docker-compose.prod.yml up -d --force-recreate liquibase-migrations
```

### Проблемы с подключением к БД
Убедитесь, что:
- PostgreSQL контейнер запущен и здоров
- Переменные окружения DB_PASSWORD корректны
- Сеть Docker корректно настроена

### MinIO недоступен
Проверьте:
- Контейнер MinIO запущен
- Порт 9000 не занят другим процессом
- Bucket `ml-charts` создан и имеет публичный доступ

### Проблемы с Kafka
Если Kafka не запускается:
- Убедитесь, что есть достаточно памяти
- Проверьте volume kafka_data
- Попробуйте пересоздать контейнер Kafka

### CORS ошибки на фронтенде
Убедитесь, что в переменных окружения CORS_ALLOWED_ORIGINS указаны правильные домены фронтенда.

### Сервисы не могут подключиться друг к другу
Проверьте:
- Все сервисы в одной сети finpulse-network
- Имена хостов соответствуют именам сервисов в docker-compose
- Нет конфликтов портов

## Мониторинг
- MinIO UI: http://localhost:9001
- Kafka UI: http://localhost:8091
- Health checks сервисов: /actuator/health

## Остановка
```bash
docker-compose -f docker-compose.prod.yml down
```

## Полная пересборка
```bash
docker-compose -f docker-compose.prod.yml down -v
docker-compose -f docker-compose.prod.yml up -d
```

## Логи
Для просмотра логов конкретного сервиса:
```bash
docker logs finpulse-userservice -f
docker logs finpulse-aggregationservice -f
docker logs finpulse-notificationservice -f
docker logs finpulse-mlservice -f
```
