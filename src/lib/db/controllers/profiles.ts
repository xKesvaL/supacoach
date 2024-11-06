import type { Profile } from "@prisma/client";
import type { Getter } from "./default";
import { prisma } from "..";

export const getProfiles: Getter<Profile[]> = async () => {
	const profiles = await prisma.profile.findMany();

	return profiles;
};
