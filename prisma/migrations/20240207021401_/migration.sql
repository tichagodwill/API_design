/*
  Warnings:

  - The values [ARCHIVED] on the enum `UPDATE_STATUS` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `createAt` on the `User` table. All the data in the column will be lost.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "UPDATE_STATUS_new" AS ENUM ('IN_PROGRESS', 'SHIPPED', 'DEPRECATED');
ALTER TABLE "Update" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "Update" ALTER COLUMN "status" TYPE "UPDATE_STATUS_new" USING ("status"::text::"UPDATE_STATUS_new");
ALTER TYPE "UPDATE_STATUS" RENAME TO "UPDATE_STATUS_old";
ALTER TYPE "UPDATE_STATUS_new" RENAME TO "UPDATE_STATUS";
DROP TYPE "UPDATE_STATUS_old";
ALTER TABLE "Update" ALTER COLUMN "status" SET DEFAULT 'IN_PROGRESS';
COMMIT;

-- AlterTable
ALTER TABLE "Update" ALTER COLUMN "title" SET DATA TYPE TEXT,
ALTER COLUMN "asset" DROP NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "createAt",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;
