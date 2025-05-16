-- Get all visits with doctor and patient names
SELECT 
    v.id AS visit_id,
    d.name AS doctor,
    p.name AS patient,
    v.visit_date
FROM visits v
JOIN doctors d ON v.doctor_id = d.id
JOIN patients p ON v.patient_id = p.id;

-- List all diseases diagnosed for a given patient
SELECT 
    p.name AS patient,
    d2.name AS disease,
    v.visit_date
FROM diagnoses dx
JOIN visits v ON dx.visit_id = v.id
JOIN diseases d2 ON dx.disease_id = d2.id
JOIN patients p ON v.patient_id = p.id
WHERE p.name = 'John Smith';

-- Count how many patients each doctor has seen
SELECT 
    d.name AS doctor,
    COUNT(DISTINCT v.patient_id) AS total_patients
FROM doctors d
JOIN visits v ON d.id = v.doctor_id
GROUP BY d.name;

-- List all patients who have had more than one visit
SELECT 
    p.name AS patient,
    COUNT(v.id) AS visit_count
FROM patients p
JOIN visits v ON p.id = v.patient_id
GROUP BY p.name
HAVING COUNT(v.id) > 1;