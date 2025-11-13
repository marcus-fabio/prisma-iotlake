-- CreateTable
CREATE TABLE `device_types` (
    `id` VARCHAR(40) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `params` JSON NULL,
    `parser_enabled` BOOLEAN NOT NULL,
    `code` TEXT NULL,
    `code_current_version` INTEGER NULL,
    `code_hash` VARCHAR(100) NULL,
    `var_to_store_lastvalue` JSON NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,
    `network_id` VARCHAR(40) NOT NULL,

    UNIQUE INDEX `device_types_name_key`(`name`),
    INDEX `device_types_name_idx`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `device_types_parser_versions` (
    `id` VARCHAR(40) NOT NULL,
    `code` TEXT NOT NULL,
    `code_version` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,
    `device_type_id` VARCHAR(40) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `networks` (
    `id` VARCHAR(40) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `params` JSON NULL,
    `parser_enabled` BOOLEAN NOT NULL,
    `code` TEXT NULL,
    `code_current_version` INTEGER NULL,
    `code_hash` VARCHAR(100) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,
    `network_type_id` VARCHAR(40) NOT NULL,

    UNIQUE INDEX `networks_name_key`(`name`),
    INDEX `networks_name_idx`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `networks_parser_versions` (
    `id` VARCHAR(40) NOT NULL,
    `code` TEXT NOT NULL,
    `code_version` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,
    `network_id` VARCHAR(40) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `network_types` (
    `id` VARCHAR(40) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `devices` (
    `id` VARCHAR(40) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `params` JSON NULL,
    `parser_enabled` BOOLEAN NOT NULL,
    `code` TEXT NULL,
    `code_current_version` INTEGER NULL,
    `code_hash` VARCHAR(100) NULL,
    `radio_serial` VARCHAR(40) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,
    `device_type_id` VARCHAR(40) NOT NULL,
    `equipment_id` VARCHAR(40) NULL,

    INDEX `devices_name_idx`(`name`),
    INDEX `devices_radio_serial_idx`(`radio_serial`),
    INDEX `devices_device_type_id_equipment_id_radio_serial_idx`(`device_type_id`, `equipment_id`, `radio_serial`),
    INDEX `devices_equipment_id_device_type_id_radio_serial_idx`(`equipment_id`, `device_type_id`, `radio_serial`),
    INDEX `devices_device_type_id_radio_serial_idx`(`device_type_id`, `radio_serial`),
    INDEX `devices_equipment_id_radio_serial_idx`(`equipment_id`, `radio_serial`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `devices_parser_versions` (
    `id` VARCHAR(40) NOT NULL,
    `code` TEXT NOT NULL,
    `code_version` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,
    `device_id` VARCHAR(40) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `equipments` (
    `id` VARCHAR(40) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `application_id` VARCHAR(40) NULL,
    `last_values` JSON NULL,
    `last_input_date` DATETIME(3) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,

    INDEX `equipments_name_idx`(`name`),
    INDEX `equipments_application_id_name_idx`(`application_id`, `name`),
    INDEX `equipments_created_at_idx`(`created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `equipment_tags` (
    `id` VARCHAR(40) NOT NULL,
    `equipment_id` VARCHAR(40) NULL,
    `key` VARCHAR(191) NOT NULL,
    `value` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `deleted_at` DATETIME(3) NULL,

    INDEX `equipment_tags_equipment_id_key_value_idx`(`equipment_id`, `key`, `value`),
    INDEX `equipment_tags_key_equipment_id_value_idx`(`key`, `equipment_id`, `value`),
    INDEX `equipment_tags_key_value_equipment_id_idx`(`key`, `value`, `equipment_id`),
    INDEX `equipment_tags_created_at_idx`(`created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `service_tokens` (
    `token` VARCHAR(40) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `expiration_date` DATETIME(3) NOT NULL,
    `enabled` BOOLEAN NOT NULL DEFAULT true,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,

    PRIMARY KEY (`token`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `trigger_types` (
    `id` VARCHAR(40) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,

    INDEX `trigger_types_name_idx`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `action_types` (
    `id` VARCHAR(40) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,

    INDEX `action_types_name_idx`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `actions` (
    `id` VARCHAR(40) NOT NULL,
    `name` VARCHAR(40) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `application_id` VARCHAR(40) NOT NULL,
    `trigger_type_id` VARCHAR(40) NOT NULL,
    `action_type_id` VARCHAR(40) NOT NULL,
    `trigger_config` JSON NOT NULL,
    `action_config` JSON NOT NULL,
    `enabled` BOOLEAN NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `deleted_at` DATETIME(3) NULL,

    INDEX `actions_application_id_trigger_type_id_action_type_id_idx`(`application_id`, `trigger_type_id`, `action_type_id`),
    INDEX `actions_application_id_action_type_id_trigger_type_id_idx`(`application_id`, `action_type_id`, `trigger_type_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `device_types` ADD CONSTRAINT `device_types_network_id_fkey` FOREIGN KEY (`network_id`) REFERENCES `networks`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `device_types_parser_versions` ADD CONSTRAINT `device_types_parser_versions_device_type_id_fkey` FOREIGN KEY (`device_type_id`) REFERENCES `device_types`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `networks` ADD CONSTRAINT `networks_network_type_id_fkey` FOREIGN KEY (`network_type_id`) REFERENCES `network_types`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `networks_parser_versions` ADD CONSTRAINT `networks_parser_versions_network_id_fkey` FOREIGN KEY (`network_id`) REFERENCES `networks`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `devices` ADD CONSTRAINT `devices_device_type_id_fkey` FOREIGN KEY (`device_type_id`) REFERENCES `device_types`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `devices` ADD CONSTRAINT `devices_equipment_id_fkey` FOREIGN KEY (`equipment_id`) REFERENCES `equipments`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `devices_parser_versions` ADD CONSTRAINT `devices_parser_versions_device_id_fkey` FOREIGN KEY (`device_id`) REFERENCES `devices`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `equipment_tags` ADD CONSTRAINT `equipment_tags_equipment_id_fkey` FOREIGN KEY (`equipment_id`) REFERENCES `equipments`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `actions` ADD CONSTRAINT `actions_trigger_type_id_fkey` FOREIGN KEY (`trigger_type_id`) REFERENCES `trigger_types`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `actions` ADD CONSTRAINT `actions_action_type_id_fkey` FOREIGN KEY (`action_type_id`) REFERENCES `action_types`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
