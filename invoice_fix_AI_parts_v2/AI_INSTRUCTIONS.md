# AI INSTRUCTIONS — Split HTML Repository

## Purpose

This repository stores one HTML application as multiple small source parts so AI coding agents can fetch and reason about the code efficiently through GitHub.

**All numbered `.html` parts are fragments of ONE HTML document. They are not independent HTML pages or modules.**

Read this file before modifying the split source.

---

## 1. Source model

Conceptually:

```text
01 → 02 → 03 → ... → N
             ↓
      ONE complete HTML
```

The physical split exists only for source organization and AI retrieval.

Do not treat a part as independently runnable HTML.

A part may legitimately begin or end:

- in the middle of an HTML tag
- in the middle of CSS
- in the middle of JavaScript
- in the middle of a quoted string
- in the middle of a Base64/data URI

That is expected.

---

## 2. Read the repository map first

Before making a non-trivial change:

1. Read `README_AI.md`.
2. Read `MANIFEST.json`.
3. Use the manifest to determine the exact part order.
4. Fetch only the relevant parts when possible.
5. If code crosses a boundary, fetch the adjacent part(s).

Do not guess the structure from filenames alone.

---

## 3. Never assume a part is complete

For example:

```text
06-javascript-a.html
07-javascript-b.html
```

may contain one function whose source crosses the boundary.

If a statement, string, tag, function, object, or expression looks incomplete at the end of a part, **fetch the next part before diagnosing an error**.

Likewise, inspect the previous part if the beginning looks incomplete.

---

## 4. Preserve boundaries

Do not casually move content between parts.

Do not:

- add closing tags because a fragment appears incomplete
- add opening tags to make a fragment standalone
- remove characters at the beginning/end of a part
- reorder numbered parts
- re-split the source unnecessarily
- normalize or rewrite unrelated content

The boundary is part of the storage format.

---

## 5. Base64 and inline assets

Long Base64/data URI strings may span multiple parts.

Treat them as opaque source data.

Do not:

- decode/re-encode them
- change whitespace inside them
- normalize them
- truncate them
- replace quotes around them
- beautify them

unless the user explicitly asks for an asset change.

---

## 6. Targeted fetching strategy

For a small task, prefer:

```text
README_AI.md
      ↓
MANIFEST.json
      ↓
relevant part
      ↓
previous/next part if boundary context is needed
```

For a large refactor, debugging task, architecture change, or uncertain dependency, read all relevant parts.

Do not fetch the entire repository by default if the task can be solved safely with a smaller context.

---

## 7. Understand dependencies before editing

Before changing a function, variable, selector, event handler, or UI element:

1. Locate its definition.
2. Locate important callers/usages.
3. Check related state/data.
4. Check whether the implementation crosses a part boundary.
5. Check dependent parts when necessary.

Do not infer that a similarly named function or variable is unrelated without checking context.

---

## 8. Minimal-change rule

When fixing a bug or implementing a focused request:

```text
Understand → Change the smallest necessary area → Validate
```

Avoid unrelated refactoring, formatting, renaming, minification, or cleanup.

Preserve existing behavior unless the requested task explicitly changes it.

---

## 9. UI changes

If the user asks for a UI-only change, preserve:

- application logic
- state/data model
- event behavior
- APIs
- existing workflows
- split boundaries

unless the UI request necessarily requires a logic change.

---

## 10. JavaScript changes

Before modifying JavaScript, determine whether the relevant function or object continues into another part.

Example:

```text
PART 06
function updateSomething() {
    const value = ...

PART 07
    if (value) {
        ...
    }
}
```

This is one continuous source fragment, not a syntax error.

Analyze the combined logical source before editing.

---

## 11. Do not use part names as module names

Names such as:

```text
06-javascript-a.html
07-javascript-b.html
```

describe source locations only.

Do not invent `import`, `export`, `require`, or other module relationships unless they actually exist in the source.

---

## 12. Adding a new part

Only create a new numbered part when necessary.

If you do:

1. Preserve numeric order.
2. Use a descriptive filename.
3. Update `MANIFEST.json`.
4. Update `README_AI.md` if the workflow/structure changes.
5. Keep each part near the target size.
6. Validate the rebuilt HTML.

Do not renumber existing parts casually.

---

## 13. Rebuilding

The split parts are source fragments.

When a complete HTML file is required, concatenate them **in manifest order**.

Use the repository's provided rebuild mechanism when available:

```text
rebuild.bat
rebuild.py
```

Do not concatenate files alphabetically unless that exactly matches `MANIFEST.json`.

---

## 14. Validation

After a structural or significant change:

- rebuild the complete HTML
- verify that the output exists
- verify that the document structure is intact
- verify that scripts and styles remain present
- verify that inline assets remain intact
- check for accidental boundary corruption
- review the diff and ensure unrelated sections were not changed

For a small isolated edit, full rebuild validation may still be appropriate if the edited code is near a boundary.

---

## 15. Reporting changes

When reporting a change, identify:

```text
Part:
06-javascript-a.html

Area:
function updateSomething()

Changed:
...

Related part(s):
07-javascript-b.html
```

If a change crosses a boundary, explicitly say so.

---

## 16. Priority of evidence

When understanding the repository, use this order:

```text
Actual source
   ↓
MANIFEST.json
   ↓
README_AI.md
   ↓
AI assumptions
```

Never invent missing structure.

If the available source does not establish something, say that it is uncertain and fetch more context when possible.

---

## 17. Golden rule

> **Treat every numbered HTML part as a fragment of one source file. Fetch enough neighboring context to understand boundaries, make the smallest safe change, and validate the rebuilt document when needed.**
