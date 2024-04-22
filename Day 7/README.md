## Problem Statement

### ❓Find out all the employees who worked in particular projects.

➡️You have Company Database with two tables: <b>Employees</b> and <b>Tasks</b>

➡️See below the table schemas and data within.

<b>Employees</b>▶️
| task_id | task_name | emp_id | project_id |
|---------|-----------|--------|------------|
| 201     | TaskA     | 1      | 101        |
| 202     | TaskB     | 2      | 102        |
| 203     | TaskC     | 1      | 103        |
| 204     | TaskD     | 4      | 102        |
| 205     | TaskE     | 3      | 101        |
| 206     | TaskF     | 1      | 105        |
| 207     | TaskG     | 3      | 107        |
| 208     | TaskH     | 6      | 106        |
| 209     | TaskI     | 2      | 104        |
| 210     | TaskJ     | 7      | 108        |
| 211     | TaskK     | 1      | 105        |
| 212     | TaskL     | 5      | 103        |
| 213     | TaskM     | 3      | 106        |
| 214     | TaskN     | 4      | 104        |
| 215     | TaskO     | 5      | 108        |


<b>Tasks</b>▶️
| task_id | task_name | emp_id | project_id |
|---------|-----------|--------|------------|
| 201     | TaskA     | 1      | 101        |
| 202     | TaskB     | 2      | 102        |
| 203     | TaskC     | 1      | 103        |
| 204     | TaskD     | 4      | 102        |
| 205     | TaskE     | 3      | 101        |
| 206     | TaskF     | 1      | 105        |
| 207     | TaskG     | 3      | 107        |
| 208     | TaskH     | 6      | 106        |
| 209     | TaskI     | 2      | 104        |
| 210     | TaskJ     | 7      | 108        |
| 211     | TaskK     | 1      | 105        |
| 212     | TaskL     | 5      | 103        |
| 213     | TaskM     | 3      | 106        |
| 214     | TaskN     | 4      | 104        |
| 215     | TaskO     | 5      | 108        |

<b>Output⬇️</b>

<img width="360" alt="Screenshot 2024-04-22 222551" src="https://github.com/HeatTransfer/SQL_Mastery_Marathon/assets/53636141/42c6c948-b3df-4664-8027-81ba1b80d12c">
