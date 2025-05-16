-- Create doctors table
CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    specialty TEXT
);

-- Create patients table
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    dob DATE
);

-- Create visits table (many-to-many between doctors and patients)
CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    doctor_id INTEGER NOT NULL REFERENCES doctors(id),
    patient_id INTEGER NOT NULL REFERENCES patients(id),
    visit_date DATE NOT NULL
);

-- Create diseases table
CREATE TABLE diseases (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT
);

-- Join table between visits and diseases
CREATE TABLE diagnoses (
    visit_id INTEGER NOT NULL REFERENCES visits(id),
    disease_id INTEGER NOT NULL REFERENCES diseases(id),
    PRIMARY KEY (visit_id, disease_id)
);