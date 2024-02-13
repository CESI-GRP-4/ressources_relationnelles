import type User from "@/types/user";

export default interface LogInAndSignUpResponse {
       user: User,
       newUser: boolean,
};
