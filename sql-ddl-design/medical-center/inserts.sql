-- Insert doctors
INSERT INTO doctors (name, specialty)
VALUES 
    ('Dr. Alice Walker', 'Cardiology'),
    ('Dr. Brian Lee', 'Neurology'),
    ('Dr. Carla Gomez', 'General Practice');

-- Insert patients
INSERT INTO patients (name, dob)
VALUES 
    ('John Smith', '1980-05-22'),
    ('Emily Tran', '1995-10-08'),
    ('Marcus King', '2001-01-12');

-- Insert visits
INSERT INTO visits (doctor_id, patient_id, visit_date)
VALUES 
    (1, 1, '2024-03-15'),  -- Dr. Alice sees John
    (2, 1, '2024-04-01'),  -- Dr. Brian sees John
    (3, 2, '2024-03-25'),  -- Dr. Carla sees Emily
    (3, 3, '2024-04-05');  -- Dr. Carla sees Marcus

-- Insert diseases
INSERT INTO diseases (name, description)
VALUES 
    ('Hypertension', 'High blood pressure'),
    ('Migraine', 'Chronic headache'),
    ('Common Cold', 'Viral respiratory infection');

-- Link visits to diseases (diagnoses)
INSERT INTO diagnoses (visit_id, disease_id)
VALUES 
    (1, 1),  -- John's cardiology visit diagnosed with Hypertension
    (2, 2),  -- John's neurology visit diagnosed with Migraine
    (3, 3),  -- Emily had a cold
    (4, 3);  -- Marcus had a cold too