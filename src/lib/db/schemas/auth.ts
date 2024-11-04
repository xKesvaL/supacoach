import { z } from "zod";

export const authWithEmailSchema = z.object({
	email: z.string().email(),
	password: z.string().min(8),
});

export type AuthWithEmailSchema = typeof authWithEmailSchema;
