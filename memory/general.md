# General Notes

- [2026-03-20] When posting inline GitLab MR comments with `glab api`, use `POST .../merge_requests/<MR_ID>/discussions` with `Content-Type: application/json` and a JSON `position` object. Form-encoded `-f position[...]` requests can create plain `DiscussionNote` comments instead of inline `DiffNote`s. Verify success by checking the API response note `type` is `DiffNote`.
