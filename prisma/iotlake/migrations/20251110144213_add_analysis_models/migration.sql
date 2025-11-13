-- CreateTable
CREATE TABLE `analyses` (
    `id` VARCHAR(40) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `code` TEXT NULL,
    `env_vars` JSON NULL,
    `current_version` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,

    UNIQUE INDEX `analyses_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `analysis_versions` (
    `id` VARCHAR(40) NOT NULL,
    `code` TEXT NOT NULL,
    `version` INTEGER NOT NULL,
    `analysis_id` VARCHAR(40) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,

    UNIQUE INDEX `analysis_versions_analysis_id_version_key`(`analysis_id`, `version`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `analysis_logs` (
    `id` VARCHAR(40) NOT NULL,
    `result` JSON NULL,
    `log` TEXT NULL,
    `status` ENUM('PENDING', 'RUNNING', 'SUCCESS', 'FAILED', 'ERROR') NOT NULL,
    `analysis_id` VARCHAR(40) NOT NULL,
    `execution_id` VARCHAR(40) NOT NULL,
    `equipment_id` VARCHAR(40) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,

    UNIQUE INDEX `analysis_logs_execution_id_key`(`execution_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `analysis_versions` ADD CONSTRAINT `analysis_versions_analysis_id_fkey` FOREIGN KEY (`analysis_id`) REFERENCES `analyses`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `analysis_logs` ADD CONSTRAINT `analysis_logs_analysis_id_fkey` FOREIGN KEY (`analysis_id`) REFERENCES `analyses`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `analysis_logs` ADD CONSTRAINT `analysis_logs_equipment_id_fkey` FOREIGN KEY (`equipment_id`) REFERENCES `equipments`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
