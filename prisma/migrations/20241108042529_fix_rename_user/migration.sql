/*
  Warnings:

  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "programs" DROP CONSTRAINT "programs_creatorId_fkey";

-- DropForeignKey
ALTER TABLE "user_programs" DROP CONSTRAINT "user_programs_userId_fkey";

-- DropTable
DROP TABLE "users";

-- CreateTable
CREATE TABLE "profiles" (
    "id" UUID NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'user',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "profiles_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "user_programs" ADD CONSTRAINT "user_programs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "programs" ADD CONSTRAINT "programs_creatorId_fkey" FOREIGN KEY ("creatorId") REFERENCES "profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;
