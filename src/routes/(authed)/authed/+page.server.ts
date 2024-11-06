import { getProfiles } from "$lib/db/controllers/profiles";

export const load = async () => {
	const profiles = getProfiles();

	return {
		profiles,
	};
};
