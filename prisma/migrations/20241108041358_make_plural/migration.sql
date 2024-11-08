/*
  Warnings:

  - You are about to drop the `nutrition_program` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `profile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `program` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `training_program` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user_program` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "nutrition_program" DROP CONSTRAINT "nutrition_program_programId_fkey";

-- DropForeignKey
ALTER TABLE "profile" DROP CONSTRAINT "profile_userId_fkey";

-- DropForeignKey
ALTER TABLE "program" DROP CONSTRAINT "program_creatorId_fkey";

-- DropForeignKey
ALTER TABLE "training_program" DROP CONSTRAINT "training_program_programId_fkey";

-- DropForeignKey
ALTER TABLE "user_program" DROP CONSTRAINT "user_program_programId_fkey";

-- DropForeignKey
ALTER TABLE "user_program" DROP CONSTRAINT "user_program_userId_fkey";

-- DropTable
DROP TABLE "nutrition_program";

-- DropTable
DROP TABLE "profile";

-- DropTable
DROP TABLE "program";

-- DropTable
DROP TABLE "training_program";

-- DropTable
DROP TABLE "user";

-- DropTable
DROP TABLE "user_program";

-- CreateTable
CREATE TABLE "users" (
    "id" UUID NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'user',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "profiles" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,

    CONSTRAINT "profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_programs" (
    "userId" UUID NOT NULL,
    "programId" UUID NOT NULL,
    "enrolledAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" "UserProgramStatus" NOT NULL DEFAULT 'active',

    CONSTRAINT "user_programs_pkey" PRIMARY KEY ("userId","programId")
);

-- CreateTable
CREATE TABLE "programs" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "creatorId" UUID NOT NULL,

    CONSTRAINT "programs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "training_programs" (
    "programId" UUID NOT NULL,

    CONSTRAINT "training_programs_pkey" PRIMARY KEY ("programId")
);

-- CreateTable
CREATE TABLE "nutrition_programs" (
    "programId" UUID NOT NULL,

    CONSTRAINT "nutrition_programs_pkey" PRIMARY KEY ("programId")
);

-- AddForeignKey
ALTER TABLE "profiles" ADD CONSTRAINT "profiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_programs" ADD CONSTRAINT "user_programs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_programs" ADD CONSTRAINT "user_programs_programId_fkey" FOREIGN KEY ("programId") REFERENCES "programs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "programs" ADD CONSTRAINT "programs_creatorId_fkey" FOREIGN KEY ("creatorId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "training_programs" ADD CONSTRAINT "training_programs_programId_fkey" FOREIGN KEY ("programId") REFERENCES "programs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "nutrition_programs" ADD CONSTRAINT "nutrition_programs_programId_fkey" FOREIGN KEY ("programId") REFERENCES "programs"("id") ON DELETE CASCADE ON UPDATE CASCADE;
