import { betterAuth } from "better-auth";

/* default adapter
PERF: Only use if perf is bad

import { Pool } from "pg";

export const auth = betterAuth({
	database: new Pool({
		host: process.env.DATABASE_HOST,
		user: process.env.DATABASE_USER,
		database: process.env.DATABASE_NAME,
	}),
});
*/

import { prismaAdapter } from "better-auth/adapters/prisma";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();
export const auth = betterAuth({
	database: prismaAdapter(prisma, {
		provider: "postgresql", // or "mysql", "postgresql", ...etc
	}),
	socialProviders: {
		google: {
			clientId: process.env.GOOGLE_CLIENT_ID as string,
			clientSecret: process.env.GOOGLE_CLIENT_SECRET as string,
		},
	},
});
