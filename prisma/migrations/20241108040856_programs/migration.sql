/*
  Warnings:

  - You are about to drop the column `role` on the `profile` table. All the data in the column will be lost.
  - Added the required column `userId` to the `profile` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "UserProgramStatus" AS ENUM ('active', 'completed', 'cancelled');

-- AlterTable
ALTER TABLE "profile" DROP COLUMN "role",
ADD COLUMN     "userId" UUID NOT NULL;

-- CreateTable
CREATE TABLE "user" (
    "id" UUID NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'user',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_program" (
    "userId" UUID NOT NULL,
    "programId" UUID NOT NULL,
    "enrolledAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" "UserProgramStatus" NOT NULL DEFAULT 'active',

    CONSTRAINT "user_program_pkey" PRIMARY KEY ("userId","programId")
);

-- CreateTable
CREATE TABLE "program" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "creatorId" UUID NOT NULL,

    CONSTRAINT "program_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "training_program" (
    "programId" UUID NOT NULL,

    CONSTRAINT "training_program_pkey" PRIMARY KEY ("programId")
);

-- CreateTable
CREATE TABLE "nutrition_program" (
    "programId" UUID NOT NULL,

    CONSTRAINT "nutrition_program_pkey" PRIMARY KEY ("programId")
);

-- AddForeignKey
ALTER TABLE "profile" ADD CONSTRAINT "profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_program" ADD CONSTRAINT "user_program_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_program" ADD CONSTRAINT "user_program_programId_fkey" FOREIGN KEY ("programId") REFERENCES "program"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "program" ADD CONSTRAINT "program_creatorId_fkey" FOREIGN KEY ("creatorId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "training_program" ADD CONSTRAINT "training_program_programId_fkey" FOREIGN KEY ("programId") REFERENCES "program"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "nutrition_program" ADD CONSTRAINT "nutrition_program_programId_fkey" FOREIGN KEY ("programId") REFERENCES "program"("id") ON DELETE CASCADE ON UPDATE CASCADE;
