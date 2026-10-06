# Setup

## :a: Class - INF1084-202-26A-06 - Introduction à l'administration des systèmes

```
https://${LMS_URL}/course/view.php?id=9
```

## :b: Assignments for:

- [ ] courseids[0]=9

- [ ] Retrieve all assignments from LMS

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=mod_assign_get_assignments" \
-d "moodlewsrestformat=json" \
-d "courseids[0]=9" | jq '.courses[].assignments[] | {id, cmid, name}'
```
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1704    0  1587  100   117   2463    181 --:--:-- --:--:-- --:--:--  2645
```
<details><summary>📑</summary>

```json
{
  "id": 53,
  "cmid": 61,
  "name": "0.PlanDeCours"
}

```

</details>
