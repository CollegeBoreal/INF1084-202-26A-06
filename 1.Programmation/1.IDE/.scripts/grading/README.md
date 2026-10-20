# Setup

## :a: LMS Assignment ID = 36

```
https://${LMS_URL}/mod/assign/view.php?id=32
```

```json
{
  "id": 37,        // LMS Assignment ID
  "cmid": 42,      // Rubric Definition CMID
  "name": "1.IDE". // Assignment name
}
```

## :b: Rubric Definition for

- [ ] cmids[0]=42

- [ ] Retrieve all rubric definitions from LMS

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=42" \
-d "areaname=submissions" | jq .
```
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  2397    0  2261  100   136   3849    231 --:--:-- --:--:-- --:--:--  4076
```
<details><summary>📑</summary>

```json
100  1048    0   911  100   137   1610    242 --:--:-- --:--:-- --:--:--  1851
{
  "areas": [
    {
      "cmid": 42,
      "contextid": 531,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 36,
          "method": "rubric",
          "name": "Participation",
          "description": "Plan De Cours",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1782691448,
          "usercreated": 3,
          "timemodified": 1782691448,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 188,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 433,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 434,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 435,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 189,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 436,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 437,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              }
            ]
          }
        }
      ]
    }
  ],
  "warnings": []
}
```

</details>