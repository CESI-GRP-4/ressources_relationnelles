import { defineConfig } from "cypress";

export default defineConfig({
       viewportHeight: 1080,
       viewportWidth: 1920,
       projectId: "asc3u7",
       scrollBehavior: "nearest",
       e2e: {
              setupNodeEvents(on, config) {
                     // implement node event listeners here

              },
       },
});
