-- changeset finpulse:21
CREATE TABLE IF NOT EXISTS scheduled_tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    task_type VARCHAR(100) NOT NULL,  -- 'BALANCE_UPDATE', 'NOTIFICATION', 'REPORT_GENERATION'
    task_name VARCHAR(200) NOT NULL,   -- 'WEEKLY_BALANCE_UPDATE', 'DAILY_BUDGET_NOTIFICATION'
    task_data JSONB,                   -- Гибкие параметры задачи
    scheduled_time TIMESTAMP WITH TIME ZONE NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDING', -- PENDING, PROCESSING, COMPLETED, FAILED
    priority INTEGER DEFAULT 5,        -- Приоритет выполнения
    max_retries INTEGER DEFAULT 3,
    retry_count INTEGER DEFAULT 0,
    last_error TEXT,
    locked_by VARCHAR(100),            -- Какой инстанс взял задачу
    locked_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Индексы для эффективного поиска задач
CREATE INDEX IF NOT EXISTS idx_scheduled_tasks_type_status ON scheduled_tasks(task_type, status);
CREATE INDEX IF NOT EXISTS idx_scheduled_tasks_scheduled_time ON scheduled_tasks(scheduled_time) WHERE status = 'PENDING';
CREATE INDEX IF NOT EXISTS idx_scheduled_tasks_priority ON scheduled_tasks(priority, scheduled_time) WHERE status = 'PENDING';