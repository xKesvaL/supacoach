import { Elysia } from "elysia";
import { logger } from "@bogeychan/elysia-logger";
import { swagger } from "@elysiajs/swagger";
import { bearer } from "@elysiajs/bearer";
import { cors } from "@elysiajs/cors";
import { serverTiming } from "@elysiajs/server-timing";
import { prisma } from "./db";
import { auth } from "./lib/auth";

const app = new Elysia()
	.use(logger())
	.use(swagger())
	.use(bearer())
	.use(
		cors({
			origin: true,
		}),
	)
	.use(serverTiming())
	.onParse(({ request, route }) => {
		if (route.startsWith("/api/auth")) {
			return request.body;
		}
	})
	.all("/api/auth/*", ({ request }) => {
		return auth.handler(request);
	});

await prisma.$connect();
console.log("🗄️ Database was connected!");

app.listen(process.env.PORT as string, () =>
	console.log(`🦊 Server started at ${app.server?.url.origin}`),
);
