# Page Structure in Next.js

## Routable Pages
This folder should contain **folders that represent routable pages. Each folder _MUST_ contain a "page.tsx" file**, for example:

- "pages/profil/page.tsx"
- "pages/login/page.tsx"

## Main Page
The "page.tsx" file in this folder (src/app/) represents the main page of the application (equivalent of an index.XXX file), accessible at "http://localhost:3000" or "http(s)://domain.com/".

## Layouts in Pages
Note that each folder can contain a "layout.tsx" file. If there is indeed a "layout.tsx" file, it will be wrapped inside its parent layout (if there is one). It is useful for nested routes.

## Common File Patterns
This pattern exists for other files:

- default.js
- error.js
- layout.js
- loading.js
- not-found.js
- page.js
- route.js
- ...

See documentation: [Next.js Documentation](https://nextjs.org/docs/app/api-reference/file-conventions)