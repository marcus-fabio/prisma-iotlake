/*
  Warnings:

  - You are about to alter the column `execution_id` on the `analysis_logs` table. The data in that column could be lost. The data in that column will be cast from `VarChar(768)` to `VarChar(100)`.

*/
-- AlterTable
ALTER TABLE `analysis_logs` MODIFY `execution_id` VARCHAR(100) NOT NULL;
