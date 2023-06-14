-- Create patients table
CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL
);

-- Create medical_histories table
CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INT REFERENCES patients(id) ON UPDATE CASCADE ON DELETE CASCADE,
  status VARCHAR(50) NOT NULL
);

-- Create invoices table
CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  total_amount DECIMAL(10, 2) NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP NOT NULL,
  medical_history_id INT REFERENCES medical_histories(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  unit_price DECIMAL(10, 2) NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  invoice_id INT REFERENCES invoices(id) ON UPDATE CASCADE ON DELETE CASCADE,
  treatment_id INT REFERENCES treatments(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE treatments (
  id SERIAL PRIMARY KEY NOT NULL,
  type varchar(255),
  name  varchar(255)
);

CREATE TABLE medical_histories_treatments (
  id SERIAL PRIMARY KEY NOT NULL, 
  medical_histories_id int REFERENCES medical_histories(id),
  treatment_id int REFERENCES treatment(id)
);

-- Add foreign key indexes
CREATE INDEX medical_histories_patient_id ON medical_histories(patient_id ASC);

CREATE INDEX invoices_medical_history_id ON invoices(medical_history_id ASC);

CREATE INDEX invoice_items_invoice_id ON invoice_items(invoice_id ASC);

CREATE INDEX invoice_items_treatment_id ON invoice_items(treatment_id ASC);

CREATE INDEX medical_histories_treatements_medhis_id ON medical_histories_treatments(medical_histories_id ASC);

CREATE INDEX medical_histories_treatements_treat_id ON medical_histories_treatments(treatmemt_id ASC);