SELECT quantityOnHand
FROM item
WHERE itemDescription LIKE '%antibiotics%';
###

SELECT volunteerName
FROM volunteer
WHERE volunteerTelephone NOT LIKE '2%'
  AND volunteerName NOT LIKE '%Jones%';
###

SELECT DISTINCT v.volunteerName
FROM volunteer v
JOIN assignment a ON v.volunteerId = a.volunteerId
JOIN task t ON a.taskCode = t.taskCode
JOIN task_type tt ON t.taskTypeId = tt.taskTypeId
WHERE tt.taskTypeName = 'transporting';
###

SELECT t.taskDescription
FROM task t
LEFT JOIN assignment a ON t.taskCode = a.taskCode
WHERE a.taskCode IS NULL;
###

SELECT DISTINCT pt.packageTypeName
FROM package_type pt
JOIN package p ON pt.packageTypeId = p.packageTypeId
JOIN package_contents pc ON p.packageId = pc.packageId
JOIN item i ON pc.itemId = i.itemId
WHERE i.itemDescription LIKE '%bottle%';
###

SELECT itemDescription
FROM item
WHERE itemId NOT IN (
    SELECT itemId FROM package_contents
);
###

SELECT DISTINCT t.taskDescription
FROM task t
JOIN assignment a ON t.taskCode = a.taskCode
JOIN volunteer v ON a.volunteerId = v.volunteerId
WHERE v.volunteerAddress LIKE '%NJ%';
###

SELECT DISTINCT v.volunteerName
FROM volunteer v
JOIN assignment a ON v.volunteerId = a.volunteerId
WHERE a.startDateTime BETWEEN '2021-01-01' AND '2021-06-30';
###

SELECT DISTINCT i.itemDescription
FROM item i
JOIN package_contents pc ON i.itemId = pc.itemId
GROUP BY pc.packageId, i.itemId
HAVING SUM(i.itemValue * pc.itemQuantity) = 100;
###

SELECT ts.taskStatusName, COUNT(a.volunteerId) AS numVolunteers
FROM task_status ts
JOIN task t ON ts.taskStatusId = t.taskStatusId
JOIN assignment a ON t.taskCode = a.taskCode
GROUP BY ts.taskStatusName
ORDER BY numVolunteers DESC;
###

SELECT taskCode, SUM(packageWeight) AS totalWeight
FROM package
GROUP BY taskCode
ORDER BY totalWeight DESC
LIMIT 1;
###

SELECT COUNT(*)
FROM task t
JOIN task_type tt ON t.taskTypeId = tt.taskTypeId
WHERE tt.taskTypeName <> 'packing';
###

SELECT i.itemDescription
FROM item i
JOIN package_contents pc ON i.itemId = pc.itemId
JOIN package p ON pc.packageId = p.packageId
JOIN task t ON p.taskCode = t.taskCode
JOIN assignment a ON t.taskCode = a.taskCode
GROUP BY i.itemId
HAVING COUNT(DISTINCT a.volunteerId) < 3;
###

SELECT pc.packageId, SUM(i.itemValue * pc.itemQuantity) AS totalValue
FROM package_contents pc
JOIN item i ON pc.itemId = i.itemId
GROUP BY pc.packageId
HAVING totalValue > 100
ORDER BY totalValue ASC;
