// regex.ts

// Email regex
export const emailRegex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@(([^<>()[\]\\.,;:\s@"]+\.)+[^<>()[\]\\.,;:\s@"]{2,})$/i;

// First and Last Name regex
export const firstNameRegex = /^[A-Za-zÀ-ÖØ-öø-ÿ-]{2,50}$/;
export const lastNameRegex = /^[A-Za-zÀ-ÖØ-öø-ÿ-]{2,50}$/;

// Password validation regexes
export const minLengthPasswdRegex = /.{8,}/; // 8 or more characters
export const oneLowerCasePasswdRegex = /[a-z]/;
export const oneUpperCasePasswdRegex = /[A-Z]/;
export const oneDigitPasswdRegex = /\d/;
export const oneSpecialCharPasswdRegex = /[@$!%*?&]/;
export const authorizedCharsPasswdRegex = /^[A-Za-z\d@$!%*?&]+$/;

// City and Postal Code
export const cityRegex = /^[a-zA-Z\s-']*$/;
export const postalCodeRegex = /^[0-9]+$/;