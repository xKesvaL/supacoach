import { Hono } from "hono";
import { auth } from "./lib/auth";
import { cors } from "hono/cors";

const app = new Hono();

app.use(
	cors({
		origin: ["http://localhost:5173"],
		allowMethods: ["GET", "POST", "PUT", "DELETE", "PATCH"],
		allowHeaders: ["Content-Type", "Authorization"],
		credentials: true,
	}),
);

app.get("/", (c) => {
	return c.text("Hello Hono!");
});

app.on(["POST", "GET"], "/api/auth/**", (c) => {
	return auth.handler(c.req.raw);
});

export default app;
