# Setup

## :a: LMS Assignment ID = 53

```
https://${LMS_URL}/mod/assign/view.php?id=32
```

```json
{
  "id": 53,                // Assignment ID
  "cmid": 61,              // Rubric Definition CMID
  "name": "0.PlanDeCours". // Assignment name
}
```

## :b: Rubric Definition for

- [ ] cmids[0]=61

- [ ] Retrieve all rubric definitions from LMS

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=61" \
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
      "cmid": 61,
      "contextid": 631,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 52,
          "method": "rubric",
          "name": "Participation",
          "description": "Plan De Cours",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1790437209,
          "usercreated": 2,
          "timemodified": 1790437209,
          "usermodified": 2,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 232,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 562,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 563,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 564,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 233,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 565,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 566,
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